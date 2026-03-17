-- DML

-- Insert data 

INSERT INTO customers (id,first_name,country,score)
values 
	(6,'Anna','USA',null),
    (7,'Sam',Null,100);
    
INSERT INTO customers (id,first_name,country,score)
values 
    (7,'Sam',Null,100);

SELECT * FROM customers;

-- Copy data from 'customers' table into 'persons'

INSERT INTO persons (id,person_name,birth_date,phone)
SELECT 
	id,
    first_name,
    null,
    'Unknown'
FROM 
	customers;

SELECT * FROM persons;

-- Change the socre of customers with ID 6 to 0

SELECT * FROM customers;

UPDATE customers SET
	score = 100
WHERE id = 6;

/* Change the score of customers with ID 5
	to 0 and update the country to 'UK'
*/

UPDATE customers SET 
	score = 0,
    country = 'UK'
WHERE id = 5;

SELECT * FROM customers WHERE id = 5;

/* Update all customers with a NULL score
	by setting their score to 0
*/

SET SQL_SAFE_UPDATES = 0;

UPDATE customers SET
	score = 0
WHERE score IS NULL;

INSERT INTO customers VALUES (8,'Michael','Poland',NULL);

SELECT * FROM customers;

-- Delete all customers with an ID greater than 5 

DELETE FROM customers WHERE id > 5;
SELECT * FROM customers;

-- Delete all data from the persons table 

SELECT * FROM persons;
DELETE FROM persons;
TRUNCATE TABLE persons; -- faster option
