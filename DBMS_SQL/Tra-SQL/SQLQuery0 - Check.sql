USE VPD_311_Import
GO
DELETE FROM Schedule;

--EXEC SelectSchedule;
--EXEC sp_SetScheduleForSemistacionar N'VPD_311',N'%��������%','2024-08-25','12:00',N'������',7;
EXEC sp_SetScheduleForSemistacionarWithHolidays N'VPD_311',N'%��������%','2025-01-01','12:00',N'������',7
--EXEC sp_SelectScheduleForGroup N'VPD_311'
--EXEC sp_SelectDisciplineForGroup N'VPD_311', N'%��������%';