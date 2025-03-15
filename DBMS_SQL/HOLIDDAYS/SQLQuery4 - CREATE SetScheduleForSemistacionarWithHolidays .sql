USE VPD_311_Import
SET DATEFIRST 1;
GO

ALTER PROCEDURE sp_SetScheduleForSemistacionarWithHolidays
	@group_name			AS NVARCHAR(10),
	@discipline_name	AS NVARCHAR(150),
	@start_date			AS DATE,
	@start_time			AS TIME,
	@teacher_last_name	AS NVARCHAR(50),
	@day				AS TINYINT
AS
BEGIN
	DECLARE @group				AS INT		= dbo.GetGroupID(@group_name);
	DECLARE @discipline			AS SMALLINT	= dbo.GetDisciplineID(@discipline_name);
	DECLARE	@number_of_lessons	AS TINYINT	= dbo.GetNumberOfLessons(@discipline_name);
	DECLARE @teacher			AS SMALLINT = dbo.GetTeacherID(@teacher_last_name);
	DECLARE @date				AS DATE		= @start_date;
	DECLARE @time				AS TIME(0)	= @start_time;
	DECLARE	@lesson_number		AS TINYINT	= 0;

	PRINT('������: '		 + @group_name);
	PRINT('����������: '	 + @discipline_name);
	PRINT('���-�� �������: ' + CAST(@number_of_lessons AS NVARCHAR));
	PRINT('�������������: '	 + @teacher_last_name);
	PRINT('��������� ����: ' + CAST(@start_date AS NVARCHAR));
	PRINT('�����: '			 + CAST(@start_time AS NVARCHAR));

	PRINT('===============================================');

	WHILE (@lesson_number < @number_of_lessons)
	BEGIN
		-- ���������� ����������� ���
		WHILE dbo.IsHoliday(@date) = 1 OR DATEPART(WEEKDAY, @date) <> @day
		BEGIN
			PRINT('���� ' + CAST(@date AS NVARCHAR) + ' - ��������! ��������� �������.');
			SET @date = DATEADD(DAY, 1, @date);
		END

		PRINT('���� �������: ' + CAST(@date AS NVARCHAR));
		PRINT('���� ������: ' + DATENAME(WEEKDAY, @date));
		PRINT('����� �������: ' + CAST(@lesson_number + 1 AS NVARCHAR));
		PRINT('�����: ' + CAST(@time AS NVARCHAR));

		-- ������ �������
		SET @time = @start_time;
		EXEC sp_InsertLessonToSchedule @group, @discipline, @teacher, @date, @time;
		SET @lesson_number = @lesson_number + 1;

		---------------------------------------------------------------------------------------
		-- ������ ������� (����� 95 �����)
		SET @time = DATEADD(MINUTE, 95, @time);
		EXEC sp_InsertLessonToSchedule @group, @discipline, @teacher, @date, @time;
		PRINT('������ ������� � ' + CAST(@time AS NVARCHAR));
		SET @lesson_number = @lesson_number + 1;

		--------------------------------------------------------------------------------------
		-- ������ ������� (��� ����� 190 �����)
		SET @time = DATEADD(MINUTE, 190, @time);
		EXEC sp_InsertLessonToSchedule @group, @discipline, @teacher, @date, @time;
		PRINT('������ ������� � ' + CAST(@time AS NVARCHAR));
		SET @lesson_number = @lesson_number + 1;

		PRINT('----------------------------');

		-- ��������� ������� ����� ������
		SET @date = DATEADD(WEEK, 1, @date);
	END
END;