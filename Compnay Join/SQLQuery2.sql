
--Display the department ID, department name, manager ID, and the full name of the manager.


SELECT 
    d.Dnum AS "Department ID",
    d.Dname AS "Department Name",
    d.MGRSSN AS "Manager ID",
   d.Dname AS "Manager Full Name"
FROM 
    Departments d
left JOIN 
    Departments m ON d.MGRSSN = m.Dnum

--Display the names of departments and the names of the projects they control.

SELECT 
    d.Dname AS "Department Name",
    p.Pname AS "Project Name"
FROM 
    Departments d
JOIN 
    Project p ON d.Dnum = p.Dnum;

-- Display full data of all dependents, along with the full name of the employee they depend on.
SELECT 
    d.*,
     concat(P.Fname,'',P.Lname) AS "Employee Name"
FROM 
    Dependent d
JOIN 
    Employee p ON d.ESSN=p.SSN


-- Display the project ID, name, and location of all projects located in Cairo or Alex.

SELECT 
    Pnumber AS "Project ID",
    Pname AS "Project Name", 
    Plocation AS "Project Location"
FROM 
    Project
WHERE 
    City IN ('Cairo', 'Alex');

--Display all project data where the project name starts with the letter 'A'.
SELECT 
  *
FROM 
    Project
WHERE 
Pname Like 'A%'

--Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE

SELECT 
  E.SSN,
      concat(E.Fname,'',E.Lname) AS "Employee Name"
FROM 
    Employee E, Departments D
WHERE 
D.Dnum=30 and E.Salary between 1000 and 2000

--Retrieve the names of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project.

SELECT 
    CONCAT(E.Fname, ' ', E.Lname) AS "Employee Name"
FROM 
    Employee E
JOIN 
    Departments D ON E.Dno = D.Dnum
JOIN 
    Works_for W ON E.Ssn = W.Essn
JOIN 
    Project P ON W.Pno = P.Pnumber
WHERE 
    D.Dnum = 10 
    AND P.Pname = 'AL Rabwah' 
    AND W.Hours >= 10;

--Find the names of employees who are directly supervised by "Kamel Mohamed".
SELECT 
    CONCAT(E.Fname, ' ', E.Lname) AS "Employee Name"
FROM 
    Employee E
JOIN 
    Employee S ON E.Superssn = S.Ssn
WHERE 
    S.Fname = 'Kamel' 
    AND S.Lname = 'Mohamed';

--Retrieve the names of employees and the names of the projects they work on, sorted by project name.

SELECT 
    CONCAT(E.Fname, ' ', E.Lname) AS "Employee Name",
    P.Pname AS "Project Name"
FROM 
    Employee E
JOIN 
    Works_for W ON E.Ssn = W.Essn
JOIN 
    Project P ON W.Pno = P.Pnumber

-- For each project located in Cairo, display the project number, controlling department name, manager's last name, 
--address, and birthdate

SELECT 
    P.Pnumber AS "Project Number",
    D.Dname AS "Department Name",
    M.Lname AS "Manager Last Name",
    M.Address AS "Manager Address",
    M.Bdate AS "Manager Birthdate"
FROM 
    Project P
JOIN 
    Departments D ON P.Dnum = D.Dnum
JOIN 
    Employee M ON D.MGRSSN = M.Ssn
WHERE 
    P.City = 'Cairo'

--Display all data of managers in the company.

SELECT DISTINCT E.*
FROM Employee E
LEFT JOIN Departments D ON E.Ssn = D.MGRSSN
LEFT JOIN Employee E2 ON E.Ssn = E2.Superssn
WHERE D.MGRSSN IS NOT NULL OR E2.Superssn IS NOT NULL;

--Display all employees and their dependents, even if some employees have no dependents.

SELECT 
    e.SSN,
    e.Fname,
    e.Lname,
    d.Dnum,
    d.Dname
FROM 
    Employee e
LEFT JOIN 
    Departments d ON e.SSN = d.Dnum

