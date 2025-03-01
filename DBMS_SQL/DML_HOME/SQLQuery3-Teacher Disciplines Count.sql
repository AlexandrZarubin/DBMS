--Для каждого преподавателя вывести количество дисциплин, которые он может читать;
USE VPD_311_Import
GO

SELECT
    [TeacherFullName] = CONCAT(last_name,'  ', first_name,'  ',COALESCE(middle_name,' ')),
    COUNT(DISTINCT discipline_id) AS DisciplineCount
FROM
    Teachers, TeachersDisciplinesRelation, Disciplines  
WHERE
    teacher     = teacher_id
    AND discipline=discipline_id
GROUP BY
    CONCAT(last_name,'  ', first_name,'  ',COALESCE(middle_name,' '))
