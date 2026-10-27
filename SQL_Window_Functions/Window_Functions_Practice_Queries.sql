
CREATE DATABASE WINDOW_FUNCTIONS;

USE WINDOW_FUNCTIONS;

SHOW TABLES;

-- CUSTOMER TABLE

CREATE TABLE customer(
	customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

DESC customer;

INSERT INTO CUSTOMER
VALUES
(101,'Asha','Bengaluru'),
(102,'Ravi','Mysuru'),
(103,'Priya','Bengaluru'),
(104,'Kiran','Chennai'),
(105,'Neha','Bengaluru'),
(106,'Aman','Mysuru');

-- SALES TABLE

CREATE TABLE sales(
	sale_id INT,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    sale_amount INT
);

INSERT INTO sales
VALUES
(1,'Anu','South', 5000),
(2,'Ravi','South',8000),
(3,'Maya','South',8000),
(4,'John','North',4000),
(5,'Priya','North',7000),
(6,'Kiran','North',6000);

SELECT * from SALES;

#1. Write an SQL query to rank salespeople within each region based on 
# their sale amount, from highest to lowest.

# Requirements

#Show salesperson, region, sale_amount, and the rank.
#The highest sale should receive rank 1.
#Salespeople with the same sale amount should receive the same rank.
#The next rank should skip a number after a tie.

SELECT salesperson,region,sale_amount,
	   RANK() 
       OVER(PARTITION BY region ORDER BY sale_amount DESC) as sale_rank 
FROM sales;

