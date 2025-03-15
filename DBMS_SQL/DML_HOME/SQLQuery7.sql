 -- �������� ���, ������� ���������� ���������� ��� ������ ����������.					DONE
 -- �� ���������� ������ ���������� 3 ���� � ������ �� 2 ����: 
 --  ��., ��., �� ��� ��., ��., ��;
USE VPD_311_Import
GO

SET DATEFIRST 1;
DECLARE @group_id			AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = N'Java_326');			-- �������� ID ������ 'Java_326' �� ������� Group
DECLARE @discipline_id		AS SMALLINT = (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'��������%');	-- �������� ID ����������, ������� ���������� �� 'Java' (��������, Java-����������)
DECLARE @number_of_lessons	AS TINYINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_id = @discipline_id);		-- �������� ����� ���������� ������� ��� ��������� ����������
DECLARE @teacher_id			AS SMALLINT = (SELECT teacher_id		FROM Teachers		WHERE first_name = N'����');				-- �������� ID ������������� � ������ "����" �� ������� Teachers
DECLARE @start_date			AS DATE		= N'2024-12-08';	-- ���� ������ �������
DECLARE @date				AS DATE		= @start_date;		-- ������������� ��������� ���� ��� �����
DECLARE @time				AS TIME(0)	= N'08:00';			-- ����� ������ ����
DECLARE @lesson_number		AS TINYINT	= 0;				-- ������� �������

PRINT(@group_id);
PRINT(@discipline_id);
PRINT(@number_of_lessons);
PRINT(@teacher_id);
PRINT(@start_date);
PRINT(@time);
PRINT('===============================================');

WHILE (@lesson_number < @number_of_lessons)
BEGIN
	IF DATEPART(WEEKDAY, @date) IN (2,4,6)
	BEGIN
		PRINT(@date);			 -- ������� ������� ���� � �������
		PRINT(DATENAME(WEEKDAY, @date));
	 
		-- ��������� ������ ���� � ����������
		INSERT INTO Schedule ([group], discipline, teacher, [date], [time], spent)
		VALUES (@group_id, @discipline_id, @teacher_id, @date, @time, IIF(@date < GETDATE(), 1, 0));
		-- ���� ���� ������� ������ ������� ���� (��� ������), ������������� "spent = 1", ����� "spent = 0"
		SET @lesson_number = @lesson_number + 1; -- ����������� ������� �������

		-- ��������� ������ ���� � ����������
		INSERT INTO Schedule ([group], discipline, teacher, [date], [time], spent)
		VALUES (@group_id, @discipline_id, @teacher_id, @date, DATEADD(MINUTE,95,@time), IIF(@date < GETDATE(), 1, 0));
		SET @lesson_number = @lesson_number + 1; -- ����������� ������� �������
	END
	-- ������� � ���������� ��� (����� ���������, �������� �� �� �������)
	SET @date = DATEADD(DAY, 1, @date); 
END;
