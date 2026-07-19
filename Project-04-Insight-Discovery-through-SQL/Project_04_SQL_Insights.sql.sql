USE shopsphere_db;
USE shopsphere_db;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Region VARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    SubCategory VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Order Details Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Customers Data
INSERT INTO Customers VALUES
(1,'Rahul','West'),
(2,'Priya','East'),
(3,'Amit','South'),
(4,'Neha','Central'),
(5,'Karan','West');

-- Products Data
INSERT INTO Products VALUES
(101,'Laptop','Technology','Computers'),
(102,'Chair','Furniture','Chairs'),
(103,'Printer','Technology','Machines'),
(104,'Table','Furniture','Tables'),
(105,'Paper','Office Supplies','Paper');

-- Orders Data
INSERT INTO Orders VALUES
(1001,'2024-01-05',1),
(1002,'2024-01-10',2),
(1003,'2024-02-15',3),
(1004,'2024-03-01',4),
(1005,'2024-03-12',5);

-- Order Details Data
INSERT INTO OrderDetails VALUES
(1,1001,101,65000,1,0.10,12000),
(2,1002,102,8000,2,0.05,1500),
(3,1003,103,15000,1,0.08,3000),
(4,1004,104,12000,1,0.07,2500),
(5,1005,105,5000,10,0.02,800);

-- Query 1
SELECT * FROM Customers;

-- Query 2
SELECT * FROM Products;

-- Query 3
SELECT
    c.CustomerName,
    p.ProductName,
    od.Sales,
    od.Profit
FROM OrderDetails od
JOIN Orders o
ON od.OrderID = o.OrderID
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Products p
ON od.ProductID = p.ProductID;

-- Query 4
SELECT
    p.Category,
    SUM(od.Sales) AS TotalSales,
    SUM(od.Profit) AS TotalProfit
FROM OrderDetails od
JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY p.Category;

-- Query 5
SELECT
    c.Region,
    SUM(od.Sales) AS TotalSales
FROM OrderDetails od
JOIN Orders o
ON od.OrderID = o.OrderID
JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.Region;