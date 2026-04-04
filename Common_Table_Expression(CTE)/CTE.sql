-- =============== CTE ==============================

-- Step1: Find the total sales per customer (Standalone CTE)
WITH CTE_Total_Sales AS 
(
SELECT 
	customerid,
    SUM(sales) AS TotalSales
FROM orders
GROUP BY customerid
)
-- Step2: Find the last order date per customer (Standalone CTE)
, CTE_Last_Order AS 
(
	SELECT 
    customerid,
    MAX(orderdate) AS LastOrder
    FROM orders
    GROUP BY customerid
)
-- Step3: Rank Customers based on Total Sales Per Customer (Nested CTE)
, CTE_Rank_Customers AS 
(
	SELECT 
	customerid,
    TotalSales,
    RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
	FROM CTE_Total_Sales
)
-- Step4: segment customers based on their total sales (Neste CTE)
, CTE_Customer_Segments AS 
(
	SELECT
	customerid,
    CASE WHEN TotalSales > 100 THEN 'High'
		 WHEN TotalSales > 50 THEN 'Medium'
         ELSE 'LOW'
	END AS CustomerSegments
	FROM CTE_Total_Sales
)

-- Main Query
SELECT 
	c.customerid,
    c.firstname,
    c.lastname,
    cts.TotalSales,
    clo.LastOrder,
    ccr.CustomerRank,
    ccs.CustomerSegments
FROM customers c 
LEFT JOIN CTE_Total_Sales cts
ON cts.customerid = c.customerid
LEFT JOIN CTE_Last_Order clo
ON clo.customerid = c.customerid
LEFT JOIN CTE_Rank_Customers ccr
ON ccr.customerid = c.customerid
LEFT JOIN CTE_Customer_Segments ccs
ON ccs.customerid = c.customerid;

-- Generate a Sequence of Numbers from 1 to 20 

WITH RECURSIVE CTE_Generate AS 
(
	SELECT 1 AS MyNumber 
    UNION ALL 
	SELECT 
    MyNumber + 1 
    FROM CTE_Generate 
    WHERE MyNumber < 20
)

SELECT * FROM CTE_Generate;

-- Show the employee hierarchy by displaying each employee's level with the organization

WITH RECURSIVE CTE_Emp_Hierarchy AS 
( 
-- Anchor Query
SELECT 
	employeeid,
    firstname,
    managerid,
    1 AS Level
FROM employees
WHERE managerid IS NULL
UNION ALL
-- Recersive Query 
SELECT 
	e.employeeid,
    e.firstname,
    e.managerid,
    Level + 1
FROM employees AS e 
INNER JOIN CTE_Emp_Hierarchy ceh
ON e.managerid = ceh.employeeid
)
-- Main Query 
SELECT 
*
FROM CTE_Emp_Hierarchy;
