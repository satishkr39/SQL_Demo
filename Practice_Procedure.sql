-- Create a procedure to insert any row in tblTransaction2 from tblTransaction each time it's executed using MERGE
GO
CREATE OR ALTER PROCEDURE
	MergeDemo
AS
BEGIN
	-- Check if tblTransaction2 exists or not, if not then CREATE it
	IF OBJECT_ID('tblTransaction2') IS NULL
	BEGIN
		SELECT * INTO tblTransaction2 FROM tblTransaction WHERE 1=2 -- Create table if not exists
	END
	MERGE 
		tblTransaction2 AS TARGET
	USING 
		tblTransaction AS SOURCE
	ON 
		TARGET.EmployeeNumber = SOURCE.EmployeeNumber AND TARGET.DateofTransaction = SOURCE.DateofTransaction
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (Amount, DateofTransaction, EmployeeNumber)
	VALUES (SOURCE.Amount, SOURCE.Dateoftransaction, SOURCE.EmployeeNumber)
	WHEN MATCHED THEN
	UPDATE
		SET TARGET.Amount = 3;
	PRINT 'Hi';
	--OUTPUT INSERTED.*;-- DELETED.* ;
END

SELECT * FROM tblTransaction2
SELECT * FROM tblTransaction

EXEC MergeDemo

SELECT OBJECT_ID('tblTransaction2') 

SELECT * FROM tblTransaction2

DELETE FROM tblTransaction WHERE EmployeeNumber IN (77,438,1110,331,607) ORDER BY EmployeeNumber;
EmployeeNumber, DateofTransaction
HAVING COUNT(*)>=2;

SELECT SUM(Amount) FROM tblTransaction2 WHERE EmployeeNumber = 658; --1252

PRINT 'Hi'

DROP TABLE tblTransaction2;