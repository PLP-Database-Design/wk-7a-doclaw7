-- Step 1: Create denormalized table
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Step 2: Insert original data
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Achieving The 1st Normal Form (1NF)
CREATE TABLE OrderDetails_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Inserting data for OrderID 101
INSERT INTO OrderDetails_1NF VALUES (101, 'John Doe', 'Laptop');
INSERT INTO OrderDetails_1NF VALUES (101, 'John Doe', 'Mouse');

-- Inserting data for OrderID 102
INSERT INTO OrderDetails_1NF VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO OrderDetails_1NF VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO OrderDetails_1NF VALUES (102, 'Jane Smith', 'Mouse');

-- Inserting data for OrderID 103
INSERT INTO OrderDetails_1NF VALUES (103, 'Emily Clark', 'Phone');

-- Quetion 2: Achieving The 2nd Normal Form (2NF)

-- Step 1: Create denormalized table

-- Step 1: Create original (1NF) OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

-- Step 2: Insert sample data
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 3: Create Orders table (to remove partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 4: Populate Orders table with unique order-customer pairs
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 5: Create OrderItems table for products and quantities
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 6: Populate OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

