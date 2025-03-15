USE VPD_311_Temp_DLL
GO


SELECT  
		--last_name	AS N'Фамилия',
		--first_name	AS N'Имя',
		--middle_name	AS N'Отчество',
		--birth_date	AS N'Дата рождения'
		--------------------------------------------------------------
		--last_name + ' ' + first_name + ' ' + middle_name AS N'Ф.И.О',
		--[Ф.И.О] = last_name + ' ' + first_name + ' ' + middle_name,
		[Ф.И.О.] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		birth_date	AS N'Дата рождения'
--FROM Students;
FROM	Teachers
--WHERE birth_date > '1990-01-01'
WHERE	first_name = N'Марина'
ORDER BY birth_date DESC;	--ASC	(ASCENDING) - сортировка по возрастанию
							--DESC(DESCENDING) - Сортировка по убыванию
		
--SELECT field1, field2, ..., fieldN
--FROM Table1, Table2, ....., TableN;