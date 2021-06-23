-- It checks whether the column exists or not. 
IF NOT EXISTS (SELECT * FROM sys.columns WHERE  object_id = OBJECT_ID(N'[dbo].[Student]') AND  name = 'ColumnName')
BEGIN
	PRINT('Write Create/ALter COlumn Table Statement')
END


DELETE FROM dbo.Student WHERE roll = 6