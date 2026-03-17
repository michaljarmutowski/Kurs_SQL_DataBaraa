-- NO JOIN
use mydatabase;

/* Retrieve all data from customers
	and orders as separate results (no join)
*/

SELECT *
FROM
	customers;
    
SELECT * 
FROM
	orders;
    
/* Get all customers along with their orders,
but only for customers who have placed an order (inner join)*/

SELECT 
	c.id,
	c.first_name,
	o.order_id,
    o.sales
FROM customers as c 
INNER JOIN orders as o
ON c.id = o.customer_id;

/* Get all customers along with their orders
	including those without orders (left join)*/
    
SELECT 
	c.id,
	c.first_name,
	o.order_id,
    o.sales
FROM customers as c 
LEFT JOIN orders as o
ON c.id = o.customer_id;

/* Get all customers along with their orders
	including those without matching customers (right join)*/
    
SELECT 
	o.order_id,
    o.sales,
	c.id,
	c.first_name
FROM customers as c 
RIGHT JOIN orders as o
ON c.id = o.customer_id;

/* Get all customers along with their orders
	including those without matching customers using left join*/
    
SELECT 
	o.order_id,
    o.sales,
	c.id,
	c.first_name
FROM orders as o 
LEFT JOIN customers as c
ON c.id = o.customer_id;

/* Get all customers who haven't placed any order (left anti join) */

SELECT * FROM orders;

SELECT * 
FROM customers
Left JOIN orders 
ON customers.id = orders.customer_id
WHERE orders.customer_id IS NULL;

/* Get all orders without matching customers (right anti join) */

SELECT * 
FROM customers as c 
RIGHT JOIN orders as o
ON c.id = o.customer_id
WHERE c.id IS NULL;

/* Get all orders without matching customers using left join */

SELECT * 
FROM orders as o 
LEFT JOIN customers as c
ON o.customer_id = c.id
WHERE c.id IS NULL;

-- Generate all possible combinations of customers and orders (cross join)

SELECT * 
FROM customers 
CROSS JOIN orders;

/* Using SalesDB, Retrieve a list of all orders, along with the
	related customer, product and employee details For each order, 
    display Order ID, Customer's name Product name, Sales amount, 
    Product price, Salesperson's name (Multiple Table JOINS)*/
use salesdb;

SELECT 
	o.OrderID,
    o.Sales,
    c.FirstName,
    c.LastName,
    p.Product as ProductName,
    p.Price,
    e.FirstName,
    e.LastName
FROM Orders AS o
LEFT JOIN Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Employees AS e 
ON o.SalesPersonID = e.EmployeeID;
 