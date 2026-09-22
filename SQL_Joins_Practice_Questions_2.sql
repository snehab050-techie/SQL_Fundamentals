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

#2. Write a query to display the employee name, salary, and 
# department name for employees who belong to the IT department.
SELECT e.name, e.salary, d.department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = 'IT';

#3. Write a query to display the employee name and their manager's 
# name for every employee.
SELECT e.name, d.manager
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id;

#4. Write a query to display the names of employees who work 
# in the same department as Rahul.

# no need of joins here
SELECT e.name
FROM employees AS e
WHERE (e.department_id) =
(SELECT d.department_id
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.name = 'Rahul');

# we can also use subquery - same result
SELECT name
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE name = 'Rahul');

#solving same query using self join - as all required details are in same employees table
select * from employees;
SELECT e2.name
FROM employees AS e1
JOIN employees AS e2
ON e1.department_id = e2.department_id
WHERE e1.name = 'Rahul';

#Find employees who work in the same department as Rahul, 
# excluding Rahul.
SELECT e2.name
FROM employees AS e1
JOIN employees AS e2
ON e1.department_id = e2.department_id
WHERE e1.name = 'Rahul'
AND e2.name <> 'Rahul';

#LEFT join
#5. Write a query to display every employee's name and their 
#department name. Employees should be displayed even if they don't 
#belong to any department.
SELECT e.name, d.department_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id;

#6. Find employees who do not have a department assigned to them
# OR Write a SQL query to find all employees who do not have a matching department.
SELECT e.name
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name IS NULL;

use practice_joins;
INSERT INTO departments
VALUES(50,'Marketing','Rohan');

#7. Write a query to find departments that currently have NO employees.
SELECT d.department_name
FROM departments AS d
LEFT JOIN employees AS e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

#8. Display ALL employees, but show the department name only when the department is IT.
SELECT e.name,d.department_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id
AND d.department_name = 'IT';

#9. Display every employee's name, but show a department name only if 
# the employee belongs to HR.
SELECT e.name, d.department_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id
AND d.department_name = 'HR';

#Right Join - Returns all records from right table and the matching records 
# from the left table

# Right Join can be replaced with left join and vice versa
# If RIGHT JOIN confuses you, flip the tables and use LEFT JOIN. Same idea, just reversed.

#10. Write a query to display every department and the employees working in that 
#department, including departments that currently have no employees.
SELECT d.department_name, e.name
FROM employees AS e
RIGHT JOIN departments AS d
ON e.department_id = d.department_id;

#11. Find all departments that have at least one employee earning more than ₹60,000.
SELECT DISTINCT d.department_name
FROM employees AS e
RIGHT JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.name IS NOT NULL
AND e.salary > 60000;

#12. Find the department name and the number of employees in each department. 
# Include departments that currently have no employees.
SELECT d.department_name, COUNT(employee_id) emp_count
FROM employees AS e
RIGHT JOIN departments As d
ON e.department_id = d.department_id
GROUP BY d.department_name;

#13. Find departments that have more than 1 employee.
SELECT d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 1;

#INNER JOIN returns only the records that have a match in both tables.

#LEFT JOIN returns all records from the left table and the matching records from the right table. If there is no match, the right-side columns will contain NULL.

#RIGHT JOIN returns all records from the right table and the matching records from the left table. If there is no match, the left-side columns will contain NULL.

#FULL OUTER JOIN returns all records from both tables. Matching records are combined, while unmatched records from either side have NULL values for the columns of the other side.

#14. Write a query that displays ALL employees and ALL departments, including 
# unmatched employees and unmatched departments.
SELECT e.name, d.department_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id
UNION
SELECT e.name, d.department_name
FROM employees AS e
RIGHT JOIN departments AS d
ON e.department_id = d.department_id;

#15. Write a query to display: Each department name and the average salary of 
# employees in that department.
SELECT d.department_name, ROUND(AVG(e.salary)) avg_salary
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name;

#16. Find the departments whose average employee salary is greater than 60,000.
SELECT d.department_name, AVG(e.salary) avg_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 60000;

#17. Display each department name and the number of employees working in that 
# department. Include departments that currently have ZERO employees.
SELECT d.department_name, COUNT(employee_id)
FROM employees AS e
RIGHT JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name;

#18. Departments that have at least 2 employees AND whose average salary 
# is greater than 55,000.
SELECT d.department_name, COUNT(e.employee_id) emp_count, AVG(e.salary) avg_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) >= 2
AND AVG(e.salary) > 55000;

#19. Find the highest-paid employee in each department and display the 
# department name, employee name, and salary.
SELECT d.department_name, e.name, e.salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE (d.department_name, e.salary) IN
(SELECT d.department_name, MAX(e.salary) max_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name);

