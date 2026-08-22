CREATE DATABASE college_db;

\c college_db

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT CHECK (age >= 18),
    city VARCHAR(50)
);

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    department VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    fee DECIMAL(10,2) CHECK (fee >= 0),
    duration INT,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students VALUES
(1, 'Shreyas', 'shreyas@gmail.com', 19, 'Bangalore'),
(2, 'Rayhan', 'rayhan@gmail.com', 20, 'Hyderabad'),
(3, 'Shihan', 'shihan@gmail.com', 21, 'Mangalore'),
(4, 'Fadil', 'fadil@gmail.com', 19, 'Bangalore'),
(5, 'Yashwith', 'yashwith@gmail.com', 22, 'Hyderabad'),
(6, 'Isra', 'isra@gmail.com', 20, 'Chennai');

INSERT INTO Faculty VALUES
(1, 'Gagan Shetty', 'gagan.shetty@gmail.com', '9876543210', 'Computer Science'),
(2, 'Dharshan', 'dharshan@gmail.com', '9876543211', 'Artificial Intelligence'),
(3, 'Megha', 'megha@gmail.com', '9876543212', 'Information Science'),
(4, 'Sharada', 'sharada@gmail.com', '9876543213', 'Mathematics'),
(5, 'Rushikesh', 'rushikesh@gmail.com', '9876543214', 'Electronics');

INSERT INTO Courses VALUES
(101, 'Python Programming', 25000, 6, 1),
(102, 'Data Structures', 22000, 5, 2),
(103, 'Database Management', 18000, 4, 3),
(104, 'Machine Learning', 30000, 6, 2),
(105, 'Web Development', 20000, 5, 1),
(106, 'Mathematics', 15000, 4, 4),
(107, 'Computer Networks', 23000, 5, 5),
(108, 'Artificial Intelligence', 35000, 6, 2);

INSERT INTO Enrollments VALUES
(1, 1, 101, '2026-01-10'),
(2, 2, 102, '2026-01-11'),
(3, 3, 103, '2026-01-12'),
(4, 4, 104, '2026-01-13'),
(5, 5, 105, '2026-01-14');

SELECT * FROM Students;

SELECT * FROM Faculty;

SELECT * FROM Courses;

SELECT student_name
FROM Students;

SELECT faculty_name
FROM Faculty;

SELECT *
FROM Students
WHERE age > 20;

SELECT *
FROM Students
WHERE city = 'Hyderabad';

SELECT *
FROM Students
WHERE city = 'Hyderabad'
AND age > 20;

SELECT *
FROM Students
WHERE city = 'Hyderabad'
OR city = 'Bangalore';

SELECT *
FROM Students
WHERE age BETWEEN 18 AND 22;

SELECT *
FROM Students
WHERE student_name LIKE 'A%';

SELECT *
FROM Students
WHERE student_name LIKE '%N';

SELECT *
FROM Students
WHERE student_name LIKE '%RA%';

SELECT DISTINCT city
FROM Students;

SELECT *
FROM Students
LIMIT 5;

SELECT *
FROM Courses
ORDER BY fee DESC
LIMIT 3;

SELECT *
FROM Courses
WHERE fee > 20000;

SELECT *
FROM Courses
ORDER BY fee DESC;

SELECT COUNT(*) AS total_students
FROM Students;

SELECT COUNT(*) AS total_faculty
FROM Faculty;

SELECT
    MAX(fee) AS highest_fee,
    MIN(fee) AS lowest_fee,
    AVG(fee) AS average_fee,
    SUM(fee) AS total_fee
FROM Courses;

SELECT
    city,
    COUNT(*) AS student_count
FROM Students
GROUP BY city;

SELECT
    department,
    COUNT(*) AS faculty_count
FROM Faculty
GROUP BY department
HAVING COUNT(*) > 1;

UPDATE Students
SET city = 'Mysore'
WHERE student_id = 1;

UPDATE Courses
SET fee = 28000
WHERE course_id = 101;

UPDATE Faculty
SET department = 'Data Science'
WHERE faculty_id = 3;

UPDATE Courses
SET faculty_id = 5
WHERE course_id = 105;

DELETE FROM Enrollments
WHERE enrollment_id = 5;

DELETE FROM Students
WHERE student_id = 6;

DELETE FROM Courses
WHERE course_id = 108;

SELECT
    s.student_name,
    c.course_name
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id;

SELECT
    c.course_name,
    f.faculty_name
FROM Courses c
JOIN Faculty f
    ON c.faculty_id = f.faculty_id;

SELECT
    s.student_name,
    c.course_name,
    e.enrollment_date
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id;

SELECT
    s.student_name,
    c.course_name,
    f.faculty_name
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id
JOIN Faculty f
    ON c.faculty_id = f.faculty_id;

SELECT
    s.student_name,
    c.course_name
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
LEFT JOIN Courses c
    ON e.course_id = c.course_id;

SELECT
    c.course_name,
    s.student_name
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
LEFT JOIN Students s
    ON e.student_id = s.student_id;

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

SELECT
    f.faculty_name,
    COUNT(c.course_id) AS total_courses
FROM Faculty f
LEFT JOIN Courses c
    ON f.faculty_id = c.faculty_id
GROUP BY f.faculty_id, f.faculty_name;

SELECT
    s.student_name,
    c.course_name,
    f.faculty_name
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id
JOIN Faculty f
    ON c.faculty_id = f.faculty_id
WHERE f.faculty_name = 'Dharshan';

SELECT
    f.faculty_name,
    COUNT(e.student_id) AS total_students
FROM Faculty f
JOIN Courses c
    ON f.faculty_id = c.faculty_id
JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY f.faculty_id, f.faculty_name
ORDER BY total_students DESC
LIMIT 1;