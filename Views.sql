/***************** VIEWS IN SQL **************************/

-- order by clause doesn't work in VIEWS untill we have TOP command in it.
Go
CREATE VIEW 
	EmployeeLastName_View
AS SELECT 
	EmployeeLastName,
	EmployeeNumber
FROM
	tblEmployee
WHERE 
	EmployeeNumber<1000;
GO
-- Drop the view
DROP VIEW EmployeeLastName_View;
-- ALter View
ALTER VIEW viewName as SELECT Statement
-- A view can't be altered if it doens't exist
Go
SELECT * FROM EmployeeLastName_View;

SELECT * FROM sys.views; -- To get all the views 

-- CREATE OR ALTER VIEW ViewName then continue as select statemnt
SELECT * FROM sys.syscomments; -- Gives all the views and list of procedures

-- Creating views with Encryption
GO
CREATE VIEW 
	EncryptedView 
WITH ENCRYPTION
AS 
SELECT 
	EmployeeMiddleName,
	EmployeeNumber
FROM 
	tblEmployee
WHERE
	EmployeeNumber < 200;
Go

-- If we try to see the VIEW query from sys table it will show NULL
SELECT * FROM sys.syscomments; -- the text column return NULL insted of giving the VIEW query. It helps in security.


-- WE can insert/update/delete VIEWS
-- WITH CHECK OPTION in views makes sure that the update/delete/insert statement performed are within the views range
-- the views should not be able to make any changes outside of its range if WITH CHECK OPTION is included while creating views

-- In views we can't update/delete/or modify if the queries has effect on multiple base tables. 