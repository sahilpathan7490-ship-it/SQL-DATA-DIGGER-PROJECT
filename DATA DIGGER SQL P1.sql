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

