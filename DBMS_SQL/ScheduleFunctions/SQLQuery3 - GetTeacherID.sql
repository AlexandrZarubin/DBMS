USE VPD_311_Import;
GO

CREATE FUNCTION GetTeacherID(@last_name NVARCHAR(50)) RETURNS SMALLINT
BEGIN
	RETURN(SELECT teacher_id FROm Teachers WHERE last_name=@last_name);
END