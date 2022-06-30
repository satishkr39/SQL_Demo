-- Q: Each node in the tree can be one of three types:
/*
"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.
Return the result table ordered by id in ascending order.
*/
create table Tree (id int, p_id int);
insert into tree values(1, null),(2,1),(3,1),(4,2),(5,2);
select * from Tree;

/* Write your T-SQL query statement below */
SELECT	id, 
		case 
			when p_id is null then 'Root' 
		else 
			case 
				when id in (select p_id from Tree) then 'Inner'
			else
				'Leaf' end
		end as 'type'
from Tree