USE VPD_311_Temp_DLL
GO

SELECT
	[Ф.И.О] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
	[Дисциплина] = discipline_name
FROM Teachers,Disciplines,TeacherDisciplinesRelation
WHERE	teacher = teacher_id
AND		discipline = discipline_id
AND		(discipline_name LIKE '%SQL%'
OR		discipline_name LIKE '%Windows%');
--ORDER BY [Дисциплина] DESC;