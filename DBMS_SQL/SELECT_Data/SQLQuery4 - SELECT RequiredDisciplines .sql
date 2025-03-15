USE VPD_311_Temp_DLL
GO

SELECT
		[Целевая дисциплина]=discipline_name,
		[Требуемая дисциплина]=discipline_name
FROM	Disciplines, RequiredDisciplines
WHERE	discipline_id = required_discipline
AND		target_discipline = 
		(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '%ADO.NET%');