show databases;
use sqljoins;
show tables;

CREATE TABLE Department(
	dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employee(
	emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT
);

INSERT INTO Department
VALUES 
(101,'HR'),
(102,'IT'),
(103,'Finance'),
(104,'Marketing'),
(105,'Admin');

INSERT INTO Employee
VALUES
(1,'Sneha',50000,102),
(2,'Rahul',60000,101),
(3,'Anjali',45000,103),
(4,'Kiran',70000,102),
(5,'Priya',55000,NULL),
(6,'Arjun',65000,104),
(7,'Rohit',48000,106),
(8,'Megha',52000,101);

-- 1) Fetch employee and department details of only those employees 
--    who have a valid department 
SELECT e.*, d.dept_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id;

-- 2) Display employee name, department name and salary
SELECT e.emp_name, d.dept_name, e.salary
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id;

-- 3) Display all employees working in the IT department
SELECT e.emp_id, e.emp_name, d.dept_name
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 4) Display employees earning more than 55,000 
-- along with department names
