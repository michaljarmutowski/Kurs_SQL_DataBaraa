-- window functions basics

-- Find the total number of orders

use mydatabase;
select * from orders;

SELECT  
	COUNT(order_id) as numer_of_orders
FROM orders;

-- Find total sales fot all orders

SELECT * FROM orders;

SELECT
	SUM(sales) as Total_sales
FROM orders;

-- Find average sales of all orders

SELECT * FROM orders;

SELECT 
	ROUND(AVG(sales)) average_sales
FROM orders;

-- Find the highest sales of all orders

SELECT 
	MAX(sales) as Highest_sales
FROM orders;

-- Find the lowest sales of all orders

SELECT 
	MIN(sales) as Lowest_sales
FROM orders;

-- 						WINDOWS

-- Find the total sales across all orders
use salesdb;

SELECT 
	SUM(sales) as Total_sales
From orders;

/* Find the total sales for each product
Additionally provide details such order Id order date*/
use salesdb;
SELECT * FROM orders;

SELECT 	
	orderid,
    orderdate,
	productid,
	SUM(sales) OVER(PARTITION BY productid) as TotalSalesByProducts
FROM orders;

-- Window Partition By 

/*	Find the total sales across all orders additionally
	provide details such orders id & order date*/
    
SELECT * FROM orders;
SELECT 
		orderid,
        orderdate,
        SUM(sales) OVER () AS total_sales
FROM orders;

/*	Find the total sales across all product additionally
	provide details such orders id & order date*/
    
    
SELECT 
		orderid,
        orderdate,
		productid,
        SUM(sales) OVER (PARTITION BY productid) AS total_sales
FROM orders;

/*	Find the total sales across all orders
	Find the total sales across all product additionally
	provide details such orders id & order date*/
    
    SELECT 
		orderid,
        orderdate,
		productid,
        sales,
		SUM(sales) OVER () AS total_sales,
        SUM(sales) OVER (PARTITION BY productid) AS total_sales_by_products
FROM orders;


/*	Find the total sales across all orders
	Find the total sales across all product 
    Find the total sales for each combination of product and order status
    additionally	provide details such orders id & order date*/
    
    SELECT 
		orderid,
        orderdate,
		productid,
        orderstatus,
        sales,
		SUM(sales) OVER () AS total_sales,
        SUM(sales) OVER (PARTITION BY productid) AS total_sales_by_products,
		SUM(sales) OVER (PARTITION BY productid,orderstatus) AS sales_by_products_and_status
FROM orders;

-- Rank each order based on their sales from highest to lowest

SELECT 
	orderid,
    orderdate,
    productid,
    sales,
    RANK() OVER (ORDER BY sales DESC) as Rank_orders
FROM orders;
