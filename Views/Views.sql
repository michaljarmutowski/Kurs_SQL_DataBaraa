-- ======= Views

-- find the running total of sales for each month 
use salesdb;

-- CTE
WITH CTE_Monthly_Summary AS (
SELECT 
	MONTH(orderdate) as OrderMonth,
    SUM(Sales) TotalSales,
    COUNT(orderid) TotalOrders,
    SUM(quantity) TotalQuantities
FROM orders
GROUP BY MONTH(orderdate)
)
SELECT 
	ordermonth,
    TotalSales,
    SUM(TotalSales) OVER (ORDER BY OrderMonth) AS RunningTotal
    FROM CTE_Monthly_Summary;

-- View
CREATE VIEW V_Monthly_Summary AS
(
	SELECT 
		MONTH(orderdate) as OrderMonth,
		SUM(Sales) TotalSales,
		COUNT(orderid) TotalOrders,
		SUM(quantity) TotalQuantities
	FROM orders
	GROUP BY MONTH(orderdate)
);

SELECT * FROM v_monthly_summary;

-- Provide a view that combines details from orders, products, customers and employees

CREATE VIEW salesdb.V_Order_Details AS
(
	SELECT
		o.orderid,
		o.orderdate,
		p.productid,
		p.category,
		CONCAT(COALESCE(c.firstname,''),' ', COALESCE(c.lastName,'')) AS CustomerName,
		c.country as CustomerCountry,
		CONCAT(COALESCE(e.firstname,''),' ', COALESCE(e.lastname,'')) AS SalesName,
		e.department,
		o.sales,
		o.quantity
	FROM orders o
	LEFT JOIN products p
	ON p.productid = o.productid
	LEFT JOIN customers c
	ON c.customerid = o.customerid
	LEFT JOIN employees e
	ON e.employeeid = o.salespersonid
);

SELECT * FROM v_order_details;

-- Provides a view for the EU Sales Team that combines details 
-- from all tables and excludes date telated to the USA 

CREATE VIEW salesdb.V_Order_Details_EU AS
(
	SELECT
		o.orderid,
		o.orderdate,
		p.productid,
		p.category,
		CONCAT(COALESCE(c.firstname,''),' ', COALESCE(c.lastName,'')) AS CustomerName,
		c.country as CustomerCountry,
		CONCAT(COALESCE(e.firstname,''),' ', COALESCE(e.lastname,'')) AS SalesName,
		e.department,
		o.sales,
		o.quantity
	FROM orders o
	LEFT JOIN products p
	ON p.productid = o.productid
	LEFT JOIN customers c
	ON c.customerid = o.customerid
	LEFT JOIN employees e
	ON e.employeeid = o.salespersonid
    WHERE c.Country != 'USA'
);

SELECT * FROM salesdb.V_Order_Details_EU;