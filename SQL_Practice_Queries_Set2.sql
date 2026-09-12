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

#25. Find nth (1st, 2nd, 3rd, 4th, 5th, ... nth) highest salary
-- eg: find 4th highest salary
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 3;

#26. Find the department with the highest average salary.
SELECT department, AVG(salary) avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;

#27. Find the department with the lowest total salary.
SELECT department, SUM(salary) total_salary
FROM employees
GROUP BY department
ORDER BY total_salary
LIMIT 1;

#28. Find the number of employees in each city, 
# and display the cities in alphabetical order.
SELECT city, COUNT(*) emp_count
FROM employees
GROUP BY city
ORDER BY city;

#29. Find the city with the highest number of employees.
SELECT city, COUNT(*) emp_count
FROM employees
GROUP BY city
ORDER BY emp_count DESC
LIMIT 1;

#30. Find all departments where the minimum salary is greater than ₹50,000.
SELECT department, MIN(salary) min_salary
FROM employees
GROUP BY department
HAVING MIN(salary) > 50000;

#31. Find the department with the highest total salary, and display the 
# department name along with its total salary.
SELECT department, SUM(salary) total_salary
FROM employees
GROUP BY department
ORDER BY SUM(salary) DESC
LIMIT 1;

#32. Find the average salary of employees in each department, but display only 
# departments whose average salary is between ₹50,000 and ₹70,000, inclusive.
SELECT department, AVG(salary) avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) >= 50000 AND AVG(salary) <= 70000;

#33. Display the city and total salary for each city, but only include cities where 
# the total salary is greater than ₹1,00,000. Sort the result by total salary in descending order.
SELECT city, SUM(salary) total_salary
FROM employees
GROUP BY city
HAVING SUM(salary) > 100000
ORDER BY total_salary DESC;

#34. Find the department with the highest average salary among departments 
# having at least 3 employees.
SELECT department, AVG(salary) avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) >=3
ORDER BY avg_salary DESC
LIMIT 1;

#35. Find the second-highest salary in the employees table, considering duplicate 
# salary values as a single salary level.
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

#36. Find the third-highest distinct salary in the employees table.
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

#37. Find the total number of employees and total salary for each department, 
# but display only departments where the total salary exceeds ₹2,00,000.
SELECT department, COUNT(employee_id) total_emp_count, SUM(salary) total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 200000;

#37. Display the department, minimum salary, maximum salary, and average salary 
# for each department. Sort the departments by their maximum salary from highest 
# to lowest.
SELECT department, MIN(salary) min_salary, MAX(salary) max_salary, AVG(salary) avg_salary
FROM employees
GROUP BY department
ORDER BY max_salary DESC;

#38. Find the cities that have more than one employee, 
# and display the city along with the number of employees.
SELECT city, COUNT(*) emp_count
FROM employees
GROUP BY city
HAVING COUNT(*) > 1;

#39. Find the department with the highest average salary.
SELECT department, AVG(salary) avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;

#40. Find the departments where the highest salary is greater than 70,000.
SELECT department, MAX(salary) highest_salary
FROM employees
GROUP BY department
HAVING MAX(salary) > 70000;

#41. Find the cities where the total salary of all employees is greater than 150,000.
SELECT city, SUM(salary) total_salary
FROM employees
GROUP BY city
HAVING SUM(salary) > 150000;

#42. Find the department with the lowest average salary.
SELECT department, AVG(salary) avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary
LIMIT 1;

#43. Find the departments that have at least 2 employees and a total salary greater than 150,000.
SELECT department, COUNT(*) emp_count, SUM(salary) total_salary
FROM employees
GROUP BY department
HAVING COUNT(*) >= 2 AND SUM(salary) > 150000;

#44. Find the city with the lowest total salary.
SELECT city, SUM(salary) total_salary
FROM employees
GROUP BY city
ORDER BY total_salary
LIMIT 1;

