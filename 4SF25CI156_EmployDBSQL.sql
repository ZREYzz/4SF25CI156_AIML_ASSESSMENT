
CREATE TABLE Department(
	dept_id INT primary key,
	dept_name VARCHAR(50)
);

CREATE TABLE Employee(
	emp_id INT primary key,
	emp_name VARCHAR(100),
	salary DECIMAL(10,2),
	dept_id INT,
	foreign key (dept_id) references Department(dept_id)
);

INSERT INTO Department (dept_id,dept_name) Values
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employee (emp_id,emp_name,salary,dept_id) Values
(101, 'Shreyas', 60000, 1),
(102, 'Rayhan', 45000, 2),
(103, 'Shihan', 75000, 1),
(104, 'Fadil', 52000, 3),
(105, 'Taazim', 40000, 4),
(106, 'Isra', 65000, 3),
(107, 'Yashwith', 48000, 2);


SELECT * FROM Employee;

SELECT DISTINCT dept_name
FROM Department;

SELECT *
FROM Employee
WHERE salary>50000;

SELECT *
FROM Employee
WHERE dept_id=1;

SELECT *
FROM Employee
WHERE salary BETWEEN 40000 AND 60000;

SELECT *
FROM Employee
WHERE dept_id IN (1,3);

SELECT *
FROM Employee
ORDER BY salary DESC;

SELECT *
FROM Employee
WHERE salary>50000
AND dept_id=1;

SELECT *
FROM Employee
WHERE dept_id=1
OR dept_id=3;

SELECT *
FROM Employee
WHERE NOT dept_id=2;

