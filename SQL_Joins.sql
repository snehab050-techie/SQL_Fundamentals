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

-- fetch student details who are learning any course --
-- INNER JOIN -- Returns only matching records from two tables
SELECT s.stu_id, s.stu_name, c.crs_id, c.crs_name
FROM STUDENT AS s
INNER JOIN COURSE AS c
ON s.stu_id = c.stu_crs_id;
