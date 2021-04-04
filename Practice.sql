-- Declaring varibale 

DECLARE @course_name as varchar, @course_fees as varchar(20)

-- Assigning Variable

DECLARE @course_id as INT = 5
PRINT @course_id -- Priniting course ID
--Using SET
SET @course_fees = 15000
PRINT @course_fees
SET @course_name = 'satish'
PRINT @course_name

-- SET the value using query
DECLARE @name varchar(20) =  (SELECT TOP 1 name FROM dbo.Student) 
PRINT @name
DECLARE @TestVariable AS VARCHAR(100)='Save Our Planet'
PRINT @TestVariable

-- money and smallmoney data type
DECLARE @balance smallmoney = 9000
PRINT @balance

--POWER FUNCTIoN
SELECT POWER(3,2)
SELECT SQUARE(3)
SELECT SQRT(9)
FLOOR goes down always
CEILING goes up always
ROUND, ABS, SIGN,

-- Generate Random Number
SELECT RAND(10)

SELECT ROUND(748.56,0)

-- Converting Data Types
--Implicit Casting
DECLARE @myvar DECIMAL(5,2) = 2
PRINT @myvar

-- Explicit Casting
SELECT CONVERT(decimal(5,2), 3)/2
SELECT CAST(3 as DECIMAL(5,2))/2

select system_type_id, column_id, FLOOR(system_type_id / column_id) as Calculation
from sys.all_columns


-- String Types(char,varchar,nvarchar,nchar)
-- char & varchar takes 1byte, nchar and nvarchar 2 bytes 

DECLARE @myName char(10)
SET @myName = 'satish'
PRINT @myName
-- DATALENGTH return length of the varibale assigend 
SELECT @myName as Name, LEN(@myName) as myLength, DATALENGTH(@myName) as myDataLength;

--nvarchar example, must put N before the literal so that sql can identify it.
SELECT 'Satishق' -- It print ? for the Urdu letter as it is unable to recognize it. 
SELECT N'Satishق'

-- Extracting data
-- left and right method for extracting data from string, letter start from 1 not 0
GO
DECLARE @myName AS varchar(10) = 'satish'
SELECT LEFT(@myname, 2) -- Print the first 2 letter from left
SELECT RIGHT(@myName, 2) -- print the last 2 letters from right
SELECT SUBSTRING(@myName, 2,4) -- to print string from 2 to 5 SUBSTRING(varName, startIndex, Length)
-- LTRIM and RTRIM to remove the space from string.
-- REPLACE
SELECT REPLACE(@myName, 'a','A') -- Replaces a with A
-- UPPER and LOWER to convert case
--DefAULT VALUE IS NULL
DECLARE @my int
SELECT @my;



-- TRY CONVERT and TRY CAST :: It tries to convert or cast and return null values if any error occurs. It doesn't throw error
GO
--CONCATING THE STRING 
DECLARE @firstname as nvarchar(10)
DECLARE @middlename as nvarchar(10)
DECLARE @lastname as nvarchar(10)

SET @firstname = 'satish'
-- set @middlename = 'kumar'
SET @lastname = 'singh'
-- if any of the name is null then it will return null in the output
SELECT @firstname+' ' + IIF(@middlename is null,'',''+@middlename)+' '+@lastname AS IFFEXAMPLE-- if the middle name is null then it return empty string

-- Another way to implement above using CASE
SELECT @firstname + CASE WHEN @middlename IS NULL THEN '' ELSE ''+@middlename END + @lastname as CASEEXAPMPLE;

-- Another way using CONCAT it ignores NULL values on its own.
SELECT CONCAT(@firstname ,' '+ @middlename, ' '+ @lastname) AS CONCATEX;

-- FORMAT method to convert nummbers into currency
-- https://database.guide/standard-numeric-format-strings-supported-by-format-in-sql-server/

-- DATE TIME in SQL SERVER
DECLARE @dateToday AS datetime = '2021-03-31'
PRINT @dateToday
GO
DECLARE @dateToday AS datetime = '20150331' -- Slash or Hyphen to separate date, month and year are optional
PRINT @dateToday

--DATEFROMPARTS
SELECT DATEFROMPARTS(2015,03,31) as todayDate;
-- Extracting year, month and day from dates
SELECT year(@dateToday) as YearEx, MONTH(@dateToday) as MonthEx, DAY(@dateToday) as DayEx;

