USE VPD_311_HOME;
GO

INSERT	Directions
		(direction_id,direction_name)
VALUES 
		(1,			N'Разработка программного обеспечения'),
		(2,			N'Сетевые технологий и системное администрирование'),
		(3,			N'Компьютерная графика и дизайн')
		;
GO
SELECT* FROM Directions;