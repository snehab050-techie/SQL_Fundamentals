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

-- Write a stored procedure named CalculateBonus that:
-- Accepts an employee's salary using an INOUT parameter called emp_salary.
-- Adds a 10% bonus to the salary.
-- Returns the updated salary through the same parameter.

DELIMITER //

CREATE PROCEDURE CalculateBonus(INOUT emp_salary DECIMAL(10,2))
BEGIN
	SET emp_salary = emp_salary * 1.10;
END //

DELIMITER ;

CALL CalculateBonus(@emp_salary);

SELECT @emp_salary;

-- Condtional statements in stored procedures
-- IF, ELSEIF, ELSE

-- Example - to ctegorize employees based on salary
DELIMITER //

CREATE PROCEDURE GetSalaryCategory(
    IN emp_id INT,
    OUT salary_category VARCHAR(20)
)
BEGIN
    DECLARE emp_salary DECIMAL(10,2);

    SELECT salary
    INTO emp_salary
    FROM employees
    WHERE employee_id = emp_id;

    IF emp_salary >= 70000 THEN
        SET salary_category = 'High Salary';
    ELSEIF emp_salary >= 50000 THEN
        SET salary_category = 'Medium Salary';
    ELSE
        SET salary_category = 'Low Salary';
    END IF;
END //

DELIMITER ;

-- Write a stored procedure named CheckEmployeeSalary that:
-- Accepts an employee ID as an IN parameter.
-- Returns a message through an OUT parameter named salary_message.
-- If salary is greater than ₹60,000, return 'Salary is above 60000'.
-- Otherwise, return 'Salary is 60000 or below'.
USE practice_sql;

DELIMITER //

CREATE PROCEDURE CheckEmployeeSalary(IN emp_id INT, OUT salary_message VARCHAR(50))
BEGIN
	DECLARE emp_sal DECIMAL(10,2);
    
    SELECT salary
    INTO emp_sal
    FROM employees
    WHERE employee_id = emp_id;
    
    IF emp_sal > 60000 THEN
		SET salary_message = 'Salary is above 60000';
	ELSE
		SET salary_message = 'Salary is 60000 or below';
	END IF;
END //

DELIMITER ;

CALL CheckEmployeeSalary(103, @sal_msg);

SELECT @sal_msg;

DROP PROCEDURE IF EXISTS PRACTICE_SQL.CheckEmployeeSalary;

