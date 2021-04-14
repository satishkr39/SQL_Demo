-- OVER(): It calcualtes the entire sum of a column and then we can perform some sort of operatiom if we want. 
-- Function OVER() eliminates the usuage of GROUP BY clause
SELECT E.EmployeeNumber, A.NumberAttendance, A.AttendanceMonth, SUM(A.NumberAttendance) OVER() AS TotalAttendance, 
--Over calculates entire sum of NumberAttendance column 
CONVERT(DECIMAL(18,7), A.NumberAttendance)/SUM(A.NumberAttendance) OVER()* 100.0000 AS PercentageAttendace
-- Line 5 calculating the percentage in terms of total attendance
FROM tblAttendance A
INNER JOIN tblEmployee E
ON E.EmployeeNumber = A.EmployeeNumber;

-- PARTITION BY :: SYNTAX - OVER(PARTITION BY E.EmployeeNumber)
-- It refines the rows. it implements the aggregate function using the E.EmployeeNumber 
-- So the sum is now returning the SUM of the particular employee number instead of entire row sum.
SELECT E.EmployeeNumber, A.NumberAttendance, A.AttendanceMonth, 
SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber) AS TotalAttendance
-- CONVERT(DECIMAL(18,7), A.NumberAttendance)/SUM(A.NumberAttendance) OVER()* 100.0000 AS PercentageAttendace
FROM tblAttendance A
INNER JOIN tblEmployee E
ON E.EmployeeNumber = A.EmployeeNumber
WHERE A.AttendanceMonth < '20150101'