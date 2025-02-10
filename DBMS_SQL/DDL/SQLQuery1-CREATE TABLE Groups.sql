use MY_BASE
GO
CREATE TABLE Groups
(
	group_id		INT  PRIMARY KEY,
	group_name		NVARCHAR(24)		NOT NULL,
	direction		TINYINT				NOT NULL,
	-- Создаем внешний ключ
	CONSTRAINT FK_Groups_Directions FOREIGN KEY(direction) REFERENCES Directions(direction_id)
);