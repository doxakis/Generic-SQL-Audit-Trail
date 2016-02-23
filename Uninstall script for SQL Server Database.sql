-- The MIT License (MIT)
-- 
-- Copyright (c) 2015 Philip Doxakis
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

/*
Script Name:
    Uninstall script for SQL Server Database
Author:
    Philip Doxakis
Description:
	Uninstall the audit trail script.
	It removes only the triggers. The Audit table must be deleted manually.
		(It is to prevent accidental delete.)
	Optional: Add "USE [DatabaseName];" at the top of the script.
Step:
	- Remove all triggers starting with "tr_audit_"
	- Remove the database trigger "tr_database_audit"
*/


PRINT 'Starting: Removing all triggers starting with tr_audit_'
DECLARE @TriggerName VARCHAR(255);
DECLARE MY_CURSOR_FOR_TRIGGER CURSOR
	LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR
	-- Get list of trigger in current database
	SELECT
		 sysobjects.name AS trigger_name
	FROM sysobjects
	WHERE
		sysobjects.type = 'TR' AND
		sysobjects.name LIKE 'tr_audit_%'
OPEN MY_CURSOR_FOR_TRIGGER
FETCH NEXT FROM MY_CURSOR_FOR_TRIGGER INTO @TriggerName
WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @sql VARCHAR(250)
    
    -- Remove current trigger
    SET @sql = 'DROP TRIGGER ' + @TriggerName
    PRINT 'Removing trigger: ' + @TriggerName
    EXEC (@sql)
    
    FETCH NEXT FROM MY_CURSOR_FOR_TRIGGER INTO @TriggerName
END
CLOSE MY_CURSOR_FOR_TRIGGER
DEALLOCATE MY_CURSOR_FOR_TRIGGER
PRINT 'Finished: Removing all triggers starting with tr_audit_'
PRINT ''

PRINT 'Starting: Removing trigger tr_database_audit'
IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'tr_database_audit'
     AND parent_class_desc = N'DATABASE'
)
	DROP TRIGGER tr_database_audit ON DATABASE
PRINT 'Finished: Removing trigger tr_database_audit'

PRINT ''
PRINT 'Finished!'