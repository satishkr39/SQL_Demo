/************************ Adding Constraint to tables **************************/

-- Adding unique constraint to tblEmployee for GovtID column
ALTER TABLE 
	tblEmployee
ADD CONSTRAINT
	unqGovtID
UNIQUE
	(EmployeeGovernmentID)

-- Getting duplicate GovtID 
SELECT EmployeeGovernmentID, COUNT(*) FROM tblEmployee GROUP BY EmployeeGovernmentID HAVING COUNT(*)>=2;
-- Deleting Duplicate govt ID
DELETE FROM tblEmployee WHERE EmployeeGovernmentID LIKE 'TX593671R ';

-- Adding constraint for combination of multiple columns
ALTER TABLE tblTransaction
ADD CONSTRAINT unqTransaction UNIQUE (Amount, DateofTransaction, EmployeeNumber);

-- Removing Constraint
ALTER TABLE TABleNAMe
DROP CONSTRAINT constraintName

-- Default Constraint
ALTER TABLE TableName
ADD CONSTRAINT constraintName DEFAULT defaultValue FOR columnName

-- Check Constraint
ALTER TABLE TblName 
ADD CONSTRAINT constraintName CHECK (ColmName>1000 AND ColmName<10000)

-- With NOCHECK doesn't check the existing rows and it only checks the new rows that are being inserted

-- DOB check constraint
ALTER TABLE tblName WITH NOCHECK
ADD CONSTRAINT constraintName CHECK (DOB between '1900-01-01' AND GETDATE())

-- Adding Primary Key
ALTER TABLE 
	tblEmployee
ADD CONSTRAINT 
	pk_EmployeeNumber
PRIMARY KEY
	(EmployeeNumber)

-- Adding Foregin Key
ALTER TABLE tblTransaction ADD CONSTRAINT ContraintName FOREIGN KEY (ColumnName)
REFERENCES tableName(ColumnName)

ALTER TABLE 
	tblTransaction
WITH NOCHECK
ADD CONSTRAINT 
	fk_Constraint
FOREIGN KEY
	(EmployeeNumber)
REFERENCES
	tblEmployee (EmployeeNumber)
