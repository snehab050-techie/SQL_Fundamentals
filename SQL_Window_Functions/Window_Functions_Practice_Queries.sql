
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

SELECT order_id, customer_id, order_date, amount,
	   ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY ORDER_DATE DESC) AS cust_ord
FROM orders;

#Write a query to find the "Top N per Group" (e.g., Top 2 highest-paid employees per department).

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

USE window_functions;

INSERT INTO products (product_id, product_name, category, price)
VALUES
    (1, 'Mouse', 'Electronics', 500),
    (2, 'Keyboard', 'Electronics', 1200),
    (3, 'Monitor', 'Electronics', 8000),
    (4, 'Shirt', 'Clothing', 700),
    (5, 'Jeans', 'Clothing', 1500),
    (6, 'Jacket', 'Clothing', 1500);
    
#1. Write a query displaying product_name, category, price, and row_num.
#- Number products separately within each category.
#- Sort by price from lowest to highest.
#- Keep all six product rows.

SELECT * FROM products;

SELECT product_name, category, price,
	   ROW_NUMBER() OVER(PARTITION BY category ORDER BY price) AS prod_row_num
FROM products;

#2. Write a query that displays product_name, category, price, and price_rank.

#Requirements:
#- Rank products within each category.
#- Highest price gets rank 1.
#- Products with the same price must share the same rank.
#- After a tie, the next rank must skip a number.

SELECT product_name, category, price,
	   RANK() OVER(PARTITION BY category ORDER BY price DESC) AS price_rank
FROM products;

#3. Write a query displaying product_name, category, price, and price_rank, with these requirements:
#- Rank products separately within each category.
#- Highest price gets rank 1.
#- Products with the same price share a rank.
#- The next rank after a tie must not skip a number.

SELECT product_name, category, price,
	   DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) AS price_rank
FROM products;

#4. Find the most expensive product in each category

#Task: Write a SQL query that returns only the most expensive product or products 
#in each category.

#Display:
#- product_name
#- category
#- price

#Important: if multiple products tie for the highest price in a category, 
#return all tied products.

WITH hpc AS
(SELECT product_name, category, price,
	   DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) AS price_rank
FROM products)
SELECT product_name, category, price
FROM hpc
WHERE hpc.price_rank = 1;

#5. Find the second-highest distinct price

#Task: Write a SQL query to find the second-highest distinct price in each category, 
#returning every product that has that price.

#Display product_name, category, and price.

#For example, in Clothing, the distinct prices are 1500 and 700. 
#The second-highest distinct price is 700.

#Important: Rank distinct price levels, not individual products. 
#If multiple products share the second-highest price, return all of them.

WITH prod_rank
AS
(SELECT product_name, category, price,
	    DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) as price_rank 
FROM products)
SELECT product_name, category, price
FROM prod_rank
WHERE price_rank = 2;

#6. Find the top 2 distinct price levels in each category and 
#return every product belonging to those price levels.

#For example, in Clothing, return Jeans, Jacket, and Shirt.
WITH prod_rank
AS
(SELECT product_name, category, price,
		DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) AS price_rank
FROM products)
SELECT product_name, category, price
FROM prod_rank
WHERE price_rank <=2;

#7. Find the most expensive product in each category, 
#but return exactly one product per category, 
#even when multiple products have the same price.
WITH prod_rank
AS
(SELECT product_name, category, price,
       ROW_NUMBER() OVER(PARTITION BY category ORDER BY price DESC, product_id) AS price_rank
FROM products)
SELECT product_name, category, price
FROM prod_rank
WHERE price_rank = 1;

#start from -- > 

#8. Find the difference between a row and a group
#Using the same products table, find the second most expensive product in each category, 
#returning exactly one product per category. If two products tie on price, choose the one with the smaller product_id.

WITH prod_rank
AS
(
SELECT product_id, product_name, category, price,
	   ROW_NUMBER() OVER(PARTITION BY category ORDER BY price DESC, product_id ASC) AS prod_num
FROM products)
SELECT product_id, product_name, category, price
FROM prod_rank
WHERE prod_num = 2;

-- LAG() - helps compare a row with the previous row without joining a table to itself.

#9. Using the existing products table, write a query that displays:
#- product_name
#- category
#- price
#- previous_price — the price of the previous product in the same category

# LAG(price) can access the previous row's price.

SELECT product_name, category, price,
	   LAG(price) OVER(PARTITION BY category ORDER BY price ASC) AS previous_price
FROM products;

-- 10. Using the same products table, display:
-- - product_name
-- - category
-- - price
-- - previous_price
-- - price_difference — current price minus previous price - for each category
-- Your task: Write the complete query.
SELECT product_name, category, price,
       LAG(price) OVER(PARTITION BY category ORDER BY price ASC, product_id ASC) AS previous_price,
       (price - LAG(price) OVER(PARTITION BY category ORDER BY price ASC, product_id ASC)) AS price_difference
FROM products;

-- LEAD() - helps compare a row with the next row without joining a table to itself.

-- 11. Using the same products table, write a query to display:
-- - product_name
-- - category
-- - price
-- - next_price — the next product's price within the same category, ordered from cheapest to most expensive.
SELECT product_name, category, price,
       LEAD(price) OVER(PARTITION BY category ORDER BY price ASC, product_id ASC) AS next_price 
FROM products;

-- 12. calculate the running total of each product within category
SELECT *,
		SUM(price) OVER(partition by category ORDER BY product_id) AS running_total
FROM products;

-- 13. FIRST_VALUE()

-- Using the existing products table, write a query displaying:
-- - product_name
-- - category
-- - price
-- - cheapest_price — the cheapest price in that product's category, repeated on every row.

SELECT *,
	   FIRST_VALUE(price) OVER(PARTITION BY category ORDER BY price ASC, product_id ASC) AS cheapest_price
FROM products;

-- 14. Using the same products table, display all the columns plus most_expensive_price, 
-- showing the most expensive price in each category on every row.

SELECT *,
		LAST_VALUE(price) OVER(
        PARTITION BY category 
        ORDER BY price ASC, product_id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS most_expensive_price 
FROM products;