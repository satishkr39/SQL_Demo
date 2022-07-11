-- Write an SQL query to find for each date the number of different products sold and their names.
--The sold products names for each date should be sorted lexicographically.
--Return the result table ordered by sell_date.

select A.sell_date, count(product) as num_sold, STRING_AGG(A.product,',') as products from
(select distinct sell_date, product from Activities) A
group by A.sell_date order by A.sell_date;