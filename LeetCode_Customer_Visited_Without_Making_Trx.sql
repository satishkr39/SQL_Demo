-- Write an SQL query to find the IDs of the users who visited without 
-- making any transactions and the number of times they made these types of visits.
-- Return the result table sorted in any order.



/* Write your T-SQL query statement below */
select A.customer_id, count(A.visit_id) as count_no_trans  from Visits A 
LEFT JOIN Transactions B on A.visit_id = B.visit_id  where 
B.amount is null group by A.customer_id;