USE VPD_311_Import
GO

SELECT

	direction_name		AS N'НАправление обучения',
	COUNT(group_id)		AS N'Количество групп'
FROM		Groups,Directions
WHERE		direction=direction_id
GROUP BY	direction_name
--WHERE COUNT (group_id)>3
HAVING		COUNT(group_id)>=2
;