-- Getting Current System Time and Date
SELECT CURRENT_TIMESTAMP AS "current_time_stamp"; -- less accurate 3 places of decimal
SELECT SYSDATETIME() as "system date time"; -- more accurate 7 places of decimal
SELECT GETDATE() as "get date"; -- same as current time stamp

-- date add and difference
SELECT DATEADD(YEAR, 1, CURRENT_TIMESTAMP) AS "PLUS YEar"; -- add 1 year
SELECT DATEADD(MONTH, 1, CURRENT_TIMESTAMP) AS "PLUS YEar"; -- add 1 month
SELECT DATEDIFF(MONTH, CURRENT_TIMESTAMP, DATEADD(MONTH, 1, CURRENT_TIMESTAMP)) AS "DATE_DIFF"; -- MONTH difference
SELECT DATEDIFF(YEAR, CURRENT_TIMESTAMP, DATEADD(YEAR, 1, CURRENT_TIMESTAMP)) AS "DATE_DIFF_YEAR"; -- Year differec\nce

-- Extract  hour
SELECT DATEPART(HOUR, CURRENT_TIMESTAMP) AS "Hour Extracted"; -- Extract hour from time
SELECT DATEPART(YEAR, CURRENT_TIMESTAMP) AS "Year Extracted"; -- Extract YEAR from time
SELECT DATEPART(MINUTE, CURRENT_TIMESTAMP) AS "Minute Extracted"; -- Extract Minute from time

--UTC DATE TIME

SELECT SYSUTCDATETIME() AS "SYSUTCDATETIME"; -- Gives UTC time
SELECT SYSDATETIMEOFFSET() AS "SYSDATETIMEOFFSET"; -- GIves date time in GMT + format

-- Switch Offset to convert time zone
SELECT SWITCHOFFSET(CURRENT_TIMESTAMP, '+05:00') AS 'GMT+5'; -- coverting current time of our system to GMT+5

-- Converting Date to String
SELECT CONVERT(DATE, 'Thursday, 1 April 2021') AS "DATE" -- Gives error as Thursday is string and convert fails here, use parse to solve the error
SELECT PARSE('Thursday, 1 April 2021' AS DATE) AS 'ParseDate';  -- It works

-- FORMAT function help in converting date easily



/* ----------------------- SESSION 2 DEMO ----------------------- */
CREATE TABLE tblEmployee
(
	EmployeeNumber INT NOT NULL,
	EmployeeFirstName VARCHAR(50) NOT NULL,
	EmployeeMiddleName VARCHAR(50) NULL,
	EmployeeLastName VARCHAR(50) NOT NULL,
	EmployeeGovernmentID CHAR(10) NULL,
	DateOfBirth DATE NOT NULL
)


-- Adding additional columns
ALTER TABLE tblEmployee
ADD Department VARCHAR(10);

ALTER TABLE tblEmployee
DROP COLUMN Department

ALTER TABLE tblEmployee
ADD Department VARCHAR(15)

ALTER TABLE tblEmployee
ALTER COLUMN Department VARCHAR(20)


INSERT INTO tblEmployee([EmployeeFirstName],[EmployeeMiddleName],
[EmployeeLastName],[EmployeeGovernmentID],[DateOfBirth],[Department],[EmployeeNumber])
VALUES ('Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation',131)

INSERT INTO tblEmployee
VALUES (1, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'),
(2,'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation')

SELECT * FROM	dbo.tblEmployee;

Select * from tblEmployee
where [EmployeeLastName] like '[r-t]%' -- EmployeeLastName should start between r-t

Select * from tblEmployee
where [EmployeeLastName] like '[^rst]%' -- Not R,S,T in starting of Last Name

-- % = 0-infinity characters
-- _ = 1 character
-- [A-G] = In the range A-G.
-- [AGQ] = A, G or Q.
-- [^AGQ] = NOT A, G or Q.

select * from tblEmployee
where EmployeeLastName like '[%]%' -- Last name should start with %

		
-- Summarising an ordering data
select * from satish.dbo.tblEmployee
where DateOfBirth between '19760101' and '19861231'

select * from tblEmployee
where DateOfBirth >= '19760101' and DateOfBirth < '19870101'

SELECT YEAR(dateofbirth) AS "YEAR", COUNT(*) AS "COUNT" FROM tblEmployee GROUP BY YEAR(DateOfBirth) ORDER BY COUNT DESC;

--Updating NUll

Update tblEmployee
Set EmployeeMiddleName = NULL
Where EmployeeMiddleName = ''

SELECT * FROM tblEmployee

