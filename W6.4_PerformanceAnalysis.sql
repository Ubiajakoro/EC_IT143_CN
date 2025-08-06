-- ==========================================
-- W6.4 Performance Analysis - Execution Plans and Indexing
-- Author: [Your Name]
-- Database: AdventureWorks
-- ==========================================

-- ==========================================
-- QUERY 1: Person.Person - MiddleName
-- ==========================================

-- Step 1: Original Query (Before Index)
SELECT FirstName, LastName, MiddleName
FROM Person.Person
WHERE MiddleName = 'A';

-- Step 2: Check if Index Exists, Then Create It
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_Person_MiddleName_Student'
    AND object_id = OBJECT_ID('Person.Person')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Person_MiddleName_Student
    ON Person.Person (MiddleName)
    INCLUDE (FirstName, LastName);
    PRINT 'Index IX_Person_MiddleName_Student created.';
END
ELSE
BEGIN
    PRINT 'Index IX_Person_MiddleName_Student already exists.';
END

-- Step 3: Query After Index Creation
SELECT FirstName, LastName, MiddleName
FROM Person.Person
WHERE MiddleName = 'A';

-- ==========================================
-- QUERY 2: Sales.SalesOrderHeader - CreditCardApprovalCode
-- ==========================================

-- Step 1: Original Query (Before Index)
SELECT SalesOrderID, CustomerID, CreditCardApprovalCode
FROM Sales.SalesOrderHeader
WHERE CreditCardApprovalCode = '105041Vi84182';

-- Step 2: Check if Index Exists, Then Create It
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_Sales_CreditCardApprovalCode_Student'
    AND object_id = OBJECT_ID('Sales.SalesOrderHeader')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Sales_CreditCardApprovalCode_Student
    ON Sales.SalesOrderHeader (CreditCardApprovalCode)
    INCLUDE (SalesOrderID, CustomerID);
    PRINT 'Index IX_Sales_CreditCardApprovalCode_Student created.';
END
ELSE
BEGIN
    PRINT 'Index IX_Sales_CreditCardApprovalCode_Student already exists.';
END

-- Step 3: Query After Index Creation
SELECT SalesOrderID, CustomerID, CreditCardApprovalCode
FROM Sales.SalesOrderHeader
WHERE CreditCardApprovalCode = '105041Vi84182';
