-- EC_IT143_W6.2_AdventureWorks_CindyItohan.sql
-- Author: Cindy Itohan
-- Final Project: My Communities Analysis – AdventureWorks Dataset
-- Description: 8 SQL queries analyzing SalesOrderHeader data from the Sales schema

-- STEP 1: USE the correct database
USE AdventureWorks2022;
GO

-- Query 1: Total number of orders in the dataset
SELECT COUNT(*) AS TotalOrders
FROM Sales.SalesOrderHeader;
GO

-- Query 2: Total revenue from all sales
SELECT SUM(TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader;
GO

-- Query 3: Number of orders placed each year
SELECT YEAR(OrderDate) AS OrderYear, COUNT(*) AS OrdersPerYear
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
GO

-- Query 4: Top 5 customers by total purchase amount
SELECT TOP 5 CustomerID, SUM(TotalDue) AS TotalSpent
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
GO

-- Query 5: Average order value per customer
SELECT CustomerID, AVG(TotalDue) AS AverageOrderValue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY AverageOrderValue DESC;
GO

-- Query 6: Orders with the highest due amounts (Top 10)
SELECT TOP 10 SalesOrderID, CustomerID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;
GO

-- Query 7: Orders shipped late (ShipDate > DueDate)
SELECT SalesOrderID, OrderDate, DueDate, ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate > DueDate;
GO

-- Query 8: Monthly revenue trend
SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(TotalDue) AS MonthlyRevenue
FROM Sales.SalesOrderHeader
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY OrderMonth;
GO
