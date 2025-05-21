


--Display the department ID, name, and the full name of the faculty managing it.
SELECT c.Course_name AS program_name, d.D_name AS department_name
FROM COURSE c
JOIN Handled h ON c.Course_id = h.Course_id
JOIN DEPARTMENT d ON h.Department_id = d.Department_id;

--------Display each program's name and the name of the department offering it.
SELECT c.Course_name AS program_name, d.D_name AS department_name
FROM COURSE c
JOIN Handled h ON c.Course_id = h.Course_id
JOIN DEPARTMENT d ON h.Department_id = d.Department_id;


---------- Display the full student data and the full name of their faculty advisor.
SELECT s.*, f.Name AS faculty_advisor
FROM STUDENT s
JOIN Teaches t ON s.S_id = t.S_id
JOIN FACULTY f ON t.F_id = f.F_id;


---------Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'.
SELECT e.Exam_code AS class_id, sub.Subject_name AS course_title, e.Room
FROM EXAMS e
JOIN Take t ON e.Exam_code = t.Exam_code
JOIN Taught ta ON t.S_id = ta.S_id
JOIN SUBJECT sub ON ta.Subject_id = sub.Subject_id
WHERE e.Room LIKE 'A%' OR e.Room LIKE 'B%';

------- Display full data about courses whose titles start with "I" (e.g., "Introduction to...").
SELECT *
FROM COURSE
WHERE Course_name LIKE 'C%'

------Display names of students in program ID 3 whose GPA is between 2.5 and 3.5.
SELECT S_id, F_name, L_name, Age
FROM STUDENT
WHERE S_id =1001
  AND Age BETWEEN 20 AND 21

------ Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course.
SELECT s.Name AS Student_Name
FROM STUDENT s
JOIN Belong b ON s.S_id = b.S_id
JOIN DEPARTMENT d ON b.Department_id = d.Department_id
JOIN Enroll e ON s.S_id = e.S_id
JOIN COURSE c ON e.Course_id = c.Course_id
WHERE d.D_name = 'Computer Science'
  AND c.Course_name = 'Computer Science'

  ----Find names of students who are advised by "Dr. Ahmed Hassan"
 SELECT s.Name AS Student_Name
FROM STUDENT s
JOIN Teaches t ON s.S_id = t.S_id
JOIN FACULTY f ON t.F_id = f.F_id
WHERE f.Name = 'Dr. John Smith';

---Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title
SELECT 
    s.Name AS Student_Name,
    c.Course_name AS Course_Title
FROM 
    STUDENT s
JOIN 
    Enroll e ON s.S_id = e.S_id
JOIN 
    COURSE c ON e.Course_id = c.Course_id

-----For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class.

SELECT 
    e.Exam_code AS Class_ID,
    c.Course_name,
    d.D_name AS Department_Name,
    f.Name AS Faculty_Name
FROM 
    EXAMS e
JOIN 
    Conducted cd ON e.Exam_code = cd.Exam_code
JOIN 
    HOSTEL h ON cd.Hostel_id = h.Hostel_id
JOIN 
    Take t ON e.Exam_code = t.Exam_code
JOIN 
    Teaches tc ON t.S_id = tc.S_id
JOIN 
    FACULTY f ON tc.F_id = f.F_id
JOIN 
    Enroll en ON t.S_id = en.S_id
JOIN 
    COURSE c ON en.Course_id = c.Course_id
JOIN 
    Belong b ON t.S_id = b.S_id
JOIN 
    DEPARTMENT d ON b.Department_id = d.Department_id
WHERE 
    h.Hostel_name = 'Unity Hostel'

---Display all faculty members who manage any department.

SELECT 
    f.F_id,
    f.Name AS Faculty_Name,
    d.D_name AS Department_Name
FROM 
    FACULTY f
JOIN 
    DEPARTMENT d ON f.F_id =d.Department_id ;

	INSERT INTO DEPARTMENT (Department_id, D_name)
VALUES (101, 'New Department Name');

---Display all students and their advisors' names, even if some students don’t have advisors yet.
SELECT 
    s.Name AS Student_Name,
    f.Name AS Advisor_Name,
    f.Department AS Advisor_Department
FROM 
    STUDENT s
LEFT JOIN 
    Teaches t ON s.S_id = t.S_id
LEFT JOIN 
    FACULTY f ON t.F_id = f.F_id;

