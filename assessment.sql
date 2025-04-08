--#1.List all databases in the current MySQL instance:
show databases ;
--#2.Create a new table Instructors with the following columns: InstructorID (INT, PrimaryKey), FirstName (VARCHAR(50)), LastName (VARCHAR(50)), and DepartmentID (INT).
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);
--#3Add a new column Email (VARCHAR(100)) to the Students table.
alter table students 
add column Email VARCHAR(100);
describe students ;
--#4Modify the Courses table to increase the length of CourseName to 150 characters.
ALTER TABLE Courses 
MODIFY CourseName VARCHAR(150);
--#1.List all databases in the current MySQL instance:
show databases ;
--#2.Create a new table Instructors with the following columns: InstructorID (INT, PrimaryKey), FirstName (VARCHAR(50)), LastName (VARCHAR(50)), and DepartmentID (INT).
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);
--#3Add a new column Email (VARCHAR(100)) to the Students table.
alter table students 
add column Email VARCHAR(100);
describe students ;
--#4Modify the Courses table to increase the length of CourseName to 150 characters.
ALTER TABLE Courses 
MODIFY CourseName VARCHAR(150);
--#1.List all databases in the current MySQL instance:
show databases ;
--#2.Create a new table Instructors with the following columns: InstructorID (INT, PrimaryKey), FirstName (VARCHAR(50)), LastName (VARCHAR(50)), and DepartmentID (INT).
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);
--#3Add a new column Email (VARCHAR(100)) to the Students table.
alter table students 
add column Email VARCHAR(100);
describe students ;
--#4Modify the Courses table to increase the length of CourseName to 150 characters.
ALTER TABLE Courses 
MODIFY CourseName VARCHAR(150);
--#1.List all databases in the current MySQL instance:
show databases ;
--#2.Create a new table Instructors with the following columns: InstructorID (INT, PrimaryKey), FirstName (VARCHAR(50)), LastName (VARCHAR(50)), and DepartmentID (INT).
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);
--#3Add a new column Email (VARCHAR(100)) to the Students table.
alter table students 
add column Email VARCHAR(100);
describe students ;
--#4Modify the Courses table to increase the length of CourseName to 150 characters.
ALTER TABLE Courses 
MODIFY CourseName VARCHAR(150);
--#5 Insert a new department into the Departments table with the name Data Science.
INSERT INTO Departments (DepartmentName)  
VALUES ('Data Science');
select*from Departments ;
--#6 Insert a new student named John Doe into the Students table, associating them with the Data Science department.
select *from students ;
INSERT INTO Students (FirstName, LastName, DepartmentID, EnrollmentDate)  
VALUES ('John', 'Doe', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science'), CURDATE());
--#7Select the FirstName and LastName of students who belong to the department withDepartmentID = 1.
SELECT FirstName,LastName from students
where DepartmentID = 1;
--#8Count the number of students in each department.
SELECT d.DepartmentName, COUNT(s.StudentID) AS StudentCount  
FROM Departments d  
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID  
GROUP BY d.DepartmentName  
ORDER BY StudentCount DESC;
--#9Display the first 5 students who enrolled earliest in the university.
SELECT FirstName, LastName, EnrollmentDate  
FROM Students  
ORDER BY EnrollmentDate ASC  
LIMIT 5;
--#10 Retrieve the current date and time from the database.
SELECT CURDATE() AS CurrentDate;
SELECT CURTIME() AS CurrentTime;
SELECT NOW() AS CurrentDateTime;
--#11 Concatenate the FirstName and LastName of students into a single column called FullName.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName  
FROM Students;
--#12 Assign a unique RowNumber to each student, ordered by their EnrollmentDate (oldestfirst).
SELECT  
    ROW_NUMBER() OVER (ORDER BY EnrollmentDate ASC) AS RowNumber,  
    FirstName,  
    LastName,  
    EnrollmentDate  
FROM Students;
--#13Use an INNER JOIN to list all students along with the department name they belong to.
SELECT  
    s.FirstName,  
    s.LastName,  
    d.DepartmentName  
FROM Students s  
INNER JOIN Departments d ON s.DepartmentID = d.DepartmentID;
--#14Rank students based on their enrollment date (oldest first). Assign the same rank forties.
SELECT  
   RANK() OVER (ORDER BY EnrollmentDate ASC) AS rank,  
    FirstName,  
    LastName,  
    EnrollmentDate  
FROM Students;
--#15Use a FULL OUTER JOIN to list all students and departments, including unmatched records from both sides.
SELECT s.FirstName, s.LastName, d.DepartmentName  
FROM Students s  
LEFT JOIN Departments d ON s.DepartmentID = d.DepartmentID  
UNION  
SELECT s.FirstName, s.LastName, d.DepartmentName  
FROM Students s  
RIGHT JOIN Departments d ON s.DepartmentID = d.DepartmentID;
--#16 Use UNION ALL to list all student and instructor first names, including duplicates.
SELECT FirstName FROM Students  
UNION ALL  
SELECT FirstName FROM Instructors;
--#17Create a view to show courses with more than 3 credits.
CREATE VIEW CoursesAbove3Credits AS  
SELECT CourseID, CourseName, Credits  
FROM Courses  
WHERE Credits > 3;
--#18Create a procedure to retrieve the total number of students enrolled in a specific course.
DELIMITER $$

CREATE PROCEDURE GetStudentCountByCourse(IN course_id INT)
BEGIN
    SELECT c.CourseName, COUNT(sc.StudentID) AS TotalStudents
    FROM Courses c
    LEFT JOIN StudentCourses sc ON c.CourseID = sc.CourseID
    WHERE c.CourseID = course_id
    GROUP BY c.CourseName;
END $$

DELIMITER ;
CALL GetStudentCountByCourse(101);













    


