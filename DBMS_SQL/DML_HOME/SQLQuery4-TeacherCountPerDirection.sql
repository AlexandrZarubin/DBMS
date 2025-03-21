-- 4. *** Подсчитать количество преподавателей по каждому направлению обучения;
USE VPD_311_Import;
GO

SELECT
    Directions.direction_name AS			[Направление],
    COUNT(DISTINCT Teachers.teacher_id) AS	[Количество преподавателей]
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
