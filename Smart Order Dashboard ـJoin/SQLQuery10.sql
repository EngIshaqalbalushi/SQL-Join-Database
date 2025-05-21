create database SmartOrederSystm

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Phone VARCHAR(20),
    ReferralID INT NULL,
    FOREIGN KEY (ReferralID) REFERENCES Customers(CustomerID)
);

-- Restaurants Table
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    Name NVARCHAR(100),
    City NVARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ItemName NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(6,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Menu Table
CREATE TABLE Menu (
    MenuID INT PRIMARY KEY,
    RestaurantID INT,
    ItemName NVARCHAR(100),
    Price DECIMAL(6,2),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- Insert Sample Data

-- Customers
INSERT INTO Customers VALUES 
(1, 'Ahmed AlHarthy', '91234567', NULL),
(2, 'Fatma AlBalushi', '92345678', 1),
(3, 'Salim AlZadjali', '93456789', NULL),
(4, 'Aisha AlHinai', '94567890', 2);

-- Restaurants
INSERT INTO Restaurants VALUES 
(1, 'Shawarma King', 'Muscat'),
(2, 'Pizza World', 'Sohar'),
(3, 'Burger Spot', 'Nizwa');

-- Menu
INSERT INTO Menu VALUES
(1, 1, 'Shawarma Chicken', 1.500),
(2, 1, 'Shawarma Beef', 1.800),
(3, 2, 'Pepperoni Pizza', 3.000),
(4, 2, 'Cheese Pizza', 2.500),
(5, 3, 'Classic Burger', 2.000),
(6, 3, 'Zinger Burger', 2.200);

-- Orders
INSERT INTO Orders VALUES
(101, 1, 1, '2024-05-01', 'Delivered'),
(102, 2, 2, '2024-05-02', 'Preparing'),
(103, 3, 1, '2024-05-03', 'Cancelled'),
(104, 4, 3, '2024-05-04', 'Delivered');

-- OrderItems
INSERT INTO OrderItems VALUES
(1, 101, 'Shawarma Chicken', 2, 1.500),
(2, 101, 'Shawarma Beef', 1, 1.800),
(3, 102, 'Pepperoni Pizza', 1, 3.000),
(4, 104, 'Classic Burger', 2, 2.000),
(5, 104, 'Zinger Burger', 1, 2.200);


---Widget 1

SELECT 
    c.FullName AS CustomerName,
    r.Name AS RestaurantName,
    o.OrderDate
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Restaurants r ON o.RestaurantID = r.RestaurantID
WHERE 
    o.Status = 'Preparing';


---Widget 2



---Widget 3

SELECT 
    c.CustomerID,
    c.FullName,
    c.Phone
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderID IS NULL;
---Widget 4

SELECT 
    c.CustomerID,
    c.FullName AS CustomerName,
    o.OrderID,
    o.OrderDate,
    o.Status
FROM 
    Customers c
FULL OUTER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
ORDER BY 
    c.CustomerID, o.OrderDate;


---Widget 5

SELECT 
    c.FullName AS Customer,
    ref.FullName AS ReferredBy
FROM 
    Customers c
LEFT JOIN 
    Customers ref ON c.ReferralID = ref.CustomerID;

---Widget 6
SELECT 
    r.Name AS Restaurant,
    m.ItemName,
    COUNT(oi.OrderItemID) AS TimesOrdered,
    COALESCE(SUM(oi.Quantity), 0) AS TotalQuantitySold
FROM 
    Menu m
JOIN 
    Restaurants r ON m.RestaurantID = r.RestaurantID
LEFT JOIN 
    OrderItems oi ON m.ItemName = oi.ItemName
LEFT JOIN 
    Orders o ON oi.OrderID = o.OrderID AND o.RestaurantID = m.RestaurantID
GROUP BY 
    r.Name, m.ItemName
ORDER BY 
    r.Name, m.ItemName;

---Widget 7
SELECT 
    c.FullName AS EntityName,
    'Unused Customer' AS Type
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderID IS NULL

UNION ALL

SELECT 
    m.ItemName AS EntityName,
    'Unused Item' AS Type
FROM 
    Menu m
LEFT JOIN 
    OrderItems oi ON m.ItemName = oi.ItemName
WHERE 
    oi.OrderItemID IS NULL
ORDER BY 
    Type, EntityName;


---Widget 8
SELECT 
    o.OrderID,
    oi.ItemName,
    oi.Price AS OrderedPrice,
    m.Price AS CurrentMenuPrice
FROM 
    OrderItems oi
JOIN 
    Orders o ON oi.OrderID = o.OrderID
LEFT JOIN 
    Menu m ON o.RestaurantID = m.RestaurantID AND oi.ItemName = m.ItemName
WHERE 
    m.MenuID IS NULL OR oi.Price != m.Price;

---Widget 9
SELECT 
    c.FullName,
    COUNT(o.OrderID) AS TotalOrders,
    MIN(o.OrderDate) AS FirstOrderDate,
    MAX(o.OrderDate) AS LastOrderDate
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.FullName
HAVING 
    COUNT(o.OrderID) > 1
ORDER BY 
    TotalOrders ;

---Widget 10

WITH ReferralRevenue AS (
    SELECT 
        ref.FullName AS Referrer,
        c.FullName AS ReferredCustomer,
        SUM(oi.Quantity * oi.Price) AS TotalSpent
    FROM 
        Customers c
    JOIN 
        Customers ref ON c.ReferralID = ref.CustomerID
    LEFT JOIN 
        Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN 
        OrderItems oi ON o.OrderID = oi.OrderID
    GROUP BY 
        ref.FullName, c.FullName
)
SELECT 
    Referrer,
    ReferredCustomer,
    TotalSpent
FROM 
    ReferralRevenue
ORDER BY 
    Referrer, TotalSpent DESC;

--Widget 11

UPDATE Menu
SET Price = Price * 1.10
FROM Menu m
JOIN (
    SELECT 
        oi.ItemName,
        o.RestaurantID,
        SUM(oi.Quantity) AS TotalOrdered
    FROM 
        OrderItems oi
    JOIN 
        Orders o ON oi.OrderID = o.OrderID
    GROUP BY 
        oi.ItemName, o.RestaurantID
    HAVING 
        SUM(oi.Quantity) > 3
) AS PopularItems
ON m.ItemName = PopularItems.ItemName 
AND m.RestaurantID = PopularItems.RestaurantID;

--Widget 12
DELETE FROM Customers
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders 
    WHERE Orders.CustomerID = Customers.CustomerID
)
AND ReferralID IS NULL;
--Widget 13
UPDATE Menu
SET Price = Price * 0.85
FROM Menu m
JOIN Restaurants r ON m.RestaurantID = r.RestaurantID
LEFT JOIN Orders o ON r.RestaurantID = o.RestaurantID
WHERE o.OrderID IS NULL;

--Widget 14
SELECT DISTINCT c.CustomerID, c.FullName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
ORDER BY c.CustomerID;

--Widget 15
SELECT 
    c.FullName AS CustomerName,
    r.Name AS RestaurantName,
    oi.ItemName AS OrderedItem,
    oi.Quantity,
    oi.Price AS ItemPrice,
    (oi.Quantity * oi.Price) AS ItemTotal,
    o.OrderDate,
    o.Status AS OrderStatus
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Restaurants r ON o.RestaurantID = r.RestaurantID
JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
ORDER BY 
    o.OrderDate DESC, 
    r.Name, 
    c.FullName;



