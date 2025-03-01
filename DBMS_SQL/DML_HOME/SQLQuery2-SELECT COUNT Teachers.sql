--2. Подсчитать количество преподавателей по каждой дисциплине;

USE VPD_311_Import
GO

SELECT
   discipline_name,
    COUNT(DISTINCT teacher_id) AS N'Кол-во преподавателей'
FROM Teachers, Disciplines ,TeachersDisciplinesRelation
WHERE
    teacher_id = teacher_id
    AND discipline_id = discipline_id
GROUP BY
    discipline_name;
