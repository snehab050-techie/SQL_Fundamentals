-- 1) Count employees dept wise
-- Referring to sqljoins db - employee table

-- as dept_id is in emp table
SELECT dept_id, COUNT(emp_id) emp_count
FROM EMPLOYEE
GROUP BY dept_id;

-- using join
SELECT d.dept_name, COUNT(e.emp_id) emp_count
FROM EMPLOYEE AS e
LEFT JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 2) Find duplicate salaries
SELECT salary
FROM EMPLOYEE AS e
GROUP BY e.salary
HAVING COUNT(*) > 1;

-- 3) Find second highest salary
SELECT MAX(e.salary)
FROM EMPLOYEE AS e
WHERE e.salary < (
	SELECT MAX(salary)
    FROM EMPLOYEE
);

-- 4) Find nth (1st, 2nd, 3rd, 4th, 5th, ... nth) highest salary
-- eg: find 3rd highest salary
SELECT DISTINCT salary
FROM EMPLOYEE
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- 5) Employees earning above their department average
SELECT e.emp_name,d.dept_name
FROM EMPLOYEE AS e
INNER JOIN DEPARTMENT AS d
ON e.dept_id = d.dept_id
WHERE e.salary >
(SELECT AVG(salary)
FROM EMPLOYEE
WHERE dept_id = e.dept_id);

-- 6) Duplicate records from table
SELECT emp_name, count(*) repeated
FROM EMPLOYEE AS e
GROUP BY e.emp_name
HAVING COUNT(*) > 1;

-- 7) Remove duplicate rows
CREATE TABLE NewEmp AS
SELECT DISTINCT *
FROM EMPLOYEE;

DROP TABLE Employee;
ALTER TABLE NewEmp RENAME TO Employee;

#8) Find second highest salaried employee using window funtion
# We can use the same query to find out the nth highest salary
SELECT emp_sal_rank.name, emp_sal_rank.salary
FROM
	(SELECT name, salary, 
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
	FROM employees) AS emp_sal_rank
WHERE emp_sal_rank.salary_rank = 3;

# 9) Find the duplicate employee names in the employees table and 
# display the name and the number of times each name occurs.
SELECT name, COUNT(name) emp_count
FROM employees
GROUP BY name
HAVING COUNT(name) > 1;

# 10) Write a SQL query to delete duplicate rows while keeping one 
# copy of each duplicate record.

DELETE FROM employees
WHERE employee_id IN(
SELECT employee_id
FROM
	(SELECT employee_id, name, salary,
		ROW_NUMBER() OVER
        (PARTITION BY name, salary
        ORDER BY employee_id) AS row_num
	FROM employees) AS duplicates
WHERE row_num > 1
);

#11) Find duplicate records in a table
SELECT employee_id
FROM
	(SELECT employee_id, name, salary,
		ROW_NUMBER() OVER
        (PARTITION BY name, salary
        ORDER BY employee_id) AS row_num
	FROM employees) AS duplicates
WHERE row_num > 1;

#12) Department Wise Maximum Salary
SELECT * FROM employees;

SELECT department, MAX(salary) max_salary
FROM employees
GROUP BY department;

#13) Count employees department wise
SELECT department, COUNT(employee_id) emp_count
FROM employees
GROUP BY department;

#14) Top 3 salary
SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

#15) Joins, Finding Null values

#16) Difference between WHERE and HAVING

#IN vs EXISTS

# Write a query to find the total salary spent on each department. Only include departments where the total expenditure is greater than ₹15,00,000, and sort the result in descending order of the total expense.

# Find the average salary of Developers in each department. Exclude departments where the average developer salary is less than ₹6,00,000. Sort the final output by the average salary.

# Write an SQL query to find all duplicate email addresses or employee names in the database.

# List the cities that have more than 5 employees living in them, but do not count any employees who were hired in the last 6 months (assume a fixed date or filter for this example). Sort the cities alphabetically.

# Write a query to find the number of employees working in each job role within each department. Sort the output by department ID, and then by the count of employees in descending order.

#17) Query to delete duplicate records from the table keeping only one record - using window function row_number()

CREATE TABLE cars(
	model_id INT PRIMARY KEY,
    model_name VARCHAR(50),
    color VARCHAR(50),
    brand VARCHAR(50)
);

SELECT * FROM cars;

TRUNCATE cars;

ALTER TABLE cars
DROP PRIMARY KEY;
 
INSERT INTO cars
VALUES(101,'slavia','navyblue','skoda'),
(102,'virtus','green','volkswagaon'),
(103,'slavia','balck','skoda'),
(104,'virtus','navyblue','volkswagaon'),
(105,'virtus','white','volkswagaon');

DELETE FROM cars
WHERE model_id IN
(SELECT model_id
FROM
(SELECT model_id,model_name,
	   ROW_NUMBER() OVER
       (PARTITION BY model_name,brand
       ORDER BY model_id) AS row_rank
FROM cars) AS duplicates
WHERE row_rank>1);

SET SQL_SAFE_UPDATES = 0;

#solved the same without using row_number function
DELETE
FROM cars
WHERE model_id NOT IN(
SELECT min_id
FROM
(SELECT MIN(model_id) min_id
FROM cars
GROUP BY model_name, brand) 
AS keepers);


#18) You have anemployee table - id, name, department, salary
# For every employee, display the highest and lowest salary in their department
SELECT employee_id, name, department,salary,
	   MAX(salary) OVER
       (PARTITION BY department) AS hi,
       MIN(salary) OVER
       (PARTITION BY department) AS low
FROM employees
ORDER BY salary DESC;

#Window functions
