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

-- INOUT prameter

-- 1) Here the INOUT changes parameter -- without modifying the actual employee table values
DELIMITER //

CREATE PROCEDURE InsreaseEmpSal(INOUT emp_sal DECIMAL(10,2))
BEGIN
	SET emp_sal = emp_sal + 500;
END //

DELIMITER ;

SELECT @emp_sal;

-- 2) Here actual employee salary is increased and the updated salary is returned
DELIMITER //

CREATE PROCEDURE IncreaseEmpSalary(IN bonus DECIMAL(10,2), IN emp_id INT, OUT new_sal DECIMAL(10,2))
BEGIN
	UPDATE employees
    SET salary = salary + bonus
    WHERE employee_id = emp_id;
    
    SELECT salary
    INTO new_sal
    FROM employees
	WHERE employee_id = emp_id;
END //
DELIMITER ;

CALL IncreaseEmpSalary(500, 101, @increased_sal);

SELECT @increased_sal;

SELECT * FROM employees;

-- Dropping procedure
DROP PROCEDURE IF EXISTS PRACTICE_SQL.IncreaseEmpSalary;
