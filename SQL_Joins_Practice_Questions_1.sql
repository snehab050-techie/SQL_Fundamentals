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
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE e.salary > 55000;

-- 5) Display employee count in every department
SELECT r.dept_id, d.dept_name,r.emp_count
FROM (SELECT dept_id,COUNT(emp_id) AS emp_count
FROM EMPLOYEE
GROUP BY dept_id
HAVING dept_id IS NOT NULL
ORDER BY dept_id) AS r
INNER JOIN Department AS d
ON r.dept_id = d.dept_id;

-- 6) Display all employees even 
-- if they don't belong to any department
SELECT e.emp_name,d.dept_name
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id;

-- 7) Find employees who are not assigned to any department
SELECT e.emp_name
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE d.dept_name IS NULL;

-- 8) Display all departments even if no employee works there
SELECT distinct d.dept_name
FROM EMPLOYEE AS e
RIGHT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id;

-- 9) Find departments having no employees
SELECT d.dept_name
FROM EMPLOYEE AS e
RIGHT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- 10) Display Department Name, Employee Name, 
-- Include departments having no employees.
SELECT e.emp_name,d.dept_name
FROM EMPLOYEE AS e
RIGHT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id;

-- 11) Display every employee and every department
-- FULL JOIN keyword is not supported in MySQL (while it works in OracleSQL and PostgreSQL)
-- We take Union of  left and right joins = full outer join
SELECT *
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
UNION
SELECT *
FROM EMPLOYEE AS e
RIGHT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id;

-- 12) Display employee names whose department starts with 'H'
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE d.dept_name LIKE 'H%';

-- 13) Display department names where average salary is 
--     greater than 50,000
SELECT d.dept_name,CEIL(AVG(e.salary)) AS avg_sal
FROM EMPLOYEE AS e
RIGHT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 50000;

-- 14) Display highest-paid employee from each department




