-- WINDOW RANKING FUNCTION

-- Rank the orders based on their sales from highest to lowest using row_number, rank, dense_rank
USE salesdb;
SELECT * FROM ORDERS;

SELECT 
	orderid,
    productid,
    sales,
	ROW_NUMBER() 	OVER (ORDER BY sales DESC) AS SalesRank_Row,
    RANK() 			OVER (ORDER BY sales DESC) AS SalesRank_Rank,
    DENSE_RANK() 	OVER(ORDER BY sales DESC) AS SalesRank_DenseRank
FROM orders;

-- Find the top highest sales for each product 
SELECT *
FROM(
SELECT 
	orderid,
    productid,
    sales,
    ROW_NUMBER()	OVER(PARTITION BY productid ORDER BY sales DESC) AS RankByProduct
FROM orders
) t WHERE RankByProduct = 1;

-- Find the lowest 2 customers based on their total sales 

SELECT * FROM customers;
SELECT * FROM orders;

SELECT * FROM(
SELECT 
	customerid,
    SUM(sales) AS TotalSales,
    ROW_NUMBER() OVER (ORDER BY SUM(sales)) AS RankCustomers
FROM orders
GROUP BY customerid
)t WHERE RankCustomers BETWEEN 1 AND 2;

-- Assign uniqie IDs to the rows of the 'Orders Archive' table

SELECT * FROM orders_archive;

SELECT 
    ROW_NUMBER() OVER (ORDER BY orderid, orderdate) UniqueID,
    o.*
FROM orders_archive o;

-- Identify duplicate rows in the table 'Orders Archive' and return a clean result without any duplicates

SELECT * FROM(
SELECT 
	ROW_NUMBER()	OVER(PARTITION BY orderid ORDER BY creationtime DESC) rn,
    o.*
FROM orders_archive o
)t WHERE rn = 1;

-- Find the products that fall within the highest 40% of prices

SELECT *,
CONCAT(DistRank * 100, '%') AS Percent_result
FROM(
SELECT 
	product,
    price,
    CUME_DIST()	OVER(ORDER BY price DESC) as DistRank
FROM products
)t WHERE DistRank <= 0.4;

-- Segment all orders into 3 categories high,medium and low sales

SELECT * FROM orders;

SELECT 
*,
CASE 
	WHEN categories = 1 THEN 'High'
	WHEN categories = 2 THEN 'Medium'
	WHEN categories = 3 THEN  'Low' 
END SalesSegmentation
FROM(
SELECT 
	orderid,
    productid,
    sales,
    NTILE(3) 	OVER(ORDER BY sales DESC) AS categories
FROM orders
)t;

-- In order to export the data divide the orders into 2 groups

SELECT 
	NTILE(2)	OVER (ORDER BY orderid) AS Buckets,
    o.*
FROM orders o;
    