USE master;
GO

CREATE DATABASE MY_BASE
ON --Опередляем параметры фаила баззы данных
(
	NAME = MY_BASE,
	FILENAME = 'D:\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\MY_BASE.mdf',
	SIZE = 8MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 8MB
)

LOG ON --Опередляем параметры фаила баззы данных
(
	NAME = MY_BASE_Log,
	FILENAME = 'D:\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\MY_BASE_Log.ldf',
	SIZE = 8MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 8MB
)