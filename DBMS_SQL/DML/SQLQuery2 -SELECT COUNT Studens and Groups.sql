USE VPD_311_Import
GO

SELECT 
		direction_name	AS N'Направление обучения',
		COUNT(group_id) AS N'Количество групп'
FROM	Groups,		Directions
WHERE	direction =	direction_id
GROUP BY direction_name
ORDER BY N'Количество групп' 
;

SELECT 
	[НАправление обучения]	=	direction_name,
	[Количество студентов]	=	COUNT(stud_id)
FROM	Students,Groups,Directions
WHERE	[group]		=	group_id
AND		direction	=	direction_id
GROUP BY direction_name;

SELECT DISTINCT 
		[Направление обучения]	=	direction_name,
		[Количество групп]		=	COUNT(group_id),
		[Количество студентов]	=	COUNT(stud_id)
FROM Students,Groups,Directions
WHERE	[group]		=	group_id
AND		direction	=	direction_id
GROUP BY direction_name,group_id;