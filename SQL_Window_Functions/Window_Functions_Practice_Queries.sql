
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

CREATE TABLE ORDERS(
	order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO orders 
(order_id, customer_id, order_date, amount) 
VALUES 
(101, 'C1', '2026-01-10', 500),
(102, 'C2', '2026-02-15', 800),
(103, 'C3', '2026-01-20', 300),
(104, 'C4', '2026-03-05', 600),
(105, 'C5', '2026-02-01', 450),
(106, 'C6', '2026-03-12', 900);

ALTER TABLE ORDERS
MODIFY COLUMN customer_id VARCHAR(10);

SELECT * FROM orders;

#2. Write a SQL query that returns only the latest order for each customer, showing:
#- order_id
#- customer_id
#- order_date
#- amount
#If a customer has multiple orders, only their most recent order should appear.

WITH c AS
(SELECT order_id, customer_id, order_date, amount,
	   ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY ORDER_DATE DESC) AS cust_ord
FROM orders)
SELECT order_id, customer_id, order_date, amount,cust_ord
FROM c
WHERE cust_ord = 1;

#Write a query to find the "Top N per Group" (e.g., Top 2 highest-paid employees per department).
