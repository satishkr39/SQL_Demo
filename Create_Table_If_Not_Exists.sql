--Description: Creating new table with IF condition. Crete the table only if it doens't exists
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = ''
	AND TABLE_SCHEMA = '')

	BEGIN
		-- Create Statement
		PRINT 'SUCCESS –created'
	END
ELSE 
	BEGIN
		PRINT 'FAILURE - already exists'
	END
GO


