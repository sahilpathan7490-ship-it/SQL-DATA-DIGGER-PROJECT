CREATE DATABASE DATADIGGER;
USE   DATADIGGER ;
CREATE TABLE CUSTOMERS( CUSTOMERID INT PRIMARY KEY, NAME VARCHAR(30),EMAIL  VARCHAR(100), ADDRESS VARCHAR(100));
INSERT INTO CUSTOMERS VALUES
                           (1,"SAHIL","SAHIL546@GMAIL.COM","SURAT") ,
                           (2,"SAMIR","SAMIR123@GMAIL.COM", "SURAT") ,
                           (3,"YASMIN","YASMIN456@GMAIL.COM","PUNE"),
                           (4,"zoya","zoyakhan456@gmail.com","satna"),
                           (5,"lubhna","lubhna789@gmail.com","katni");
--  2 retrive all customers
select*from customers;  

-- 3  UPDATE CUSTOMER ADDRESS
UPDATE Customers
SET Address = 'SURAT'
WHERE CustomerID = 3;
                    
-- 4 DELETE CUSTOMER USING CUSTOMERID
DELETE FROM Customers
WHERE CustomerID = 5;

-- 5 DISPLAY ALL CUSTOMERS WHOSE NAME IS SAHIL
SELECT * FROM CUSTOMERS WHERE NAME="SAHIL";

------------------------------------------------------------------------------------------------------------------------
-- 2. ORDERS TABLE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 1 INSERT 5 SAMPLE ORDERS
INSERT INTO Orders VALUES
(101, 1, '2026-05-01', 1500.00),
(102, 2, '2026-05-05', 2500.00),
(103, 3, '2026-05-10', 3200.00),
(104, 1, '2026-05-15', 1800.00),
(105, 4, '2026-05-20', 4500.00);
-- 2 RETRIVE ALL ORDERS MADE BY SPECIFIC CUSTOMERS
SELECT * FROM  ORDERS WHERE CUSTOMERID =1;

-- 3 UPDATE ORDER TOTAL AMOUNT
UPDATE Orders
SET TotalAmount = 1000.00
WHERE OrderID = 104;

-- 4 DELETE ORDER USING ORDERID
DELETE FROM Orders
WHERE OrderID = 102;

-- 5 RETRIEVE ORDERS IN LAST 30 DAYS
SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

-- 6 HIGHEST, LOWEST, AVERAGE ORDER AMOUNT
SELECT 
MAX(TotalAmount) AS Highest_Order,
MIN(TotalAmount) AS Lowest_Order,
AVG(TotalAmount) AS Average_Order
FROM Orders,CUSTOMERS;

------------------------------------------------------------------------------------------------------------------
--- 3 PRODUCT TABLE 
CREATE TABLE PRODUCTS (productID INT primary key , productname varchar (100) ,price decimal (10,2), stock  INT);
-- 1 INSERT 5 SAMPLE PRODUCTS
INSERT INTO Products VALUES
(201, 'Laptop', 55000, 10),
(202, 'Mouse', 700, 50),
(203, 'Keyboard', 1500, 25),
(204, 'Headphones', 2500, 0),
(205, 'Monitor', 12000, 8);
-- 2 retrive all products in desc order
select * from products order by price desc;
-- 3 update a price of specific product 
update products  set  price = 18000 where productID = 203;
-- 4 delete product if out of stock
SET SQL_SAFE_UPDATES = 0;
DELETE FROM products WHERE stock = 0;
SET SQL_SAFE_UPDATES = 1;
-- 5 product between 500 and 2000
select * from products where price between 500 and 2000;
-- 6 product most expensive and  cheapest 
SELECT
    MAX(price) AS expensive,
    MIN(price) AS cheapest
FROM products;
-
---------------------------------------------------------------------------
---- 4 ORDERDETAILS TABLE
create table orderdetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 1 INSERT 5 SAMPLE RECORDS
INSERT INTO OrderDetails VALUES
(1, 101, 201, 1, 55000),
(2, 101, 202, 2, 1400),
(3, 103, 203, 1, 1800),
(4, 104, 205, 1, 12000),
(5, 105, 202, 3, 2100);
-- 2 retrive all order details with specific order
select * from orderdetails where orderID = 103;

-- 3 TOTAL REVENUE FROM ALL ORDERS
SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;

-- TOP 3 MOST ORDERED PRODUCTS
SELECT ProductID, SUM(Quantity) AS Total_Ordered
FROM OrderDetails
GROUP BY ProductID
ORDER BY Total_Ordered DESC
LIMIT 3;

-- COUNT HOW MANY TIMES A PRODUCT WAS SOLD
SELECT ProductID, COUNT(*) AS Times_Sold
FROM OrderDetails
WHERE ProductID = 202
GROUP BY ProductID;

