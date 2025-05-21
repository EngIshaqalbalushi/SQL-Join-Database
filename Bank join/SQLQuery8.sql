



--1. Display branch ID, name, and the name of the employee who manages it.

SELECT b.branch_id, b.address AS branch_name, e.name AS manager_name
FROM branch b
JOIN Employers e ON b.branch_id = e.branch_id
WHERE e.position = 'Branch Manager';



---2. Display branch names and the accounts opened under each.

SELECT c.*, l.l_id, l.type AS loan_type, l.amount, l.issue_date
FROM Customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id;

---3. Display full customer details along with their loans.

SELECT c.*, l.l_id, l.type AS loan_type, l.amount, l.issue_date
FROM Customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id;

---4. Display loan records where the loan office is in 'Alexandria' or 'Giza'.

SELECT l.*
FROM loans l
JOIN Customers c ON l.customer_id = c.customer_id
WHERE c.address LIKE '%Alexandria%' OR c.address LIKE '%Giza%';



---5. Display account data where the type starts with "S" (e.g., "Savings").


SELECT *
FROM account
WHERE type LIKE 'S%';


---6. List customers with accounts having balances between 20,000 and 50,000.
SELECT c.*
FROM Customers c
JOIN account a ON [need account-customer relationship]
WHERE a.balance BETWEEN 20000 AND 50000;

--7. Retrieve customer names who borrowed more than 100,000 LE from 'Cairo Main Branch'.



---8. Find all customers assisted by employee "Amira Khaled".
SELECT c.*
FROM Customers c
JOIN assist a ON c.customer_id = a.customer_id
JOIN Employers e ON a.employee_id = e.employee_id
WHERE e.name = 'Amira Khaled';

----9. Display each customer’s name and the accounts they hold, sorted by account type.

SELECT *
FROM Employers
WHERE position = 'Branch Manager';

---10. For each loan issued in Cairo, show loan ID, customer name, employee handling it, and branch name.



----11. Display all employees who manage any branch.

SELECT *
FROM Employers
WHERE position = 'Branch Manager';



----12. Display all customers and their transactions, even if some customers have no transactions yet

SELECT c.*, t.*
FROM Customers c
LEFT JOIN [customer_account_relationship] ca ON c.customer_id = ca.customer_id
LEFT JOIN account a ON ca.account_number = a.account_number
LEFT JOIN transactions t ON a.account_number = t.account_number;