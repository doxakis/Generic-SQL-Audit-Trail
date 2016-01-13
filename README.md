# Generic SQL Audit Trail
A generic audit trail based on triggers and dynamic SQL.

The SQL trigger has been designed to analyze your table. So, the database schema can change over time and it still works fine.

Whenever you add new table(s), you just have to run again the SQL script.

For more detail, please read this post: https://doxakis.com/2015/12/17/SQL-Script-Audit/

## Setup
- Execute the script: Audit trail script for SQL Server Database.sql on the selected database in Microsoft SQL Server Management Studio.
- Check the printed messages and make sure the query has been executed successfully.

## Customization:
	You can exclude tables in the script.
	- Follow comments in the script: "Specify table to exclude here:"

## Limitations:
	- Audit table is "Audit"
	- Audit trigger start with "tr_audit_"
	- Do not support datatype: image (Based on https://msdn.microsoft.com/en-us/library/ms187928.aspx)

## Steps
- Remove all triggers starting with "tr_audit_"
- Add "Audit" table if not found on the database
- Add triggers for almost all tables (this can be customized).

## Copyright and license
Code released under the MIT licence.
