/*
File: EC_IT143_W3.4_ci.sql
Author: Cindy Itohan
Date: 2025-07-16
Assignment: W3.4 AdventureWorks — Create Answers
Estimated Runtime: 1 minute
Description: SQL statements to answer user questions using the AdventureWorks sample database.
*/

USE AdventureWorks2022;
GO

-- =====================================
-- Q1: What is the list price of the most expensive product?
-- Category: Business User – Marginal
-- Submitted by: Cindy Itohan
-- =====================================
SELECT MAX(ListPrice) AS MostExpensiveProductPrice
FROM Production.Product;
GO

-- =====================================
-- Q2: Which employee has the highest number of vacation hours?
-- Category: Business User – Marginal
-- Submitted by: Cindy Itohan
-- =====================================
SELECT TOP 1 P.FirstName, P.LastName, E.VacationHours
FROM HumanResources.Employee AS E
JOIN Person.Person AS P ON E.BusinessEntityID = P.BusinessEntityID
ORDER BY E.VacationHours DESC;
GO

-- =====================================
-- Q3: Which three employees placed the most orders in 2014? Show their names and total orders.
-- Category: Business User – Moderate
-- Submitted by: Cindy Itohan
-- =====================================
SELECT TOP 3 P.FirstName, P.LastName, COUNT(SOH.SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.SalesPerson AS SP ON SOH.SalesPersonID = SP.BusinessEntityID
JOIN HumanResources.Employee AS E ON SP.BusinessEntityID = E.BusinessEntityID
JOIN Person.Person AS P ON E.BusinessEntityID = P.BusinessEntityID
WHERE YEAR(SOH.OrderDate) = 2014
GROUP BY P.FirstName, P.LastName
ORDER BY TotalOrders DESC;
GO

-- =====================================
-- Q4: How many distinct products do we sell in each product category?
-- Category: Business User – Moderate
-- Submitted by: Cindy Itohan
-- =====================================
SELECT PC.Name AS CategoryName, COUNT(DISTINCT P.ProductID) AS ProductCount
FROM Production.Product AS P
JOIN Production.ProductSubcategory AS PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN Production.ProductCategory AS PC ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name;
GO

-- =====================================
-- Q5: Road bikes sold between July and September 2011: models, quantity sold, and total revenue.
-- Category: Business User – Increased
-- Submitted by: Cindy Itohan
-- =====================================
SELECT P.Name AS Model, SUM(SOD.OrderQty) AS QuantitySold, SUM(SOD.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
WHERE P.Name LIKE '%Road%'
  AND SOH.OrderDate BETWEEN '2011-07-01' AND '2011-09-30'
GROUP BY P.Name
ORDER BY TotalRevenue DESC;
GO

-- =====================================
-- Q6: Repeat customers with >5 purchases and total spend >$2,000. Provide their names and total spent.
-- Category: Business User – Increased
-- Submitted by: Cindy Itohan
-- =====================================
SELECT C.CustomerID, P.FirstName, P.LastName, COUNT(SOH.SalesOrderID) AS TotalPurchases, SUM(SOH.TotalDue) AS TotalSpent
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.Customer AS C ON SOH.CustomerID = C.CustomerID
JOIN Person.Person AS P ON C.PersonID = P.BusinessEntityID
GROUP BY C.CustomerID, P.FirstName, P.LastName
HAVING COUNT(SOH.SalesOrderID) > 5 AND SUM(SOH.TotalDue) > 2000
ORDER BY TotalSpent DESC;
GO

-- =====================================
-- Q7: What are the names and data types of all columns in the Sales.SalesOrderHeader table?
-- Category: Metadata
-- Submitted by: Cindy Itohan
-- =====================================
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Sales'
  AND TABLE_NAME = 'SalesOrderHeader';
GO

-- =====================================
-- Q8: Which tables in the database include a column named ‘ProductSubcategoryID’?
-- Category: Metadata
-- Submitted by: Cindy Itohan
-- =====================================
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductSubcategoryID';
GO
