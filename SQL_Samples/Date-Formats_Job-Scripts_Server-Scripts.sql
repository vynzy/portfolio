---- View Linked Servers
sp_linkedservers

---- Sample 4-part name call: 
EXEC  [ServerName].[DatabaseName].dbo.sp_HelpText 'storedProcName'

---- School Year Format 2018-19 into variable
DECLARE @SchoolYear1 AS VARCHAR(10) = 
	(SELECT CAST(DATEPART(YYYY, GETDATE()) AS VARCHAR(4)) 
			+ '-' 
			+ RIGHT(CAST(DATEPART(YYYY, GETDATE())+1 AS VARCHAR(4)),2)
	)

---- 24hr Clock
SELECT GETDATE(), CONVERT(VARCHAR(16), getdate(), 110) + space(1) + CONVERT(VARCHAR(5), getdate(), 114)

---- Drop/Add DB if exists
USE master
GO

IF EXISTS 
	(SELECT TOP 1 * 
	 FROM sys.sysdatabases
	 WHERE [name] = 'myDB'
	)
DROP DATABASE myDB
GO

CREATE DATABASE myDB
GO

USE myDB
GO

---- Jobs
USE msdb ;  
GO 

/*This grabs the jobid based on the Job Name. This variable is used through the code for jobs below except the last one*/
DECLARE @jobid_getid [uniqueidentifier] = (SELECT TOP 1 job_id FROM msdb.dbo.sysjobs WHERE name = 'Job Name')

SELECT job_ID, name
FROM dbo.sysjobs
WHERE job_ID = @jobid_getid

/*This updates job name, enable/disable, etc.*/
EXEC msdb.dbo.sp_update_job @job_id = @jobid_getid  
     , @new_name = N'New Job Name'
	 , @description = N'Updated description'
	 , @enabled = 1

/*This updates job steps*/
EXEC msdb.dbo.sp_update_jobstep @job_id = @jobid_getid  
    , @step_id = 4
	, @on_success_action = 3

/*This deletes job steps*/
EXEC dbo.sp_delete_jobstep  
    @job_id = @jobid_getid,  
    @step_id = 1 ;  
GO 

/*This deletes a job if it exists*/
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'MyJob')
EXEC msdb.dbo.sp_delete_job @job_name=N'MyJob', @delete_unused_schedule=1
GO

---- Temp Tables

/*Check if temp tables exists and then drop*/
IF OBJECT_ID('tempdb.dbo.#tmp1') IS NOT NULL
    DROP TABLE #tmp1
