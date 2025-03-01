-- 4. *** ѕодсчитать количество преподавателей по каждому направлению обучени€;
USE VPD_311_Import;
GO

SELECT
    Directions.direction_name AS			[Ќаправление],
    COUNT(DISTINCT Teachers.teacher_id) AS	[ оличество преподавателей]
FROM 
    Directions,
    DisciplinesDirectionsRelation,
    Disciplines,
    TeachersDisciplinesRelation,
    Teachers
WHERE 
    direction_id									= direction
    AND DisciplinesDirectionsRelation.discipline	= discipline_id
    AND Disciplines.discipline_id					= TeachersDisciplinesRelation.discipline
    AND teacher										= teacher_id
GROUP BY
    Directions.direction_name;
