USE VPD_311_Import
GO
SELECT dbo.IsHoliday('2025-02-23') AS IsHoliday;--TRUE 
SELECT dbo.IsHoliday('2025-09-01') AS IsHoliday;--FALSE