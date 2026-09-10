create database practice_sql;

show databases;

use practice_sql;

show tables;

create table employees(
	employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    salary INT,
    city VARCHAR(100),
    experience INT,
    joining_year INT
);

INSERT INTO employees
(employee_id,name,department,salary,city,experience,joining_year)
VALUES
(101, 'Rahul', 'IT', 60000, 'Bangalore', 3, 2023),
(102, 'Priya', 'HR', 45000, 'Mumbai', 2, 2024),
(103, 'Amit', 'IT', 75000, 'Bangalore', 5, 2021),
(104, 'Sneha', 'Finance', 55000, 'Pune', 4, 2022),
(105, 'Karan', 'IT', 65000, 'Chennai', 3, 2023),
(106, 'Neha', 'HR', 50000, 'Bangalore', 4, 2022),
(107, 'Arjun', 'Finance', 70000, 'Mumbai', 6, 2020),
(108, 'Divya', 'IT', 80000, 'Pune', 7, 2019),
(109, 'Rohan', 'Finance', 48000, 'Chennai', 2, 2024),
(110, 'Anjali', 'HR', 60000, 'Pune', 5, 2021);

#1. Write a SQL query to retrieve all columns and all records from the employees table.
select * from employees;

#2. Write a query to display only the name, department, and salary of all employees.
select name, department, salary
from employees;

#3. Update salary for employee
update employees
set salary = 65000
where employee_id = 101;

#4. insert new employee
INSERT INTO employees(employee_id,name,department,salary,city,experience,joining_year)
VALUES(111,'Varun','IT',70000,'Hyderabad',4,2022);

#5. delete an employee
DELETE FROM employees
WHERE employee_id = 109;

#6. Write a query to display all employees sorted by salary from highest to lowest.
SELECT *
FROM employees
ORDER BY salary DESC;

#7. Display all employees sorted by department alphabetically (A → Z).
# If multiple employees belong to the same department, sort those employees by salary from highest to lowest.
SELECT *
FROM employees
ORDER BY department, salary DESC;

#8. Write a query to find the total number of employees in the employees table.
SELECT count(*) Emp_Count
FROM employees;

#9. Write a query to find the total salary paid to all employees.
SELECT SUM(salary) Total_salary
FROM employees;

#10. Write a query to find the average salary of all employees.
SELECT AVG(salary) Avg_salary
FROM employees;

#11.Write one SQL query that returns: The lowest salary, The highest salary
SELECT MIN(salary) Min_salary, MAX(salary) Max_salary
FROM employees;

#12. Find the average salary of employees working in the IT department.
SELECT AVG(salary) avg_salary
FROM employees
WHERE department = 'IT';

#13. Find the number of employees working in the HR department.
SELECT COUNT(*) emp_count
FROM employees
WHERE department = 'HR';

#14. Write a query to find the number of employees in each department.
SELECT department, COUNT(*) emp_count
FROM employees
GROUP BY department;

#15.Find the total salary paid for each department.
SELECT department, SUM(salary)
FROM employees
GROUP BY department;

#16. Find the average salary for each department.
SELECT department, AVG(salary) avg_sal
FROM employees
GROUP BY department;

#17. Find the highest & lowest salary in each department.
SELECT department, MAX(salary) max_salary, MIN(salary) min_salary
FROM employees
GROUP BY department;

#18. Find the departments where the average salary is greater than ₹60,000
SELECT department, AVG(salary) avg_sal
FROM employees
GROUP BY department
HAVING avg_sal > 60000;

#19. Find the departments where the total salary paid to employees in that 
# department is greater than ₹1,50,000.
SELECT department, SUM(salary) total_salary
FROM employees
GROUP BY department
HAVING total_salary > 150000;

#20. Display the department and number of employees for departments that 
# have at least 3 employees.
SELECT department, count(*) emp_count
FROM employees
GROUP BY department
HAVING count(*) >=3;

#21. Find the cities where the average employee salary is greater than ₹60,000.
SELECT city, AVG(salary) avg_salary
FROM employees
GROUP BY city
HAVING AVG(salary) > 60000;

#22. Display the department, number of employees, and total salary for each department, 
# sorted by total salary from highest to lowest.
SELECT department, COUNT(*) emp_count, SUM(salary) total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;

#23. Display the department, average salary, and employee count for departments 
# having more than 2 employees, and sort the results by average salary from 
# highest to lowest.
SELECT department, AVG(salary) avg_salary, COUNT(*) emp_count
FROM employees
GROUP BY department
HAVING count(*) > 2
ORDER BY avg_salary DESC;

#24. Find the second-highest salary among all employees.
SELECT MAX(salary) sec_highest
FROM employees
WHERE salary < (SELECT MAX(salary) max_salary
FROM employees);

