-- DDL

/* Create a new table called persons with 
columns: id, person_name, birth_date and phone */

CREATE TABLE persons (
	id				int primary key auto_increment not null,
    person_name 	varchar(50) not null,
    birth_date		date,
    phone			varchar(15) not null
)

SELECT * FROM persons;

-- Add a new column called email to the persons table

ALTER TABLE persons 
ADD email varchar(50) NOT NULL;

SELECT * FROM PERSONS;

-- Remove the column phone from the persons table 

ALTER TABLE persons 
DROP COLUMN phone;

SELECT * FROM PERSONS;

-- Delete the table persons from the database 

DROP TABLE persons;

