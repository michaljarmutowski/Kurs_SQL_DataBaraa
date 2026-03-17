-- SQL SET OPERATORS
use salesdb;
/*Combine the data from employees
  and customers into one table (union)*/
  
SELECT * FROM employees;
SELECT * FROM customers;
SELECT 
	firstname,
    lastname
FROM
	employees
UNION
SELECT 
	firstname,
    lastname
FROM 
	customers;
/*Combine the data from employees and customers into 
one table including duplicates (union all)*/
    
SELECT 
	firstname,
    lastname
FROM
	employees
UNION ALL
SELECT 
	firstname,
    lastname
FROM 
	customers;
   
/*Orders are stored in separate tables (Orders and OrdersArchieve)
Combine all orders into one repoert without dupliicates (Union)*/

SELECT * FROM orders;
SELECT * FROM orders_archive;

SELECT * 
FROM
	orders
UNION
SELECT *
FROM
	orders_archive;