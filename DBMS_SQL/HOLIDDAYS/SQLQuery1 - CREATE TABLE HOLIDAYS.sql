USE VPD_311_Import;
GO

CREATE TABLE Holidays 
(
    id				INT				IDENTITY(1,1)	PRIMARY KEY,
    holiday_name	NVARCHAR(100)	NOT NULL,
    [start_date]	DATE			NOT NULL,
    end_date		DATE			NOT NULL
);