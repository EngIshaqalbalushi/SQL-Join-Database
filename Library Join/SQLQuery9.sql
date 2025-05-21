



-- Display library ID, name, and the name of the manager.

SELECT l.LibraryID, l.Name AS LibraryName, s.FullName AS ManagerName
FROM Library l
JOIN Staff s ON l.LibraryID = s.LibraryID
WHERE s.Position = 'Head Librarian' OR s.Position = 'Library Director';


-- Display library names and the books available in each one.
SELECT l.Name AS LibraryName, b.Title AS BookTitle
FROM Library l
JOIN Book b ON l.LibraryID = b.LibraryID
WHERE b.AvailabilityStatus = 1
ORDER BY l.Name, b.Title;


-- Display all member data along with their loan history.
SELECT m.*, b.Title AS BookTitle, l.LoanDate, l.DueDate, l.ReturnDate, l.Status
FROM Member m
LEFT JOIN Loan l ON m.MemberID = l.MemberID
LEFT JOIN Book b ON l.BookID = b.BookID
ORDER BY m.FullName;

-- Display all books located in 'Zamalek' or 'Downtown'.
SELECT b.Title, l.Location
FROM Book b
JOIN Library l ON b.LibraryID = l.LibraryID
WHERE l.Location LIKE '%Zamalek%' OR l.Location LIKE '%Downtown%';

-- Display all books whose titles start with 'T'.
SELECT Title
FROM Book
WHERE Title LIKE 'T%';
-- List members who borrowed books priced between 100 and 300 LE.
SELECT DISTINCT m.FullName, b.Title, b.Price
FROM Member m
JOIN Loan l ON m.MemberID = l.MemberID
JOIN Book b ON l.BookID = b.BookID
WHERE b.Price BETWEEN 100 AND 300;

-- Retrieve members who borrowed and returned books titled 'The Alchemist'.
SELECT m.FullName
FROM Member m
JOIN Loan l ON m.MemberID = l.MemberID
JOIN Book b ON l.BookID = b.BookID
WHERE b.Title = 'The Alchemist' AND l.Status = 'Returned';

-- Find all members assisted by librarian "Sarah Fathy".

SELECT DISTINCT m.FullName
FROM Member m
JOIN Loan l ON m.MemberID = l.MemberID
JOIN Book b ON l.BookID = b.BookID
JOIN Library lib ON b.LibraryID = lib.LibraryID
JOIN Staff s ON lib.LibraryID = s.LibraryID
WHERE s.FullName = 'Sarah Johnson';


--Display each member’s name and the books they borrowed, ordered by book title.
SELECT m.FullName AS MemberName, b.Title AS BookTitle
FROM Member m
JOIN Loan l ON m.MemberID = l.MemberID
JOIN Book b ON l.BookID = b.BookID
ORDER BY b.Title, m.FullName;

--- For each book located in 'Cairo Branch', show title, library name, manager, and shelf info.
SELECT b.Title, l.Name AS LibraryName, s.FullName AS ManagerName, b.ShelfLocation
FROM Book b
JOIN Library l ON b.LibraryID = l.LibraryID
JOIN Staff s ON l.LibraryID = s.LibraryID
WHERE l.Name = 'Central Public Library' 
AND (s.Position = 'Head Librarian' OR s.Position = 'Library Director');

-- Display all staff members who manage libraries.
SELECT s.FullName, s.Position, l.Name AS LibraryName
FROM Staff s
JOIN Library l ON s.LibraryID = l.LibraryID
WHERE s.Position IN ('Head Librarian', 'Library Director', 'Circulation Manager');



-- Display all members and their reviews, even if some didn’t submit any review yet.

SELECT m.FullName AS MemberName, r.Rating, r.Comments, b.Title AS BookTitle
FROM Member m
LEFT JOIN Review r ON m.MemberID = r.MemberID
LEFT JOIN Book b ON r.BookID = b.BookID
ORDER BY m.FullName;