/************** UNION/INTERSECTION/OTHER FUNCTION ***************/
-- UNION joins two table. The table should have same number of rows and data compatible must be there. the Colum name is taken
-- from the first table. Duplicates are not inserted. If we don't want to remove duplicates then use UNION ALL.
-- We get error if we try to union having different data types. 
SELECT CONVERT(char(4), 'Hi') AS 'colName'
UNION
SELECT CONVERT(char(20), 'Hi, Hello There') 
UNION
SELECT CONVERT(char(20), 'Namaste') 
UNION
SELECT CONVERT(char(20), 'Hi')  -- Excluded as it's already inserted.


/************** INTERCEPT AND EXCEPT ******************/
-- EXCEPT is like Difference of SET. IT gives the difference of the two tables. The rows of tabl2 which are not present in tbl1 
-- are given in output.

-- INTERESECT is like, giving only common in both the tables.

/********** CASE ************/

DECLARE @Myoption VARCHAR(10) = 'Option C'

SELECT  
CASE 
	WHEN @Myoption = 'Option A' THEN 'Option A'
	WHEN @Myoption = 'Option B' THEN 'Option B'
	ELSE 'No Option'
END AS 'option'

/********** ISNULL(arg1, arg2) ************/
-- if arg1 is null then it looks for arg2 and so on.
DECLARE @myvar VARCHAR(10) = 'Option C'
SELECT ISNULL(@myvar, 'Option Not Give') AS ISNULLDEMO -- When myvar is null it takes arg2 and when arg1 is not null it takes arg1 only

/********** COALESCE ************/
-- It takes atleast 1 argument. and works same as ISNULL method. It keeps looking in all the args provided untill non null values 
-- is encountered.
DECLARE @var1 VARCHAR(10) = 'var1'
DECLARE @var2 VARCHAR(10) = 'var2'
SELECT COALESCE(@var1, @var2, 'Option Not Give') AS COALESCEDEMO -- it iterates through all the args and stops when it gets non null values
								-- if no non-null values is met then it selects the last default option
-- For COALESCE atleast one of the argument must be non-null.

SELECT ISNULL(NULL,NULL) -- will give NULL
SELECT COALESCE(NULL,NULL) -- will give error

/********** MERGE Statement ************/
-- Match has 3 possibilities - WHEN MATCHED, WHEN NOT MATCHED BY TARGET, WHEN NOT MATCHED BY SOURCE
-- INSERT, UPDATE, DELETE ARE 3 can be done
-- Target Table is tblTransaction and Source Table is tblTransactionNew

-- SYNTAX OF MERGE
MERGE TargetTable AS T
USING SourceTable AS S
ON T.EmployeeNumber = S.EmployeeNumber AND T.DateofTransaction = S.DateofTransaction 
WHEN MATCHED THEN -- we can combine AND/OR
	UPDATE SET Amount = T.Amount + S.Amount
	--AnotherColumn = 'updated row' -- Adding another column along with MERGE query
WHEN MATCHED THEN
	DELETE --- for deleting the row
WHEN NOT MATCHED BY TARGET THEN
	INSERT (Amount, DateofTransaction, EmployeeNumber)
	VALUES (S.Amount, S.Dateoftransaction, S.EmployeeNumber)
WHEN NOT MATCHED BY SOURCE THEN -- Optional 
	UPDATE SET ColumnName = 'Value'
OUTPUT inserted.*, deleted.*; -- This is to show the inserted or updated on console




