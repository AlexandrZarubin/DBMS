USE VPD_311_Temp_DLL
GO

CREATE FUNCTION CompleteLessonsForTeacher
(
	@teacher_last_name  AS NVARCHAR(150),
	@start_date			AS DATE,
	@end_date			AS DATE
)
	RETURNS INT
AS
BEGIN
	DECLARE @teacher AS INT = (SELECT teacher_id FROM Teachers WHERE last_name = @teacher_last_name);
	DECLARE @number_of_lessons AS INT = (SELECT COUNT(lesson_id) FROM Schedule WHERE teacher = @teacher AND spent=1);
	RETURN @number_of_lessons;
END