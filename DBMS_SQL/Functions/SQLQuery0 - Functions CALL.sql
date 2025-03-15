USE VPD_311_Temp_DLL
GO

--EXEC PrintSchedule;
SELECT TOP(3) * FROM Teachers ORDER BY teacher_id DESC;
PRINT dbo.CompleteLessonsForTeacher(N'Покидюк','2024-10-01','2024-10-31')