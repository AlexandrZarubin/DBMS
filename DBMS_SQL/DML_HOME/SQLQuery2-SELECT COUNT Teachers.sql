--2. ���������� ���������� �������������� �� ������ ����������;

USE VPD_311_Import
GO

SELECT
   discipline_name,
    COUNT(DISTINCT teacher_id) AS N'���-�� ��������������'
FROM Teachers, Disciplines ,TeachersDisciplinesRelation
WHERE
    teacher = teacher_id
    AND discipline = discipline_id
GROUP BY
    discipline_name;
