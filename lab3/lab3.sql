USE [master]
ALTER AUTHORIZATION ON DATABASE::TravelAgency TO [sa]; 
GO
ALTER DATABASE TravelAgency SET TRUSTWORTHY ON; 

GO
USE TravelAgency; 
GO

CREATE ASSEMBLY Database123 FROM 'C:\univer\semestr_6\DB\labs\lab3\Database1\Database1.dll' 
WITH PERMISSION_SET=EXTERNAL_ACCESS; 
GO

CREATE FUNCTION WriteTextFile(@text [nvarchar](max), @path [nvarchar](max), @append [bit]) RETURNS [bit]
AS EXTERNAL NAME Database123.[UserDefinedFunctions].WriteTextFile; 

CREATE TYPE CustomRoute
EXTERNAL NAME Database123.[CustomRoute]
GO

SELECT dbo.WriteTextFile(
'text3', 'D:\\univer\\Line.txt', 0)
GO

SELECT dbo.WriteTextFile(
'text1', 'D:\\univer\\Line.txt', 1)
GO

go
declare @Route CustomRoute
set @Route = 'City 1 -> City 2'
select @Route.ToString()
go

USE [master]