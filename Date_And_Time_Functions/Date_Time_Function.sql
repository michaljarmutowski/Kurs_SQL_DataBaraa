-- DATA AND TIME FUNCTION
use salesdb;
SELECT * FROM orders;

-- year,month,day,quarter,week functions
Select 
	orderid,
	creationtime,
	-- datepart(year,creatriontime) Year_dp; -- datepart doesn't exist in MYSLQ
    
    quarter(creationtime) as quearter_creationtime,
    week(creationtime) as week_creationtime,
    year(creationtime) as Year,
    month(creationtime) as Month,
    day(creationtime) as Day
    
From
	orders;
    
-- how many orders were placed each year?

SELECT * FROM orders;

SELECT 
	year(orderdate) as year_of_order,
    count(orderid) as number_of_orders
FROM 
	orders
GROUP BY year_of_order;

-- how many orders were placed each month

SELECT 
	month(orderdate) as month_of_order,
    count(orderid) as number_of_orders
FROM 
	orders
GROUP BY month_of_order;

-- show all orders that were placed during the month of February

SELECT 
	*
FROM 
	orders
WHERE
	month(orderdate) = 2;
    
-- format function 

SELECT 
	orderid,
	creationtime,
    DATE_FORMAT(creationtime, '%m-%d-%Y') as 'USA_Format',
	DATE_FORMAT(creationtime, '%d') as '%d',
	DATE_FORMAT(creationtime, '%a') as '%a',
	DATE_FORMAT(creationtime, '%W') as '%W',
    DATE_FORMAT(creationtime, '%m') as '%m',
	DATE_FORMAT(creationtime, '%b') as '%b',
	DATE_FORMAT(creationtime, '%M') as '%M'
FROM
	orders;
    
/* Show creationtime using the following format
	Day Wen Jan Q1 2025 12:34:56 PM*/
    
SELECT 
    orderid,
    creationtime,
    CONCAT(
        'Day ',
        DATE_FORMAT(creationtime, '%W %b Q'),
        QUARTER(creationtime),
        DATE_FORMAT(creationtime, ' %Y %h:%i:%s %p')
    ) AS formatted_date
FROM
    orders;
    
