USE VPD_311_Import
GO

CREATE FUNCTION IsHoliday(@date DATE) 
RETURNS BIT
AS
BEGIN
    DECLARE @isHoliday BIT = 0;
    IF EXISTS (SELECT * FROM Holidays WHERE @date >= start_date AND @date <= end_date)
        SET @isHoliday = 1;
    RETURN @isHoliday;
END;