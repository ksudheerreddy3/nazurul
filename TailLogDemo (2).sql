Tail Log back up and Restore Demonstration:

--Create a Databaser
CREATE DATABASE [TailLogTest]

--Create a Table
USE [TailLogTest]
GO

CREATE TABLE [dbo].[Emp_Details]([ID] [int] NULL, [Name] [varchar](50) NULL, [Sal] [money] NULL) 
ON [PRIMARY]
GO

--Insert Data into the table
INSERT INTO [TailLogTest].[dbo].[Emp_Details] 
VALUES (100, 'Ramesh', 5000)
GO 100

--Issue a Full backup
BACKUP DATABASE TailLogTest TO 
DISK = 'C:\SQLLab\TaillogTest\FULL.BAK'
GO

--Insert Data into the table again
INSERT INTO [TailLogTest].[dbo].[Emp_Details] VALUES (200, 'Rajesh', 6000)
GO 100

--Issue a log backup1
BACKUP LOG TailLogTest TO 
DISK = 'C:\SQLLab\TaillogTest\LOG1.TRN'
GO

--Insert Data into the table again
INSERT INTO [TailLogTest].[dbo].[Emp_Details] VALUES (300, 'Raj', 7000)
GO 100

--Issue a log backup2
BACKUP LOG TailLogTest TO 
DISK = 'C:\SQLLab\TaillogTest\LOG2.TRN'
GO

--Insert Data into the table again
INSERT INTO [TailLogTest].[dbo].[Emp_Details] 
VALUES (400, 'Ram', 8000)
GO 100
use master
Go
--Set database to offline
ALTER DATABASE [TailLogTest] SET OFFLINE 
GO

---DELETE DATA FILE (mdf)

--Set database to offline
ALTER DATABASE [TailLogTest] SET ONLINE 
GO

--TAKE TAIL LOG BACKUP
USE MASTER
GO
BACKUP LOG TailLogTest TO DISK 
= 'C:\SQLLab\TaillogTest\TAIL.TRN' 
with no_truncate
GO

--Restore all the back ups:
Restore database TailLogTest from 
disk ='C:\SQLLab\TaillogTest\Full.bak' with norecovery 

Restore database TailLogTest from disk ='C:\SQLLab\TaillogTest\Log1.Trn' with norecovery
Restore database TailLogTest from disk ='C:\SQLLab\TaillogTest\Log2.Trn' with norecovery
Restore database TailLogTest from disk ='C:\SQLLab\TaillogTest\Tail.Trn' with recovery