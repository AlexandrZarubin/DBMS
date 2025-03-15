USE master;
GO

CREATE DATABASE VPD_311_Temp_DLL
ON --Опередляем параметры фаила баззы данных
(
	NAME = VPD_311_Temp_DLL,
	FILENAME = 'D:\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\VPD_311_Temp_DLL.mdf',
	SIZE = 8MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 8MB
)

LOG ON --Опередляем параметры фаила баззы данных
(
	NAME = VPD_311_Temp_DLL_Log,
	FILENAME = 'D:\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\VPD_311_Temp_DLL_Log.ldf',
	SIZE = 8MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 8MB
)