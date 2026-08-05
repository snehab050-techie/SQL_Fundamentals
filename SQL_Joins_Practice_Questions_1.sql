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
SELECT d.dept_id,d.dept_name,e.emp_name,e.salary
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id 
WHERE e.salary = 
(SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE dept_id = e.dept_id);

-- 15) Display employees whose salary is greater than 
-- the average salary of their department

-- if dept_id is enough then there is no need of JOIN 
-- if dept_name aslo be fetched then JOIN is needed
SELECT e.*,d.dept_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE e.salary > 
(SELECT AVG(salary)
FROM EMPLOYEE
WHERE dept_id = e.dept_id);

-- 16) Display all employees and sort them by department name
--    Employees without departments should appear at the end
SELECT *
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
ORDER BY d.dept_name DESC;

-- 17) Display all departments and total salary paid in each department
SELECT d.dept_name,SUM(e.salary) AS total_sal
FROM EMPLOYEE AS e
RIGHT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id 
GROUP BY d.dept_name;

-- 18) Display employees who belong to departments having more than one employee.
SELECT e.*
FROM EMPLOYEE AS e
WHERE e.dept_id IN (SELECT e.dept_id
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
GROUP BY e.dept_id
HAVING COUNT(e.emp_id) > 1);

-- 19) Display employee names and department names where salary is between 45,000 and 60,000
SELECT e.emp_name, d.dept_name, e.salary
FROM EMPLOYEE AS e
JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id 
WHERE e.salary BETWEEN 45000 AND 60000;

-- 20) Display departments having exactly one employee
SELECT e.dept_id, d.dept_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
GROUP BY e.dept_id
HAVING COUNT(e.emp_id) = 1;

-- more join queries - adding project table

CREATE TABLE Project
(
	project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO Project
VALUES 
(201,'Income Tax Portal',1),
(202,'GST Portal',2),
(203,'Passport',4),
(204,'Banking App',6),
(205,'Healthcare',8),
(206,'Insurance',10),
(207, 'TDS', NULL),
(208, 'Indigo', NULL);

-- 1) Display employee name and project name
SELECT e.emp_name, p.project_name
FROM EMPLOYEE AS e
INNER JOIN PROJECT AS p
ON e.emp_id = p.emp_id;

-- 2) Display employees who are not assigned to any project
SELECT e.emp_id,e.emp_name
FROM EMPLOYEE AS e
LEFT JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL;

-- 3) Display projects without employees
SELECT p.project_name
FROM EMPLOYEE AS e
RIGHT JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL;

-- 4) Display employee, department, and project name together
SELECT e.emp_name, d.dept_name, p.project_name
FROM EMPLOYEE AS e
JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
JOIN PROJECT AS p
ON e.emp_id = p.emp_id;

-- 5) Display department-wise project count
SELECT d.dept_name,COUNT(p.project_id) AS project_count
FROM EMPLOYEE AS e
JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
JOIN PROJECT AS p
ON e.emp_id = p.emp_id
GROUP BY e.dept_id;

-- 6) Display the highest-paid employee working on a project

SELECT e.emp_name,p.project_name,e.salary
FROM EMPLOYEE AS e
LEFT JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE e.salary = (SELECT MAX(e.salary) AS max_sal
FROM EMPLOYEE AS e);

-- 7) Display project names where employees earn more than Rs 50,000
SELECT p.project_name
FROM EMPLOYEE AS e
RIGHT JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE e.salary > 50000;

-- 8) Display employees working in IT and assigned to a project
SELECT e.emp_name, d.dept_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
INNER JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE d.dept_name = 'IT'
AND p.project_id IS NOT NULL;

-- 9) Display employees who work in HR but have no project
SELECT e.emp_name, d.dept_name, p.project_id
FROM EMPLOYEE AS e
JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
LEFT JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE d.dept_name = 'HR'
AND p.project_id IS NULL;

-- 10) Display projects assigned to employees earning the 
--     maximum salary in their department
SELECT e.emp_name,e.salary,d.dept_name,p.project_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
INNER JOIN PROJECT AS p
ON e.emp_id = p.emp_id
WHERE e.salary = (
	SELECT MAX(salary)
    FROM EMPLOYEE 
    WHERE dept_id = e.dept_id
);