#20. Find employees whose salary is greater than the average 
# salary of their own department.
SELECT e1.name employee, d2.department_name department, e1.salary salary
FROM employees AS e1
JOIN departments AS d2
ON e1.department_id = d2.department_id
WHERE e1.salary > 
(SELECT AVG(e2.salary) avg_sal
FROM employees AS e2
WHERE e2.department_id = e1.department_id);

#21. Find the department(s) where the highest-paid employee 
# earns more than 70,000.
SELECT d.department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING MAX(salary) > 70000;

#22. Find the department name and the name of the highest-paid 
# employee in each department.
SELECT d.department_name department, e1.name employee, e1.salary
FROM employees AS e1
JOIN departments AS d
ON e1.department_id =d.department_id
WHERE (e1.department_id, e1.salary) IN
	(SELECT e.department_id department,MAX(salary) max_salary
	FROM employees AS e
	GROUP BY e.department_id);
    
#23. Find the department(s) whose average salary is higher than the overall 
# average salary of all employees.
SELECT d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY e.department_id
HAVING AVG(e.salary) > 
(SELECT AVG(salary)
FROM employees);

#24. Find the employee(s) who earn more than the average salary of their department 
# AND display their department name, employee name, salary, and department average 
#salary
SELECT e1.name, e1.salary, d.department_name, ((SELECT AVG(e2.salary) avg_sal
FROM employees AS e2
WHERE e1.department_id = e2.department_id)) AS department_avg
FROM employees AS e1
JOIN departments AS d
ON e1.department_id = d.department_id
WHERE e1.salary >
(SELECT AVG(e2.salary) avg_sal
FROM employees AS e2
WHERE e1.department_id = e2.department_id);

#25. Find employees whose salary is greater than their department's average salary, and display: emp name, dept name, salary, dept avg sal

#26. Find the departments that have at least 2 employees. Display: Department nam, Employee count

#27. Find the employee(s) who earn the highest salary in the entire company. Display: Employee name Department name Salary

#------to verify solutions from here
#28. Find the departments where: The department has at least 2 employee 
#AND the highest salary in that department is greater than 70,000 
#AND display the department name, employee count, and highest salary
SELECT d.department_name, COUNT(e.employee_id) employee_count, MAX(e.salary) max_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY e.department_id
HAVING COUNT(e.employee_id) >=2
AND MAX(e.salary) > 70000;

#29. Find the employees who work in the IT or HR department and display their name, department name, and salary.
SELECT e.name, d.department_name, e.salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name IN ('IT','HR');

#30. Find the total salary paid by each department and display 
# the department name and total salary.
SELECT d.department_name, SUM(e.salary) total_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name;

#31. Find the employees who work in the IT or HR department and 
# display their name, department name, and salary.
SELECT e.name, d.department_name, e.salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name IN ('IT','HR');

#32. Find the total salary paid by each department and display the 
# department name and total salary.
SELECT d.department_name, SUM(e.salary) total_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name;

#33. Find the departments where the total salary of all employees 
# is greater than 120,000 and display the department name and total 
# salary.
SELECT d.department_name, SUM(e.salary) total_salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY e.department_id, d.department_name
HAVING SUM(e.salary) > 120000;

#34. Find the employees who earn more than the highest-paid 
# employee in the HR department and display their name, department 
# name, and salary.

# would be cleaner with INNER JOIN as it eliminates employees not assigned to any department
SELECT e1.name, e1.salary, d1.department_name
FROM employees AS e1
LEFT JOIN departments AS d1
ON e1.department_id = d1.department_id
WHERE e1.salary > 
(SELECT MAX(e.salary) max_salary_hr
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = 'HR');

#------------------------ top 4 questions

SELECT * FROM employees;

SELECT * FROM departments;

# 35. Write a query to display the employee name, department name, and salary for all employees who belong to a department.
SELECT e.name, d.department_name, e.salary
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

# 36. Write a query to display all employees along with their department names, including employees who are not assigned to any department.
SELECT e.name, d.department_name
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id;

# 37. Write a query to find all departments that currently have no employees assigned to them.
SELECT d.department_name
FROM employees AS e
RIGHT JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

# 38. Write a query to display each employee’s name along with their manager’s name, assuming the employees table has a manager_id column that refers to another employee’s employee_id.
SELECT e.name employee, m.name manager
FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id;

#---added manager_id column to employee table to work on Q38
SELECT * FROM employees;

ALTER TABLE employees
ADD COLUMN manager_id INT;

UPDATE employees
SET manager_id = 104
WHERE employee_id = 101;

UPDATE employees
SET manager_id = 104
WHERE employee_id = 102;

UPDATE employees
SET manager_id = 104
WHERE employee_id = 106;

UPDATE employees
SET manager_id = 104
WHERE employee_id = 105;

UPDATE employees
SET manager_id = 106
WHERE employee_id = 103;


