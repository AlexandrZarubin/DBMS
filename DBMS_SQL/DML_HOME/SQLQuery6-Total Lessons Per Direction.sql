--6. Для каждого направления подсчитать общее количество занятий;
USE VPD_311_Import;
GO

SELECT
    [Направление]         = direction_name,
    [Количество занятий]  = COUNT(lesson_id)
FROM 
    Directions, DisciplinesDirectionsRelation, Disciplines, Schedule
WHERE 
    direction_id									= direction
    AND DisciplinesDirectionsRelation.discipline    = discipline_id
    AND discipline_id								= Schedule.discipline
GROUP BY
   direction_name;
