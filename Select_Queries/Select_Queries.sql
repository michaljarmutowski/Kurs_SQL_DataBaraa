USE mydatabase;

-- Retrive all customers data
SELECT * FROM customers;

-- Retrive all order data
SELECT * FROM orders;

-- Retrive columns (name,country and score)

SELECT 
	first_name, 
    country, 
    score 
FROM customers;

-- Retrive customers with a score not equal to 0

SELECT * 
FROM customers
WHERE score != 0;

-- Retrive customers (first_name,country) from Germany

SELECT 
	first_name,
    country
FROM 
	customers
WHERE 
	country = 'Germany';

-- Retrive all customers and sort the results by the highest score first

SELECT * 
FROM 
	customers
ORDER BY 
	score DESC;
    
/* Retrive all customers and sort the results 
by the country and then by the highest score */

SELECT *
FROM
	customers
ORDER BY 
	country ASC,
    score DESC;

/* Find the total score for each country 
 and sort the results by the sum(score) */

SELECT 
	country,
    SUM(score) as total_score
FROM
	customers
GROUP BY 
	country
ORDER BY total_score;

/*Find the total score and total number
 of customers for each country */

SELECT 
	country,
    SUM(score) as total_score,
    COUNT(id) as number_of_customers
FROM
	customers
GROUP BY country;

/*
	Find the average score of each country considering 
    only customers with a score not equal to 0 and return
    only counties with an average score greater then 430
*/

SELECT
	Country,
    ROUND(AVG(score),2) as average_score
FROM 
	customers 
WHERE 
	score != 0
GROUP BY 
	country
HAVING average_score >430;

-- Return unique list of all countries

SELECT 	
	DISTINCT country 
from 
	customers;
    
-- Retrive only 3 customers with the highest Score

SELECT 
	first_name,
    country,
    score 
FROM 
	customers
ORDER BY score DESC
LIMIT 3;

-- Get the Two Mosc Recent Orders 
SELECT * FROM orders;
SELECT 
	order_id,
    customer_id,
    order_date,
    sales
FROM
	orders
ORDER BY order_date DESC
LIMIT 2;

select * from customers;
select * from orders;

