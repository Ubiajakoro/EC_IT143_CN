-- EC_IT143_W5.2_BusinessOwners_ci.sql
-- Author: Your Name (Initials: ci)
-- BusinessOwners Community - Final Project Script (4 Questions & Answers)

-- STEP 1: Create a clean table
DROP TABLE IF EXISTS BusinessOwners;
CREATE TABLE BusinessOwners (
    OwnerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    BusinessType VARCHAR(100),
    YearsInBusiness INT,
    MonthlyRevenue DECIMAL(10,2)
);

-- STEP 2: Insert dummy data
INSERT INTO BusinessOwners VALUES
(1, 'Tunde', 40, 'Male', 'Retail', 5, 2000.00),
(2, 'Ngozi', 35, 'Female', 'Salon', 7, 3200.00),
(3, 'John', 29, 'Male', 'Tech', 2, 4500.00),
(4, 'Amaka', 45, 'Female', 'Food', 10, 5000.00);

-- Q1: What is the average monthly revenue?
SELECT AVG(MonthlyRevenue) AS AvgRevenue FROM BusinessOwners;

-- Q2: What is the most common type of business?
SELECT TOP 1 BusinessType, COUNT(*) AS CountByType
FROM BusinessOwners
GROUP BY BusinessType
ORDER BY CountByType DESC;

-- Q3: How many owners have been in business more than 5 years?
SELECT COUNT(*) AS ExperiencedOwners
FROM BusinessOwners
WHERE YearsInBusiness > 5;

-- Q4: What is the total revenue by gender?
SELECT Gender, SUM(MonthlyRevenue) AS TotalRevenue
FROM BusinessOwners
GROUP BY Gender;