#45. Find the departments where the average salary is greater than 50,000 and the number of employees is at least 3.
SELECT department, AVG(salary) avg_salary, COUNT(employee_id) emp_count
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000 AND COUNT(employee_id) >= 3;

#46. Find the employee(s) who have the highest salary in the company.
SELECT *
FROM employees
WHERE salary = (SELECT salary
FROM employees
ORDER BY salary DESC
LIMIT 1);

#47. Find the employee(s) who have the second-highest salary in the company.
SELECT *
FROM employees
WHERE salary = (SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1);

#48. Find the third-highest distinct salary in the company.
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

#49. Find the department with the highest number of employees.
SELECT department, COUNT(*) emp_count
FROM employees
GROUP BY department
ORDER BY emp_count DESC
LIMIT 1;

#50. Find the department(s) whose minimum salary is greater than 55,000.
SELECT department, MIN(salary) min_salary
FROM employees
GROUP BY department
HAVING MIN(salary) > 55000;

#51. Find the city with the highest average salary.
SELECT city, AVG(salary) avg_salary
FROM employees
GROUP BY city
ORDER BY avg_salary DESC
LIMIT 1;

#52. Find the departments where the highest salary is at least 70,000 and 
#the department has more than 2 employees.
SELECT department, MAX(salary) highest_salary, COUNT(employee_id) emp_count
FROM employees
GROUP BY department
HAVING MAX(salary) >= 70000 AND COUNT(employee_id) > 2;

#53. Find the employees whose salary is higher than the average salary of 
# the entire company.
SELECT *
FROM employees
WHERE salary > 
(SELECT AVG(salary) avg_comp_salary
FROM employees);

#54. Find the employee(s) who earn the highest salary within their department.
# group-wise maximum" problem, a very common SQL interview pattern.
SELECT e.*
FROM employees AS e
WHERE (e.department, e.salary) IN
(SELECT department, MAX(salary) max_salary
FROM employees
GROUP BY department);

#55. Find the employees whose salary is higher than the average salary of 
# their own department.
SELECT e.*
FROM employees AS e
WHERE e.salary > 
(SELECT AVG(salary)
FROM employees
WHERE department = e.department);

#56. Find the second-highest salary in each department.
SELECT e.department, e.salary
FROM employees AS e
WHERE e.salary =
(SELECT salary
FROM employees
WHERE department = e.department
ORDER BY salary DESC
LIMIT 1 OFFSET 1);

#57. Find the employees who have the lowest salary in their department.
SELECT e.*
FROM employees AS e
WHERE e.salary =
(SELECT salary
FROM employees
WHERE department = e.department
ORDER BY salary
LIMIT 1);

#58. Find the employees who have more experience than the average 
# experience of their department.
SELECT e.*
FROM employees AS e
WHERE e.experience
>
(SELECT AVG(experience) avg_exp
FROM employees
WHERE department = e.department
GROUP BY department);

#59. Find the department(s) where the difference between the highest 
# salary and the lowest salary is greater than 20,000.
SELECT e.*
FROM
(SELECT department, MAX(salary) max_salary, MIN(salary) min_salary
FROM employees
GROUP BY department) AS e
WHERE (e.max_salary - e.min_salary) > 20000;

SELECT department, MAX(salary) max_salary, MIN(salary) min_salary
FROM employees
GROUP BY department
HAVING MAX(salary) - MIN(salary) > 20000;

#60. Find the department with the largest difference between its highest 
# and lowest salary.
SELECT e.department, (e.max_salary - e.min_salary) highest_difference
FROM(
SELECT department, MAX(salary) max_salary, MIN(salary) min_salary
FROM employees
GROUP BY department) AS e
ORDER BY highest_difference DESC
LIMIT 1;

#61. Find the employee(s) with the highest salary in each city.
SELECT e.*
FROM employees AS e
WHERE (e.city, e.salary) IN
(SELECT city, MAX(salary) max_salary
FROM employees
GROUP BY city);