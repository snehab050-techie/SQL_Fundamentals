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