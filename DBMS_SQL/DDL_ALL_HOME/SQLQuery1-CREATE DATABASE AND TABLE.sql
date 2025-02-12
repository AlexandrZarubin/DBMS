GO

USE master;
GO

PRINT '�������� ���� ������ VPD_311_HOME';
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'VPD_311_HOME')
BEGIN
CREATE DATABASE VPD_311_HOME
ON
(
	NAME = VPD_311_HOME,
	FILENAME = 'D:\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\VPD_311_HOME.mdf',
	SIZE = 8 MB,
	MAXSIZE = 500 MB,
	FILEGROWTH = 8 MB
)

LOG ON
(
	NAME = VPD_311_HOME_Log,
	FILENAME = 'D:\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\VPD_311_HOME_log.ldf',
	SIZE= 8 MB,
	MAXSIZE = 500 MB,
	FILEGROWTH = 8 MB
)
PRINT '���� ������ VPD_311_HOME ������� �������!';
END
ELSE
PRINT '���� ������ VPD_311_HOME ��� ����������!';
GO

USE VPD_311_HOME
GO



PRINT '�������� ������� Directions...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Directions')
BEGIN
CREATE TABLE Directions
(
	direction_id		TINYINT			PRIMARY KEY,
	direction_name		NVARCHAR(150)	NOT NULL
)
PRINT '������� Directions ������� �������!';
END
ELSE
PRINT '������� Directions ��� ����������!';
GO



PRINT '�������� ������� Groups...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Groups')
BEGIN
CREATE TABLE Groups
(
	group_id			INT				PRIMARY KEY,
	group_name			NVARCHAR(24)	NOT NULL,
	direction			TINYINT			NOT NULL,
	--Create a foreign key
	CONSTRAINT FK_Groups_Directions FOREIGN KEY(direction) REFERENCES Directions(direction_id)
)
PRINT '������� Groups ������� �������!';
END
ELSE
PRINT '������� Groups ��� ����������!';
GO



PRINT '�������� ������� Students...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Students')
BEGIN
CREATE TABLE Students
(
	student_id			INT				PRIMARY KEY,
	last_name			NVARCHAR(50)	NOT NULL,
	first_name			NVARCHAR(50)	NOT NULL,
	middle_name			NVARCHAR(50)		NULL,
	birth_date			DATE			NOT NULL,
	[group]				INT					NULL
	CONSTRAINT FK_Students_Groups FOREIGN KEY REFERENCES Groups(group_id)
)
PRINT '������� Students ������� �������!';
END
ELSE
PRINT '������� Students ��� ����������!';
GO



PRINT '�������� ������� Teachers...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Teachers')
BEGIN
CREATE TABLE Teachers
(
	teacher_id			INT				PRIMARY KEY,
	last_name			NVARCHAR(50)	NOT NULL,
	first_name			NVARCHAR(50)	NOT NULL,
	middle_name			NVARCHAR(50)		NULL,
	birth_date			DATE			NOT NULL,
	work_since			DATE			NOT NULL
)
PRINT '������� Teachers ������� �������!';
END
ELSE
PRINT '������� Teachers ��� ����������!';
GO




PRINT '�������� ������� Disciplines...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Disciplines')
BEGIN
CREATE TABLE Disciplines
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(150)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
)
PRINT '������� Disciplines ������� �������!';
END
ELSE
PRINT '������� Disciplines ��� ����������!';
GO




PRINT '�������� ������� RequiredDisciplines...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Schedule')
BEGIN
CREATE TABLE RequiredDisciplines
(
	discipline			SMALLINT,
	required_discipline	SMALLINT,
	PRIMARY KEY	(discipline, required_discipline), --This is the only way to create a composite primary key
	CONSTRAINT FK_RD_Discipline_2_Discipline FOREIGN KEY (discipline)			REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_RD_Required_2_Discipline	 FOREIGN KEY(required_discipline)	REFERENCES Disciplines(discipline_id)
)
PRINT '������� RequiredDisciplines ������� �������!';
END
ELSE
PRINT '������� RequiredDisciplines ��� ����������!';
GO




