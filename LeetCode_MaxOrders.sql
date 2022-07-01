--Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.

CREATE TABLE Orders(order_number int, customer_number int);

insert into orders values(1,1),(2,2),(3,3),(4,3)

select * from orders

select max()

-- My Solution
select customer_number from (
select top 1 max(count_nu) as maxcount, customer_number from (
select count(order_number) as count_nu, customer_number from orders group by customer_number) A
group by customer_number order by max(count_nu) desc 
) B

-- BEst Solution
select top 1 customer_number from orders
group by customer_number
order by count(*) desc;