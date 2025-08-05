-- ==========================================
-- EC_IT143_6.3 - Scalar Functions and Trigger
-- Author: [Your Full Name]
-- ==========================================

-- DROP TABLE IF EXISTS
IF OBJECT_ID('dbo.t_w3_schools_customers', 'U') IS NOT NULL
    DROP TABLE dbo.t_w3_schools_customers;
GO

-- CREATE TABLE
CREATE TABLE dbo.t_w3_schools_customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    ContactName NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    PostalCode NVARCHAR(20),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100)
);
GO

-- DROP FUNCTION IF EXISTS
IF OBJECT_ID('dbo.fn_GetFirstName', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_GetFirstName;
GO

-- CREATE SCALAR FUNCTION: FirstName
CREATE FUNCTION dbo.fn_GetFirstName (@FullName NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN LEFT(@FullName, CHARINDEX(' ', @FullName + ' ') - 1)
END;
GO

-- DROP FUNCTION IF EXISTS
IF OBJECT_ID('dbo.fn_GetLastName', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_GetLastName;
GO

-- CREATE SCALAR FUNCTION: LastName
CREATE FUNCTION dbo.fn_GetLastName (@FullName NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN LTRIM(RIGHT(@FullName, LEN(@FullName) - CHARINDEX(' ', @FullName + ' ')))
END;
GO

-- DROP TRIGGER IF EXISTS
IF OBJECT_ID('dbo.trg_SplitContactName', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_SplitContactName;
GO

-- CREATE TRIGGER
CREATE TRIGGER dbo.trg_SplitContactName
ON dbo.t_w3_schools_customers
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET 
        FirstName = dbo.fn_GetFirstName(i.ContactName),
        LastName = dbo.fn_GetLastName(i.ContactName)
    FROM dbo.t_w3_schools_customers c
    INNER JOIN inserted i ON c.CustomerID = i.CustomerID;
END;
GO

-- INSERT SAMPLE DATA
INSERT INTO dbo.t_w3_schools_customers (CustomerName, ContactName, Address, City, PostalCode)
VALUES 
('Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209'),
('Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021'),
('Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023'),
('Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP'),
('Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22');
GO

-- VIEW FINAL OUTPUT
SELECT 
    CustomerID,
    CustomerName,
    ContactName,
    FirstName,
    LastName,
    Address,
    City,
    PostalCode
FROM dbo.t_w3_schools_customers;
GO
