-- SUBQUERIES

/* Find the products that have a price higher than the average price of all products*/
use salesdb;
SELECT * FROM products;

SELECT 
	*
FROM (
SELECT 
	productid,
	price,
	AVG(price) OVER() AVG_price
FROM products
)t WHERE price > AVG_price;

-- Rank customers based on their total amount of sales 


SELECT * FROM orders;

SELECT
	*,
    RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM(
SELECT 
	Customerid,
    Sum(sales) AS TotalSales
FROM orders
GROUP BY customerid
)t ;

-- Show the product ids, names, prices and total number of orders

SELECT * FROM products;
SELECT * FROM orders;

SELECT 
	productid,
    product,
    price,
    (SELECT	COUNT(orderid) FROM orders) AS TotalNumberOdOrders 
FROM products;

-- Show all customers details and find the total orders of each customer 

SELECT * FROM customers;
SELECT * FROM orders;

SELECT 
	*
FROM customers c LEFT JOIN orders o ON c.customerid = o.customerid;

SELECT 
	c.*,
    o.TotalOrders
FROM customers c
LEFT JOIN (
SELECT 
	customerid,
	COUNT(orderid) AS TotalOrders 
	FROM orders 
GROUP BY customerid) o ON o.customerid = c.customerid;

-- Find the products that have a price higher than the average price of all products

SELECT 
	*,
    ROUND((SELECT AVG(price) FROM products)) AS AvgPrice
FROM products 
WHERE price > (SELECT AVG(price) FROM products);


-- Show the details of orders made by customers from Germany

SELECT * FROM customers;
SELECT * FROM orders;


SELECT 
	*
FROM orders WHERE Customerid IN 
							(SELECT 
							customerid
							FROM customers
							WHERE country = 'Germany');
                            
-- Show the details of orders made by customers who are not from Germany

SELECT 
	*
FROM orders WHERE Customerid NOT IN 
							(SELECT 
							customerid
							FROM customers
							WHERE country = 'Germany');
                            
-- find female employees whose salaries are greater than the salaries of any male employees

SELECT * FROM employees;

SELECT 
	firstname,
    lastname,
    salary
FROM employees
WHERE gender = 'F' AND salary >ANY
								(SELECT 
									salary 
								FROM employees WHERE gender = 'M');
                                
-- find female employees whose salaries are greater than the salaries of all male employees

SELECT * FROM employees;

SELECT 
	firstname,
    lastname,
    salary
FROM employees
WHERE gender = 'F' AND salary >ANY
								(SELECT 
									salary 
								FROM employees WHERE gender = 'M');


-- Show the order details for customers from Germany (using exists)

SELECT * FROM customers;
SELECT * FROM orders;

SELECT
	* 
FROM orders o
WHERE EXISTS (SELECT 1 
				FROM customers c 
                WHERE country = 'Germany' 
                AND c.customerid = o.customerid);