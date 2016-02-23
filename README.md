# Generic SQL Audit Trail
A generic audit trail based on triggers and dynamic SQL.

The SQL trigger has been designed to analyze your table. So, the database schema can change over time and it still works fine.

Whenever you add new table(s), you don't have to run again the SQL script. The database trigger tr_database_audit listens for new table(s) and add the audit trigger to new table(s).

For more detail, please read this post: https://doxakis.com/2015/12/17/SQL-Script-Audit/

# Setup
- Execute the script: Install audit trail script for SQL Server Database.sql on the selected database in Microsoft SQL Server Management Studio.
- Check the printed messages and make sure the query has been executed successfully.

# Uninstall
- Execute the script: Uninstall script for SQL Server Database.sql
- Remove manually the Audit table.

# Copyright and license
Code released under the MIT licence.
