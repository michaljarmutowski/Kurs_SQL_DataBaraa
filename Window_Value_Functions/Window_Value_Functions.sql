-- ============WINDOW VALUE FUNCTIONS=================

/*	Analize the month over month (MoM) performance by finding the
 percentage change in sales between the current and previous month*/
SELECT
*,
CurrentMonthSales - PreviousMonthSales AS MoM_change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100,1) AS MoM_Perc 
FROM( 
 SELECT 
    MONTH(orderdate) OrderMonth,
    SUM(sales) AS CurrentMonthSales,
    LAG(SUM(sales))	OVER (ORDER BY MONTH(orderdate)) AS PreviousMonthSales
FROM orders
GROUP BY 
	MONTH(orderdate)
)t;

/*	In order to analyze customer loyalty rank customers 
	based on the average days between their orders*/

SELECT
	customerid,
    AVG(DaysUntilNextOrder) AvgDays,
    RANK() OVER (ORDER BY COALESCE(AVG(DaysUntilNextOrder),99999)) AS RankAvg
FROM(
SELECT 
    orderid,
    customerid,
    orderdate,
    LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate) AS NextOrder,
    DATEDIFF(
        LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate),
        orderdate
    ) AS DaysUntilNextOrder
FROM orders
)t
GROUP BY customerid;

-- Find the lowest and highest sales for each product

SELECT 
	orderid,
    productid,
    sales,
    FIRST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales) AS LowestSales,
    LAST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
	FIRST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales DESC) AS LowestSalesFirstValue,
	MIN(sales) OVER (PARTITION BY productid) AS LowestSalesUsingMin,
	MAX(sales) OVER (PARTITION BY productid) AS HighestSalesUsingMax
FROM orders;










    