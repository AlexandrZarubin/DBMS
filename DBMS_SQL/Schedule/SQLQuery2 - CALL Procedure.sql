USE VPD_311_Temp_DLL;
GO

--EXEC PrintStudents;
--EXEC PrintSchedule;
--EXEC sp_AddScheduleForStacionarGroup '2024-01-10', '14:30', N'PD_212', N'%ADO.NET%', N'�������'
--EXEC PrintScheduleForFroup N'PD_212';

EXEC sp_AddAlternatingDisciplineToSchedule N'PD_311', N'Hardware%', '2023-09-18', '13:30', '�����������', 2, 4