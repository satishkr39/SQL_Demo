/******** Usser Defined Function *******/
CREATE FUNCTION [dbo].[AmountPlusOne] -- Return Amount + 1
(
    @Amount smallmoney
)
RETURNS smallmoney
AS
BEGIN
    RETURN @Amount + 1	
END
GO
SELECT Amount, dbo.AmountPlusOne(amount) FROM tblTransaction

-- Function to return number of transaction for a given EmployeeNumber
GO
CREATE FUNCTION [dbo].[NumberOfTransaction]
(
@EmployeeNumber int
)
RETURNS INT
AS
BEGIN
	DECLARE @NumberOfTransaction INT
	SELECT @NumberOfTransaction = COUNT(*) FROM tblTransaction WHERE EmployeeNumber = @EmployeeNumber
	RETURN @NumberOfTransaction
END
GO
--Display the number of transaction of employee using function
SELECT EmployeeNumber, dbo.NumberOfTransaction(EmployeeNumber) AS NumbOfTr FROM tblEmployee ORDER By EmployeeNumber

/**** IN-Line TABLE Function *******/ -- It return a table as output
GO
CREATE FUNCTION [dbo].[GetTransactionTableForEmpNumber]
(
    @EmpNumber int
)
RETURNS TABLE AS RETURN
(
    SELECT * FROM tblTransaction WHERE EmployeeNumber = @EmpNumber
)
Go
-- Execute in-line table function
SELECT * FROM dbo.GetTransactionTableForEmpNumber(123) -- Prints tr details of EmpNumber 123
