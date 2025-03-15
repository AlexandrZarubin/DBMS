USE VPD_311_Temp_DLL
GO

SELECT
	[�.�.�] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
	[����������] = discipline_name
FROM Teachers,Disciplines,TeacherDisciplinesRelation
WHERE	teacher = teacher_id
AND		discipline = discipline_id
AND		(discipline_name LIKE '%SQL%'
OR		discipline_name LIKE '%Windows%');
--ORDER BY [����������] DESC;