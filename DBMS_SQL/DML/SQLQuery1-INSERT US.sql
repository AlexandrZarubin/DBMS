USE VPD_311_Import;
GO

--INSERT Groups
--		(group_id,group_name,direction)
--VALUES
--		(11, N'VPD_311',1);
UPDATE Groups 
SET direction=1
WHERE group_name = N'VPD_311';
SELECT*FROM Groups;