**Note: All SQL code written for SSMS/SQL Server.**

**__Contents:__**

**Date-Formats_Job-Scripts-Server-Scripts**
   This file contains code snippets for creating variables or selecting a date format not native to SSMS, updating jobs, and misc. db/server scripts.

**Find-Table-Column-Sproc.sql**
   This file contains code snippets for looking up tables, columns, and sprocs in databases.
   It also contains code to look up additional attributes about columns and objects.

**Get-Academic-Year.sql**
   This code is similar to code from a mapping project where the academic year for a specific semester was a primary key in an external system.
   The academic year did not exist in the database and needed to be created on the fly.

**Mutiple-Records-Per-ID-Into-One-Using-Stuff.sql**
   This code uses the keyword STUFF to take multiple records and make it one semi-colon separated value for each ID.

**Update-Loop.sql**
   This code updates records based on the IDs found in a temp table of the target population without deleting the rows in the temp table.
   It uses the min(ID) to figure out what record to update next, then when it runs out of IDs, min(ID) becomes a NULL value and exits the loop.