PRINT '�������� ������� TeachersDisciplinesRelation...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TeachersDisciplinesRelation')
BEGIN
CREATE TABLE TeachersDisciplinesRelation
(
	teacher				INT,
	discipline			SMALLINT,
	PRIMARY KEY	(teacher, discipline),
	CONSTRAINT FK_TDR_Teachers		FOREIGN KEY	(teacher)		REFERENCES Teachers(teacher_id),
	CONSTRAINT FK_TDR_Disciplines	FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id)
)
PRINT '������� TeachersDisciplinesRelation ������� �������!';
END
ELSE
PRINT '������� TeachersDisciplinesRelation ��� ����������!';
GO




PRINT '�������� ������� DisciplinesDirectionRelation...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DisciplinesDirectionRelation')
BEGIN
CREATE TABLE DisciplinesDirectionRelation
(
	discipline			SMALLINT,
	direction			TINYINT,
	PRIMARY KEY (discipline,direction),
	CONSTRAINT FK_DDR_Disciplines	FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DDR_Directions	FOREIGN KEY (direction)		REFERENCES Directions(direction_id)
)
PRINT '������� DisciplinesDirectionRelation ������� �������!';
END
ELSE
PRINT '������� DisciplinesDirectionRelation ��� ����������!';
GO



PRINT '�������� ������� Schedule...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Schedule')
BEGIN
CREATE TABLE Schedule
(
	lesson_id			BIGINT		PRIMARY KEY,
	[date]				DATE		NOT NULL,
	[time]				TIME		NOT NULL,
	[group]				INT			NOT NULL	CONSTRAINT	FK_Schedule_Groups		FOREIGN KEY REFERENCES Groups(group_id),
	discipline			SMALLINT	NOT NULL	CONSTRAINT	FK_Schedule_Disciplines	FOREIGN KEY REFERENCES Disciplines(discipline_id),
	teacher				INT			NOT NULL	CONSTRAINT	FK_Schedule_teachers	FOREIGN KEY REFERENCES Teachers(teacher_id),
	[subject]			NVARCHAR(256)	NULL,
	spent				BIT			NOT NULL
)
PRINT '������� Schedule ������� �������!';
END
ELSE
PRINT '������� Schedule ��� ����������!';
GO



PRINT '�������� ������� Grades...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Grades')
BEGIN
CREATE TABLE Grades
(
	student				INT						CONSTRAINT FK_Grades_Students 	FOREIGN KEY REFERENCES Students(student_id),
	lesson				BIGINT					CONSTRAINT FK_Grades_Schedule	FOREIGN KEY REFERENCES Schedule(lesson_id),
	PRIMARY KEY	(student,lesson),
	present				BIT			NOT NULL,
	grade_1				TINYINT					CONSTRAINT CK_Grades_1 CHECK (grade_1>0 AND grade_1<=12),
	grade_2				TINYINT					CONSTRAINT CK_Grades_2 CHECK (grade_2>0 AND grade_2<=12)
)
PRINT '������� Grades ������� �������!';
END
ELSE
PRINT '������� Grades ��� ����������!';
GO




PRINT '�������� ������� Exams...';
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Exams')
BEGIN
CREATE TABLE Exams
(
	PRIMARY KEY (student,discipline),
	student				INT						CONSTRAINT FK_Exams_Studnts		FOREIGN KEY REFERENCES Students(student_id),
	discipline			SMALLINT				CONSTRAINT FK_Exams_Disciplines	FOREIGN KEY REFERENCES Disciplines(discipline_id),
	grade				TINYINT					CONSTRAINT CK_Exams_Grade		CHECK (grade>0 AND grade <=12)
)
PRINT '������� Exams ������� �������!';
END
ELSE
PRINT '������� Exams ��� ����������!';
GO