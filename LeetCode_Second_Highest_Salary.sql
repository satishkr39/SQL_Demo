-- LeetCode: Second Highest salary
Create table Employee (id int, salary int);
insert into Employee values (1, 100), (2,200), (3,300);

-- Write an SQL query to report the second highest salary from the Employee table. 
-- If there is no second highest salary, the query should report null.

/* Write your T-SQL query statement below */
select ISNULL(salary , NULL) as SecondHighestSalary from (
SELECT *,ROW_NUMBER() OVER(PARTITION BY NULL order by salary asc) as SecondHighestSalary 
from Employee) E where E.SecondHighestSalary = 2

select ISNULL((SELECT DISTINCT Salary FROM Employee order by Salary DESC OFFSET  1 ROWS 
FETCH NEXT 1 ROWS ONLY ),null) as SecondHighestSalary