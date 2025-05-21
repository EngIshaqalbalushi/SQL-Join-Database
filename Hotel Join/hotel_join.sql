1. SELECT 
    B.BranchID,
    B.Name AS BranchName,
    S.Name AS ManagerName
FROM 
    Branch B
JOIN 
    Staff S ON B.BranchID = S.BranchID
WHERE 
    S.JobTitle = 'Manager';

	INSERT INTO Staff (StaffID, BranchID, Name, JobTitle, Salary)
VALUES (3, 1, 'Zahra Al-Amri', 'Manager', 600.00);

2. 
SELECT 
    B.Name AS BranchName,
    R.RoomNumber,
    R.Type,
    R.NightlyRate
FROM 
    Branch B
JOIN 
    Room R ON B.BranchID = R.BranchID;

	--3.
	SELECT 
    C.CustomerID,
    C.Name AS CustomerName,
    B.BookingID,
    B.CheckInDate,
    B.CheckOutDate
FROM 
    Customer C
LEFT JOIN 
    Booking B ON C.CustomerID = B.CustomerID;
	--4.
	SELECT 
    B.BookingID,
    C.Name AS CustomerName,
    BR.Name AS BranchName,
    BR.Location
FROM 
    Booking B
JOIN 
    Customer C ON B.CustomerID = C.CustomerID
JOIN 
    Booking_Room BRM ON B.BookingID = BRM.BookingID
JOIN 
    Room R ON BRM.RoomNumber = R.RoomNumber AND BRM.BranchID = R.BranchID
JOIN 
    Branch BR ON R.BranchID = BR.BranchID
WHERE 
    BR.Location IN ('Muscat', 'Salalah');

	--5.
	SELECT *
FROM Room
WHERE Type LIKE 'S%';

--6.
SELECT DISTINCT 
    C.Name AS CustomerName
FROM 
    Customer C
JOIN 
    Booking B ON C.CustomerID = B.CustomerID
JOIN 
    Booking_Room BRM ON B.BookingID = BRM.BookingID
JOIN 
    Room R ON BRM.RoomNumber = R.RoomNumber AND BRM.BranchID = R.BranchID
WHERE 
    R.NightlyRate BETWEEN 1500 AND 2500;

	UPDATE Room 
SET NightlyRate = 1800 
WHERE RoomNumber = 201 AND BranchID = 2;




	SELECT * FROM Branch;

	INSERT INTO Branch (BranchID, Name, Location)
VALUES (3, 'Hilton Downtown', 'Cairo');

INSERT INTO Booking_Room (BookingID, RoomNumber, BranchID)
VALUES (1, 102, 3);

UPDATE Booking
SET Status = 'Confirmed'
WHERE BookingID = 1;
SELECT * FROM Booking WHERE Status = 'Confirmed';

INSERT INTO Room (RoomNumber, BranchID, Type, NightlyRate)
VALUES (103, 3, 'Suite', 2000.00);
INSERT INTO Booking (BookingID, CustomerID, CheckInDate, CheckOutDate, Status)
VALUES (3, 1, '2025-07-01', '2025-07-05', 'Confirmed');
INSERT INTO Booking_Room (BookingID, RoomNumber, BranchID)
VALUES (3, 103, 3);


--7.
SELECT DISTINCT 
    C.Name AS CustomerName
FROM 
    Customer C
JOIN Booking B ON C.CustomerID = B.CustomerID
JOIN Booking_Room BRM ON B.BookingID = BRM.BookingID
JOIN Branch BR ON BRM.BranchID = BR.BranchID
WHERE 
    B.Status = 'Confirmed'
    AND BR.Name = 'Hilton Downtown';

	--8.
	-- Task 8: Find guests whose bookings were handled by staff member "Mona Ali"

SELECT DISTINCT 
    C.Name AS CustomerName
FROM 
    Customer C
JOIN Booking B ON C.CustomerID = B.CustomerID
JOIN Check_Record CR ON C.CustomerID = CR.CustomerID AND B.BookingID = CR.BookingID
JOIN Staff S ON CR.StaffID = S.StaffID
WHERE 
    S.Name = 'Mona Ali';

-- Use StaffID = 4 instead
INSERT INTO Staff (StaffID, BranchID, Name, JobTitle, Salary)
VALUES (4, 1, 'Mona Ali', 'Receptionist', 500.00);

-- Link Mona to a booking that doesn’t already have a Check_Record entry
-- Use BookingID = 2 if it’s free with CustomerID = 2
INSERT INTO Check_Record (StaffID, CustomerID, BookingID, Role, Timestamp)
VALUES (4, 2, 2, 'Check-in', '2025-06-01 15:30:00');

SELECT DISTINCT
    C.Name AS CustomerName
FROM 
    Customer C
JOIN Booking B ON C.CustomerID = B.CustomerID
JOIN Check_Record CR ON C.CustomerID = CR.CustomerID AND B.BookingID = CR.BookingID
JOIN Staff S ON CR.StaffID = S.StaffID
WHERE 
    S.Name = 'Mona Ali';


	--9.
	SELECT 
    C.Name AS CustomerName,
    R.RoomNumber,
    R.Type AS RoomType
FROM 
    Customer C
JOIN Booking B ON C.CustomerID = B.CustomerID
JOIN Booking_Room BRM ON B.BookingID = BRM.BookingID
JOIN Room R ON BRM.RoomNumber = R.RoomNumber AND BRM.BranchID = R.BranchID
ORDER BY 
    R.Type;


	--10.
	SELECT 
    B.BranchID,
    B.Name AS HotelName,
    S.Name AS ManagerName,
    S.Salary AS ContactInfo  -- Change to email/phone if such column exists
FROM 
    Branch B
JOIN Staff S ON B.BranchID = S.BranchID
WHERE 
    B.Location = 'Cairo'
    AND S.JobTitle = 'Manager';

	-- Add a Manager to the Cairo branch
INSERT INTO Staff (StaffID, BranchID, Name, JobTitle, Salary)
VALUES (5, 3, 'Layla Hassan', 'Manager', 800.00);


--11.
SELECT 
    StaffID,
    Name AS StaffName,
    JobTitle,
    BranchID,
    Salary
FROM 
    Staff
WHERE 
    JobTitle = 'Manager';

	--12.

	CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Review (ReviewID, CustomerID, Rating, Comment, ReviewDate) VALUES
(1, 1, 4, 'Nice stay', '2025-05-24'),
(2, 2, 5, 'Excellent service', '2025-06-06');

	SELECT 
    C.CustomerID,
    C.Name AS CustomerName,
    R.Rating,
    R.Comment,
    R.ReviewDate
FROM 
    Customer C
LEFT JOIN 
    Review R ON C.CustomerID = R.CustomerID;
