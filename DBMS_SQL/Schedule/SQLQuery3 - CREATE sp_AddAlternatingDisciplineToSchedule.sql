USE VPD_311_Temp_DLL;
GO
--DROP PROCEDURE		sp_AddAlternatingDisciplineToSchedule;
--GO

CREATE PROCEDURE	sp_AddAlternatingDisciplineToSchedule
@group_name			NVARCHAR(50),		-- Название группы
@discipline_name	NVARCHAR(256),		-- Название дисциплины
@start_date			DATE,				-- Дата начала занятий
@start_time			TIME,				-- Время начала занятия
@teacher_last_name	NVARCHAR(150),		-- Фамилия преподавателя
@constant_day		INT,				-- День недели, когда дисциплина проводится постоянно
@alternate_day		INT					-- День недели, когда дисциплина чередуется
AS
BEGIN
	-- Получаем идентификатор группы
	DECLARE @group		AS	INT			= (SELECT group_id		FROM Groups			WHERE group_name = @group_name);	
	-- Получаем идентификатор дисциплины
	DECLARE @discipline	AS	SMALLINT	= (SELECT discipline_id FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	-- Получаем количество занятий для данной дисциплины
	DECLARE @number_of_lessons	
						AS	SMALLINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	-- Устанавливаем дату начала занятий
	DECLARE @date		AS	DATE		= @start_date;
	-- Получаем идентификатор преподавателя
	DECLARE @teacher	AS	INT			= (SELECT teacher_id	FROM Teachers		WHERE last_name = @teacher_last_name);
	
	-- Вычисляем интервал между постоянным и чередующимся днём недели
	DECLARE @ca_interval INT = ABS(@constant_day - @alternate_day);
	-- Флаг, указывающий, нужно ли использовать чередование
	DECLARE @alternate_present AS BIT = 0;
	-- Счётчик занятий
	DECLARE @lesson_number AS SMALLINT  = 0;
	 
	 -- Выводим отладочную информацию
	PRINT (@group);
	PRINT (@discipline);
	PRINT (@number_of_lessons);
	PRINT (@date);
	PRINT (@teacher);
	PRINT (@ca_interval);
	
	-- Запускаем цикл для распределения занятий в расписании
	WHILE @lesson_number < @number_of_lessons
	BEGIN
			-- Выводим информацию о текущем занятии
			PRINT (@lesson_number);
			PRINT (@date);
			PRINT (DATENAME(WEEKDAY, @date));
			PRINT ('------------------------');
			-- Объявляем переменную для хранения последней даты занятия
			DECLARE @prelast_day AS DATE;
			IF(DATEPART(WEEKDAY, @date) = @constant_day)	-- Если текущее занятие попадает на постоянный день недели
			BEGIN
				IF(@constant_day < @alternate_day)	-- Если постоянный день раньше чередующегося
				BEGIN
					-- Получаем последнюю дату занятия перед текущей
					DECLARE @prelast_date AS DATE = (SELECT MAX([date]) FROM Schedule WHERE [date]<@date AND discipline=@discipline);
					-- Определяем новую дату занятия в зависимости от чередования
					SET @date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @prelast_date) = @constant_day, @ca_interval, 7),@date);
				END
				ELSE
				BEGIN
					-- Если постоянный день позже чередующегося, получаем дату последнего чередующегося занятия
					SET @prelast_date = (SELECT MAX([date]) FROM Schedule WHERE [date]<@date AND DATEPART(WEEKDAY, [date]) = @alternate_day);
					-- Определяем новую дату занятия, учитывая разницу между последним занятием и текущим днём
					SET @date = DATEADD(DAY, IIF(DATEDIFF(DAY, @prelast_date, @date) > 8, 7 - @ca_interval, 7), @date);
				END
				--SET @date = DATEADD(DAY, @ca_interval, @date);
				--SET @alternate_present = 0;
			END
			ELSE
			BEGIN
				SET @date = DATEADD(DAY, 7, @date); -- Если текущее занятие не попадает на постоянный день, добавляем 7 дней
				SET @alternate_present = 1;			-- Отмечаем, что было чередующееся занятие
			END
			SET @lesson_number = @lesson_number+2;	-- Увеличиваем номер занятия на 2 (так как добавляем сразу два занятия)
	END
END