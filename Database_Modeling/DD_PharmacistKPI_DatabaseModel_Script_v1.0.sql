/*
Pharmacist Key Performance Indicator Database & Dashboard
Database Model
*/

--Check for existing RPh_KPI Db
USE master;
GO

IF EXISTS 
	(SELECT TOP 1 * 
	 FROM sys.sysdatabases
	 WHERE [name] = 'RPh_KPI'
	)
DROP DATABASE RPh_KPI;
GO

--Create RPh_KPI Db

CREATE DATABASE RPh_KPI;
GO

USE RPh_KPI;
GO

--Create Role Table

CREATE TABLE [Role] (
Role_Type VARCHAR(5) NOT NULL PRIMARY KEY,
Role_Name VARCHAR(14) NULL
);

--Create Employees Table

CREATE TABLE Employees (
Emp_UserID INT NOT NULL PRIMARY KEY,
Last_Name VARCHAR(30) NULL,
First_Name VARCHAR(30) NULL,
Initials VARCHAR(3) NULL,
Role_Type VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES Role(Role_Type),
Start_Date DATE NULL,
Train_Cmpl_Date DATE NULL,
End_Date DATE NULL,
Leave_Date DATE NULL,
Status VARCHAR(9) NULL
);

--Create Patient Table

CREATE TABLE Patient (
Insrd_ID INT NOT NULL PRIMARY KEY,
Last_Name VARCHAR(50) NULL,
First_Name VARCHAR(50) NULL,
Patient_DOB DATE NULL
);

--Create Appointments Table

CREATE TABLE Appointments (
Appt_ID INT NOT NULL PRIMARY KEY,
Insrd_ID INT NOT NULL FOREIGN KEY REFERENCES Patient(Insrd_ID),
Appt_Date DATE NOT NULL,
Appt_Time TIME NOT NULL,
Appt_Type VARCHAR(9) NOT NULL,
Appt_Status VARCHAR(9) NULL,
Emp_UserID INT NULL,
Appt_Sequence AS CONVERT(VARCHAR(12),Insrd_ID)+CONVERT(VARCHAR(12),Appt_Date)+CONVERT(VARCHAR(12),Appt_Time)
);

--Create MRP Table

CREATE TABLE MRP (
MRP_ID INT NOT NULL PRIMARY KEY,
Insrd_ID INT NOT NULL FOREIGN KEY REFERENCES Patient(Insrd_ID),
MRP_Type VARCHAR(13) NULL,
Create_DateTime SMALLDATETIME NULL,
Create_Emp_UserID INT NOT NULL FOREIGN KEY REFERENCES Employees(Emp_UserID),
Resolution_DateTime SMALLDATETIME NULL,
Resolve_Emp_UserID INT NOT NULL FOREIGN KEY REFERENCES Employees(Emp_UserID),
MRP_Note VARCHAR(400) NULL
);

--Create DSA Table

CREATE TABLE DSA (
DSA_ID INT NOT NULL PRIMARY KEY,
Insrd_ID INT NOT NULL FOREIGN KEY REFERENCES Patient(Insrd_ID),
Assessment_DateTime SMALLDATETIME NULL,
Assessment_Category VARCHAR(100) NULL,
Assessment_Question VARCHAR(255) NULL,
Assessment_Response VARCHAR(255) NULL,
Create_Date DATE NULL,
Create_Emp_UserID INT NOT NULL FOREIGN KEY REFERENCES Employees(Emp_UserID),
DSA_Response_Note VARCHAR(400) NULL
);

--Create Lab_Coll_Offices Table

CREATE TABLE Lab_Coll_Offices (
Office_ID INT NOT NULL PRIMARY KEY,
Office_Type VARCHAR(15) NULL,
Office_Name VARCHAR(50) NULL,
License_Number VARCHAR(12) NULL,
Address1 VARCHAR(50) NULL,
Address2 VARCHAR(10) NULL,
City VARCHAR(50) NULL,
State VARCHAR(3) NULL,
Zip_Code VARCHAR(10) NULL,
Phone_Number VARCHAR(22) NULL,
Fax_Number VARCHAR(22) NULL,
Contact_Name VARCHAR(50) NULL
);

--Create Lab_Summary Table

CREATE TABLE Lab_Summary (
Lab_ID INT NOT NULL PRIMARY KEY,
Insrd_ID INT NOT NULL FOREIGN KEY REFERENCES Patient(Insrd_ID),
Ordering_Provider VARCHAR(50) NULL,
Received_Date DATE NULL,
Coll_Office_ID INT NOT NULL FOREIGN KEY REFERENCES Lab_Coll_Offices(Office_ID),
Collection_Date DATE NULL
);

--Create Lab_Detail Table

CREATE TABLE Lab_Detail (
Lab_ID INT NOT NULL FOREIGN KEY REFERENCES Lab_Summary(Lab_ID),
Lab_EntryID INT NOT NULL PRIMARY KEY,
Lab_Category VARCHAR(20) NULL,
Lab_Item VARCHAR(50) NULL,
Lab_Value DECIMAL(10,4) NULL
);

--Create Progress_Notes Table

CREATE TABLE Progress_Notes (
ProgNote_ID INT NOT NULL PRIMARY KEY,
Insrd_ID INT NOT NULL FOREIGN KEY REFERENCES Patient(Insrd_ID),
Create_Date DATE NULL,
ProgNote_Entry VARCHAR(400) NULL,
Create_Emp_UserID INT NOT NULL FOREIGN KEY REFERENCES Employees(Emp_UserID),
);