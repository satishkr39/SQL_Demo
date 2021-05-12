/********* JSON IN SQL Server ************/

DECLARE @JSON NVARCHAR(4000)
-- Assigning  values to JSON
SET @JSON = '
{
"Name" : "Philip",
"Shopping":
	{"ShoppingTrip": 1,
	"Items" :
		[		
			{"Item":"banana", "Cost":5},
			{"Item":"Apple", "Cost":4},
			{"Item":"Cherries", "Cost":3}
		]
	}
}
'
SELECT @JSON
SELECT ISJSON(@JSON) -- Validates the JSON, 1 for True and 0 for error in JSON

-- JSON function JSON_VALUE it returns only 1 value & JSON_QUERY returns an object or an array
SELECT JSON_QUERY(@JSON, '$') -- Entire elements from root till leaf
SELECT JSON_QUERY(@JSON, '$.Shopping') -- Gives shopping items only
SELECT JSON_QUERY(@JSON, '$.Shopping.Items') -- Gives all items

-- Using JSON_VALUE
SELECT JSON_VALUE(@JSON, '$.Name') -- return name only
--SELECT JSON_VALUE(@JSON, 'strict $.name') -- using Strict shows the error in query if any
SELECT JSON_VALUE(@JSON, '$.Shopping.ShoppingTrip')  -- Gives 1 as value
-- Getting items from array
SELECT JSON_VALUE(@JSON, '$.Shopping.Items[0].Item')  -- Banana, gets 0th index items
SELECT JSON_VALUE(@JSON, '$.Shopping.Items[0].Cost') -- Get the cost of 0th index

-- JSON_MODIFY : it is used to modify the json key and values both
SELECT JSON_MODIFY(@JSON,'$.Shopping.Items[0].Item', 'Big Banana') -- Changes values of 0th index to Big Banana
-- Changes key, values of 0th index and the JSON_QUERY converts the string to query
SELECT JSON_MODIFY(@JSON,'$.Shopping.Items[0]', JSON_QUERY('{"Item":"Big Banana", "Cost":10}')) 
-- Adding new key value pair of date
SELECT JSON_MODIFY(@JSON, '$.Date','2021-05-05') AS DateAdded

-- Converting JSON to SQL Server Table
SELECT * FROM OPENJSON(@JSON,'$.Shopping.Items') WITH(Item VARCHAR(10), Cost INT)

-- Converting SQL Server Data into JSON
SELECT 'Banana' AS Item, 5 AS Cost
UNION
SELECT 'Cherry', 6
UNION
SELECT 'Apple', 10
FOR JSON PATH

