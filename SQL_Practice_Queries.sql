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
WHERE employee_id IN (
    SELECT employee_id
    FROM (
        SELECT employee_id,
               ROW_NUMBER() OVER (
                   PARTITION BY name, salary
                   ORDER BY employee_id
               ) AS row_num
        FROM employees
    ) AS duplicates
    WHERE row_num > 1
);



