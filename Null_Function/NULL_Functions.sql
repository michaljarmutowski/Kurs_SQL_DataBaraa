-- null function
use salesdb;

-- finde the average scores of the customers 

SELECT * FROM customers;

SELECT 
	Customerid,
    score,
    AVG(COALESCE(score,0)) OVER() AvgScores2
FROM 
	customers;
    
/*Display full name of customers in a single field by merging their 
	first and last names and add 10 bonus points to each customer's score*/
    
SELECT * FROM customers;

SELECT
	customerid,
    CONCAT(firstname,' ', coalesce(lastname,'unknown')) as full_name,
    ifnull(score,0) + 10 as score_with_bonus
FROM 
	customers;

-- sort the customers from lowest to highest scores, with NULLs appearing last 

SELECT 
	customerid,
    score
    -- coalesce(score,10000000)
FROM 
	customers
ORDER BY  CASE WHEN score IS NULL THEN 1 ELSE 0 END, Score;

-- Find the sales price for each order by dividing sales by quantity

SELECT 
	orderid,
    sales,
    quantity,
    sales/nullif(quantity,0) as PRICE
FROM orders;

-- Identify the customers who have no scores

SELECT * FROM customers;

SELECT
	customerid,
    firstname,
    ifnull(lastname,'unknown') as lastname,
    country
FROM 
	customers
WHERE score is null;

-- List all customers who have scores

SELECT
	customerid,
    firstname,
    ifnull(lastname,'unknown') as lastname,
    country
FROM 
	customers
WHERE score is not null;

