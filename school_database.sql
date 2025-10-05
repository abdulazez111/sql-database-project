-- =============================================
-- SCHOOL MANAGEMENT SYSTEM DATABASE
-- Author: Abdulaziz111
-- =============================================

-- Create database
CREATE DATABASE altamyouz_school;
USE altamyouz_school;

-- =============================================
-- TABLE CREATION
-- =============================================

-- Students table
CREATE TABLE students (
    stud_id INT PRIMARY KEY,
    stud_name VARCHAR(255),
    birth_date DATE,
    gender CHAR(1),
    enrollment_date DATE,
    stud_level INT CHECK(stud_level BETWEEN 1 AND 6),
    email VARCHAR(255),
    track CHAR(20) CHECK (track IN ('Scientific','Humanities')),
    gpa DOUBLE
);

-- Subjects table
CREATE TABLE subjects (
    subj_id INT PRIMARY KEY,
    subj_name VARCHAR(255)
);

-- Teachers table
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(255),
    birth_date DATE,
    teacher_email VARCHAR(255),
    gender CHAR(1),
    office INT
);

-- =============================================
-- DATA INSERTION
-- =============================================

-- Insert 30 students
INSERT INTO students (stud_id, stud_name, birth_date, gender, enrollment_date, stud_level, email, track, gpa)
VALUES
(1, 'Ali Ahmed', '2005-03-12', 'M', '2020-09-01', 1, 'ali1@example.com', 'Scientific', 95),
-- ... (كل بيانات الطلاب هنا) ...
(30, 'Aya Sami', '2004-11-12', 'F', '2019-09-01', 2, 'aya30@example.com', 'Humanities', 88);

-- Insert 10 teachers
INSERT INTO teachers (teacher_id, teacher_name, birth_date, teacher_email, gender, office)
VALUES
(1, 'Ahmed Hassan', '1980-05-12', 'ahmed1@example.com', 'M', 101),
-- ... (كل بيانات المعلمين هنا) ...
(10, 'Rania Adel', '1982-05-20', 'rania10@example.com', 'F', 110);

-- Insert 6 subjects
INSERT INTO subjects (subj_id , subj_name)
VALUES 
(1, 'Mathematics'),
(2, 'Physics'),
(3, 'Chemistry'),
(4, 'Biology'),
(5, 'History'),
(6, 'English');

-- =============================================
-- ADVANCED QUERIES & FEATURES
-- =============================================

-- Rename table
ALTER TABLE subjects RENAME TO subject1;

-- Create outstanding students table
CREATE TABLE outstanding_students AS
SELECT * FROM students WHERE gpa > 90;

-- Create failed students table  
CREATE TABLE failed_students AS
SELECT * FROM students WHERE gpa < 60;

-- Advanced queries
SELECT AVG(gpa) AS average_gpa, MAX(gpa) AS highest_gpa, MIN(gpa) AS lowest_gpa FROM students;

-- Relationships
ALTER TABLE students ADD COLUMN teacher_id INT;
ALTER TABLE students ADD FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id);

CREATE TABLE student_subjects (
    student_id INT,
    subject_id INT,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students(stud_id),
    FOREIGN KEY (subject_id) REFERENCES subject1(subj_id)
);

-- Stored procedure
DELIMITER //
CREATE PROCEDURE student_info()
BEGIN
    SELECT s.stud_name, sub.subj_name, t.teacher_name
    FROM students s
    JOIN student_subjects ss ON s.stud_id = ss.student_id
    JOIN subject1 sub ON ss.subject_id = sub.subj_id
    JOIN teachers t ON s.teacher_id = t.teacher_id;
END //
DELIMITER ;

-- Views
CREATE VIEW teacher_info AS
SELECT t.teacher_name, t.office, sub.subj_name AS subject_taught
FROM teachers t
JOIN subject1 sub ON t.subject_id = sub.subj_id;

-- Indexes
CREATE INDEX idx_student_name ON students(stud_name);
