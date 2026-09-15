CREATE DATABASE practice_joins;

USE practice_joins;

CREATE TABLE employees(
	employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50)
);

INSERT INTO employees
VALUES
(101,
'Rahul',
'IT',
60000,
'Bangalore'),
(102,
'Priya',
'HR',
50000,
'Chennai'),
(103,
'Amit',
'IT',
75000,
'Bangalore'),
(104,
'Sneha',
'Finance',
65000,
'Hyderabad'),
(105,
'Kiran',
'HR',
55000,
'Chennai');

CREATE TABLE department(
	department_id INT PRIMARY KEY,
    department VARCHAR(50),
    manager VARCHAR(50)
);

INSERT INTO department
VALUES
(10,'IT','Arjun'),
(20,'HR','Meera'),
(30,'Finance','Vikram');

ALTER TABLE employees
DROP COLUMN department_id;

ALTER TABLE employees
ADD COLUMN department_id INT;

desc employees;

UPDATE employees
SET department_id = 20
WHERE employee_id = 105;

ALTER TABLE department
RENAME TO departments;

ALTER TABLE departments
RENAME COLUMN department TO department_name;

select * from employees;

select * from departments;

# SQL join practice-------------------------------------

#1. Write a query to display the employee name and department name 
# for every employee.
SELECT e.name, d.department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;