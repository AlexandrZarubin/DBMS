 -- Написать код, который выставляет расписание для группы стационара.					DONE
 -- На стационаре группы занимаются 3 раза в неделю по 2 пары: 
 --  Пн., Ср., Пт или Вт., Чт., Сб;
USE VPD_311_Import
GO

SET DATEFIRST 1;
DECLARE @group_id			AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = N'Java_326');			-- Получаем ID группы 'Java_326' из таблицы Group
DECLARE @discipline_id		AS SMALLINT = (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'Объектно%');	-- Получаем ID дисциплины, которая начинается на 'Java' (например, Java-разработка)
DECLARE @number_of_lessons	AS TINYINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_id = @discipline_id);		-- Получаем общее количество занятий для выбранной дисциплины
DECLARE @teacher_id			AS SMALLINT = (SELECT teacher_id		FROM Teachers		WHERE first_name = N'Олег');				-- Получаем ID преподавателя с именем "Олег" из таблицы Teachers
DECLARE @start_date			AS DATE		= N'2024-12-08';	-- Дата начала занятий
DECLARE @date				AS DATE		= @start_date;		-- Устанавливаем начальную дату для цикла
DECLARE @time				AS TIME(0)	= N'08:00';			-- Время первой пары
DECLARE @lesson_number		AS TINYINT	= 0;				-- Счётчик занятий

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
		PRINT(@date);			 -- Выводим текущую дату в консоль
		PRINT(DATENAME(WEEKDAY, @date));
	 
		-- Вставляем первую пару в расписание
		INSERT INTO Schedule ([group], discipline, teacher, [date], [time], spent)
		VALUES (@group_id, @discipline_id, @teacher_id, @date, @time, IIF(@date < GETDATE(), 1, 0));
		-- Если дата занятия меньше текущей даты (уже прошло), устанавливаем "spent = 1", иначе "spent = 0"
		SET @lesson_number = @lesson_number + 1; -- Увеличиваем счётчик занятий

		-- Вставляем вторую пару в расписание
		INSERT INTO Schedule ([group], discipline, teacher, [date], [time], spent)
		VALUES (@group_id, @discipline_id, @teacher_id, @date, DATEADD(MINUTE,95,@time), IIF(@date < GETDATE(), 1, 0));
		SET @lesson_number = @lesson_number + 1; -- Увеличиваем счётчик занятий
	END
	-- Переход к следующему дню (чтобы проверить, является ли он учебным)
	SET @date = DATEADD(DAY, 1, @date); 
END;
