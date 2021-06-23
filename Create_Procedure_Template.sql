-- Create Procedure Template
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER     PROCEDURE ProcedureName

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION

		--Write your funcationality here
		
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
		IF EXISTS ( SELECT * FROM sysobjects
    	WHERE  id = object_id(N'[dbo].[spErrorHandling]')
        and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
    	BEGIN
			EXEC [dbo].[spErrorHandling];
		END
		RETURN -1
	END CATCH
END
GO