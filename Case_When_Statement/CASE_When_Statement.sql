-- case when statement

/* 	Generate a report showing the total sales for each category
	High: sales > 50
	Medium salex between 20 and 50
    Low sales < 20
    Sort the result from lowest to highest*/
    
    use salesdb;
    
    SELECT 
		category,
        SUM(sales) as TotalSales
	FROM(
		SELECT
			orderid,
			sales,
		CASE
			WHEN sales > 50 THEN 'High'
			WHEN sales > 20 AND sales <= 50 THEN 'Medium'
			ELSE 'Low'
		END category 
		FROM orders)t
	GROUP BY Category
    ORDER BY TotalSales DESC;
    
-- Retrive employee details with gender displayed as full text 

SELECT 
	employeeid,
    firstname,
    lastname,
    gender,
    CASE
		WHEN gender = 'M' THEN 'MEN'
        ELSE 'FEMALE'
    END as full_text
FROM employees;

-- Retrive customer details with abbreviated country code 
SELECT * FROM customers;

SELECT 
	customerid,
    firstname,
    lastname,
    country,
    CASE
		WHEN country = 'Germany' THEN 'DE'
        WHEN country = 'USA' THEN 'US'
        ELSE 'n/a'
    END as CountryAbbr
FROM customers;

-- quick form

SELECT 
	customerid,
    firstname,
    lastname,
    country,
    CASE country
		WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN 'US'
        ELSE 'n/a'
    END as CountryAbbr
FROM customers;

/* Find the average scores of customers and treat Nulls as 0
	add additional provide details such CustomerId & LastName
*/
select * from customers;

SELECT 
	customerid,
    lastname,
    score,
    CASE
		WHEN score is null THEN 0
		ELSE score
	END ScoreClean,
    
	avg( CASE
		WHEN score is null THEN 0
        else score
    END) over() AvgCustomerClean,

AVG(score) OVER() AvgCustomer
FROM customers;

-- Count how many times each customer has made an order with sales greater than 30 

SELECT * FROM orders;

	SELECT
        customerid,
        SUM(
		CASE
			WHEN sales > 30 THEN 1 
            ELSE 0
        END) AS TotalOrdersHighSales,
        count(*) TotalOrders
	FROM orders
	GROUP BY customerid;
	