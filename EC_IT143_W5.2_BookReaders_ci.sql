-- EC_IT143_W5.2_BookReaders_ci.sql
-- Author: Your Name (Initials: ci)
-- BookReaders Community - Final Project Script (4 Questions & Answers)

-- STEP 1: Create a clean table
DROP TABLE IF EXISTS BookReaders;
CREATE TABLE BookReaders (
    ReaderID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    FavoriteGenre VARCHAR(50),
    NumberOfBooksRead INT,
    Rating INT
);

-- STEP 2: Insert dummy data
INSERT INTO BookReaders VALUES
(1, 'Alice', 25, 'Female', 'Fiction', 10, 5),
(2, 'Bob', 30, 'Male', 'Fantasy', 5, 4),
(3, 'Chioma', 35, 'Female', 'Mystery', 12, 3),
(4, 'David', 22, 'Male', 'Sci-Fi', 2, 2);

-- Q1: What is the average number of books read?
SELECT AVG(NumberOfBooksRead) AS AvgBooksRead FROM BookReaders;

-- Q2: What genre is most popular?
SELECT TOP 1 FavoriteGenre, COUNT(*) AS GenreCount
FROM BookReaders
GROUP BY FavoriteGenre
ORDER BY GenreCount DESC;

-- Q3: How many readers rated books above 3?
SELECT COUNT(*) AS HighRatingReaders
FROM BookReaders
WHERE Rating > 3;

-- Q4: How many male and female readers are there?
SELECT Gender, COUNT(*) AS CountByGender
FROM BookReaders
GROUP BY Gender;
