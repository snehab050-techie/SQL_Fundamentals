-- SQL stored procedure

USE PRACTICE_SQL;
SHOW TABLES;
SELECT * FROM EMPLOYEES;

-- Create a stored procedure to fetch all employees
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
	SELECT * FROM employees;
END //

DELIMITER ;

-- executing procedure
CALL GetAllEmployees();

-- Create a procedure to fetch employee by dept
DELIMITER //
CREATE PROCEDURE GetEmpByDept(IN dept_name VARCHAR(50))
BEGIN
	SELECT *
    FROM employees
    WHERE department = dept_name;
END //
DELIMITER ;

CALL GetEmpByDept('IT');

DROP PROCEDURE GetEmpByDept;

-- Try writing a stored procedure named GetEmployeesBySalary that:
-- Accepts an input parameter called min_salary.
-- Retrieves employees whose salary is greater than or equal to that amount.
-- Returns employee ID, name, department, and salary.

DELIMITER //

CREATE PROCEDURE GetEmployeesBySalary(IN min_salary INT)
BEGIN
	SELECT employee_id, name, department, salary
    FROM employees
    WHERE salary >= min_salary;
END //

DELIMITER ;

-- calling the procedure
CALL GetEmployeesBySalary(40000);

-- OUT parameter : It lets a stored procedure return a value to the caller

-- Create a sp to return count of employees

DELIMITER //

CREATE PROCEDURE GetEmpCount(OUT total_count INT)
BEGIN
	SELECT COUNT(*)
	INTO total_count
    FROM employees;
END //

DELIMITER ;

CALL GetEmpCount(@total);

SELECT @total;