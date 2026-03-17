-- String Functions

-- Concatenate first name and country into one column (concat)
use mydatabase;

SELECT 
	first_name,
    country,
    CONCAT(first_name,'-',country) AS name_country
FROM customers;

-- Convert the first name to lowercase

SELECT 
	first_name,
    LOWER(first_name) as lower_first_name
FROM 
	customers;
    
-- Convert the first name to uppercase

SELECT 
	first_name,
    UPPER(first_name) as upper_first_name
FROM 
	customers;
    
-- Find customers whose first name contains leading or trailing spaces (trim)

SELECT 
	first_name
FROM 
	customers
WHERE first_name != TRIM(first_name);

-- Remove dashes (-) from a phone number 

SELECT '123-456-7890', REPLACE('123-456-7890', '-', ' ') as new_number;

-- Replace Fle Extence from txt to csv (replace)

SELECT 'report.txt', REPLACE('report.txt','txt','csv') as new_extence;

-- Calculate the length of each customer's first name (length)

SELECT
	first_name,
    length(first_name) as name_length
FROM
	customers;

-- Retrieve the first two characters of each first name (left,right)

SELECT 
	first_name,
    LEFT(TRIM(first_name),2) as first_two_letters,
	RIGHT(TRIM(first_name),2) as first_two_letters

FROM
	customers;

-- Retrieve a list of customers first names removing the first character (substring)

SELECT 
	first_name,
    substring(TRIM(first_name),2,length(TRIM(first_name))) as without_first_character
FROM	
	customers;
    