-- ====== CTAS & TEMP TABLE
use salesdb;

CREATE TABLE MonthlyOrders AS
(
SELECT
	month(orderdate) AS OrderMonth,
    COUNT(orderid) TotalOrders
FROM orders
GROUP BY month(orderdate)
);

DROP TABLE MonthlyOrders;

-- TEMP TABLE
CREATE TEMPORARY TABLE Orders_copy AS
(
SELECT *
FROM Orders
);

SELECT * FROM Orders_copy;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Orders_Copy WHERE orderstatus = 'Delivered';

CREATE TABLE OrdersTest AS
(
SELECT *
FROM Orders_copy
);

SELECT * FROM OrdersTest;


