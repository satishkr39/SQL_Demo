/****************** JOINS ***************************/

-- Creating 2nd table Transaction
CREATE TABLE tblTransaction( 
	amount smallmoney NOT NULL,
	DateofTransaction smalldatetime NULL,
	EmployeeNumber int NOT NULL
)

SELECT * FROM tblTransaction;

SELECT 
	E.EmployeeNumber, 
	E.EmployeeFirstName, 
	E.EmployeeLastName,
	SUM(T.amount)
FROM 
	tblEmployee E
JOIN 
	tblTransaction T 
ON 
	T.EmployeeNumber = E.EmployeeNumber
GROUP BY 
	E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName
ORDER BY 
	E.EmployeeNumber

SELECT 
	E.EmployeeFirstName, 
	CASE WHEN E.EmployeeMiddleName IS NULL THEN '' ELSE E.EmployeeMiddleName END AS MiddleName, 
	E.EmployeeLastName,
	T.amount,
	T.DateofTransaction,
	E.EmployeeNumber
FROM tblEmployee E
INNER JOIN tblTransaction T
ON T.EmployeeNumber = E.EmployeeNumber;


SELECT DISTINCT(Department) FROM tblEmployee;

-- Creating 3rd table tblDepartment

SELECT DISTINCT Department, '' AS DepartmentHead
INTO
	tblDepartment
FROM 
	tblEmployee

SELECT * FROM tblDepartment;

-- query to show amount per department 

SELECT 
	D.Department, SUM(T.amount)
FROM 
	tblDepartment D
LEFT OUTER JOIN 
	tblEmployee E
ON 
	D.Department = E.Department
INNER JOIN
	tblTransaction T
ON
	T.EmployeeNumber = E.EmployeeNumber
GROUP BY
	D.Department;

SELECT COUNT(*) FROM tblEmployee; -- 1007
SELECT COUNT(*) FROM tblDepartment; -- 4
SELECT COUNT(*) FROM tblTransaction; -- 2500

SELECT * FROM tblDepartment	

DROP TABLE tblDepartment;
-- Setting Dept Head 

SELECT 
	E.EmployeeNumber, 
	E.EmployeeFirstName, 
	E.EmployeeLastName,
	SUM(T.amount) AS TotalAmount,
	T.EmployeeNumber
FROM 
	tblEmployee E
RIGHT JOIN
	tblTransaction T
ON 
	T.EmployeeNumber = E.EmployeeNumber
WHERE
	E.EmployeeNumber IS NULl
GROUP BY
	E.EmployeeNumber,
	E.EmployeeFirstName,
	E.EmployeeLastName,
	T.EmployeeNumber;


-- Updating data

SELECT * FROM tblTransaction WHERE EmployeeNumber = 194;

-- Updating data of 194 by copying transaction of EmpNumber 3

UPDATE 
	tblTransaction
SET
	EmployeeNumber = 194
FROM
	tblTransaction 
WHERE 
	EmployeeNumber = 3;

SELECT * FROM tblDepartment;