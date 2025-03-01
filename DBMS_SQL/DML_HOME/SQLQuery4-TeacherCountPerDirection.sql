-- 4. *** ���������� ���������� �������������� �� ������� ����������� ��������;
USE VPD_311_Import;
GO

SELECT
    Directions.direction_name AS			[�����������],
    COUNT(DISTINCT Teachers.teacher_id) AS	[���������� ��������������]
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
