create database SQLJoins;

use SQLJoins;

show tables;

create table student(
	stu_id INT PRIMARY KEY,
    stu_name VARCHAR(50) NOT NULL
);

INSERT INTO STUDENT(stu_id,stu_name)
VALUES
(101,"Sneha"),
(102,"Suhas"),
(103,"Janaki");

INSERT INTO STUDENT(stu_id,stu_name)
VALUES
(104,"Oliver"),
(105,"John");

SELECT *
FROM STUDENT;

CREATE TABLE COURSE(
  crs_id INT PRIMARY KEY,
  crs_name VARCHAR(20) NOT NULL
);

ALTER TABLE COURSE 
ADD COLUMN stu_crs_id INT NOT NULL;

DESC COURSE;

SELECT * FROM COURSE;

INSERT INTO COURSE
VALUES
(1, "ME", 102),
(2, "IT", 101),
(3, "CS", 102);

INSERT INTO COURSE
VALUES
(4, "EE", 103),
(5, "ECE", 101);

-- fetch student details who are learning any course --
-- 1) INNER JOIN -- Returns only matching records from two tables

SELECT s.stu_id, s.stu_name, c.crs_id, c.crs_name
FROM STUDENT AS s
INNER JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id;

-- 2) LEFT JOIN - Aka Left Outer Join
-- Returns all rows from left table and only the matching records from right table
-- for students who did not take any course - null willbe printed in course columns

SELECT s.stu_id, s.stu_name, c.crs_id, c.crs_name
FROM STUDENT AS s
LEFT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id;

-- 3) RIGHT Join - Aka RIGHT Outer Join
-- Returns all records form right table and only the matching records from the left table

SELECT *
FROM STUDENT AS s
RIGHT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id;

-- 4) FULL JOIN - Aka FULL Outer Join
-- Returns all records when there is a match in either left or right table

SELECT *
FROM STUDENT AS s
LEFT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id
UNION
SELECT *
FROM STUDENT AS s
RIGHT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id;

-- Other Joins 
-- 1) Left Exclusive Join - To fetch only the non matching records from left table

SELECT *
FROM STUDENT AS s
LEFT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id
WHERE c.stu_crs_id IS NULL;

-- 2) Right Exclusive Join - To fetch only the non matching records from right table

SELECT *
FROM STUDENT AS s
RIGHT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id
WHERE s.stu_id IS NULL;
 
-- 3) Full Exclusive Join - To fetch only the non matching records from both left and right tables
SELECT *
FROM STUDENT AS s
LEFT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id
WHERE c.stu_crs_id IS NULL
UNION
SELECT *
FROM STUDENT AS s
RIGHT JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id
WHERE s.stu_id IS NULL;

