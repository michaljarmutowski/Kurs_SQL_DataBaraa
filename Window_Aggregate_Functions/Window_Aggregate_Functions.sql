-- WINDOW AGGREGETE FUNCTION

-- Find the total number of orders

use salesdb;
SELECT * FROM ORDERS;

SELECT 
	COUNT(*) AS TotalOrders
FROM orders;

-- Find the total number of orders additionally provide detals such order id & order date

SELECT 
	orderid,
    orderdate,
	COUNT(*) OVER() AS TotalOrders
FROM orders;

/* 	Find the total number of orders 
	Find the total number of Orders for each customers
	additionally provide detals such order id & order date */

SELECT 
	orderid,
    orderdate,
    customerid,
	COUNT(*) OVER() AS TotalOrders,
    COUNT(*) OVER(PARTITION BY customerid) AS Total_orders_for_each_customer
FROM orders;

/*
	Find the total number of customers, additionally
    provide all customer's details
*/

SELECT * FROM customers;

SELECT 
	customerid,
    firstname,
    CASE WHEN lastname is null THEN 'unknown' ELSE lastname END AS lastname,
    country,
    score,
    COUNT(*) OVER() AS total_number_of_customers
FROM customers;

-- Find the total number of scores for the customers

SELECT * FROM customers;

SELECT 
	*,
	COUNT(Score) OVER () AS total_scores
FROM customers;

-- Check whether the table "Orders" contains any duplicates rows

SELECT 
	orderid,
    COUNT(*) OVER (PARTITION BY orderid) AS CheckPK
FROM orders;

/* 	Find the total sales across all orders and the total sales for each
	product additionally provide details such as orderID and order date 	*/
   

SELECT * FROM orders;
    
SELECT 
	orderid,
    orderdate,
    sales,
    productid,
    SUM(sales) OVER () AS total__sales,
    SUM(sales) OVER (PARTITION BY productid) AS sales_by_product
FROM orders;

-- Find the percentage contribution of each product's sales to the total sales

SELECT 
	orderid,
    productid,
    sales,
    SUM(sales) OVER () AS Total_sales,
    sales/SUM(sales) OVER () * 100 AS Percentage
FROM orders;

/*	Find the average sales across all orders 
	and the average sales for each product 
	additionally, provide details such as order id and order date*/
SELECT * FROM orders;
SELECT 
	orderid,
    orderdate,
    sales,
    ROUND(AVG(Sales) OVER ()) AS average_order_sales,
	ROUND(AVG(COALESCE(Sales,0)) OVER (PARTITION BY productid)) AS average_product_sales
FROM orders;

-- Find the average scores of customers additionally provide details such CustomerID and LastName

SELECT 
	customerid,
    lastname,
    score,
    ROUND(AVG(COALESCE(score,0)) OVER ()) AS avg_customers_score 
FROM customers;

-- Find all orders where sales are higher than the average sales across all orders

SELECT * 
FROM (
	SELECT 
		orderid,
		productid,
		sales,
		ROUND(AVG(sales) OVER ()) AS AvgSales
	FROM orders
)t WHERE sales > AvgSales;

/* 	Find the highest and lowest sales across all orders
	and the highest and lowest sales for each product
	additionally provide details such as orderid and orderdate*/
    SELECT * FROM orders;
SELECT 
	orderid,
    orderdate,
    sales,
	MAX(Sales) OVER() AS highest_sales,
	MIN(Sales) OVER() AS lowest_sales,
	MAX(Sales) OVER(PARTITION BY productid) AS product_highest_sales,
	MIN(Sales) OVER(PARTITION BY productid) AS product_lowest_sales
FROM orders;

-- Show the employees who have the highest salaries
SELECT * FROM employees;

SELECT * 
FROM(
SELECT 
  *,
  MAX(salary) OVER () AS Max_salary
FROM employees
) t WHERE salary = Max_salary;

-- Find the deviation of each sales from the minimum and maximum sales amount

SELECT
	orderid,
    orderdate,
    productid,
    sales,
    MAX(sales) OVER() AS HighestSeles,
    MIN(sales) OVER() AS LowestSales,
    sales - MIN(sales) OVER () DeviationFromMin,
	MAX(sales) OVER() - sales AS DeviationFromMax
FROM orders;

-- Calculate the moving average of sales for each product over time 

SELECT * FROM orders;

SELECT 
	orderid,
    productid,
    orderdate,
    sales,
    ROUND(AVG(sales) OVER (PARTITION BY productid),2) AS avg_by_product,
	ROUND(AVG(sales) OVER (PARTITION BY productid ORDER BY orderdate),2) AS moving_avg
FROM orders;

-- Calculate the moving average of sales for each product over time including only the next order

SELECT 
	orderid,
    productid,
    orderdate,
    sales,
    ROUND(AVG(sales) OVER (PARTITION BY productid),2) AS avg_by_product,
	ROUND(AVG(sales) OVER (PARTITION BY productid ORDER BY orderdate),2) AS moving_avg,
    ROUND(AVG(sales) OVER (PARTITION BY productid ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),2) AS rolling_avg
FROM orders;