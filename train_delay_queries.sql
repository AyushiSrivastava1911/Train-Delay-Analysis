-- ===================================================
-- 🚆 TRAIN DELAY ANALYSIS PROJECT - SQL SCRIPT
-- Database: train_project
-- Table: train_delay
-- ===================================================


CREATE DATABASE train_project;
USE train_project;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
CREATE TABLE train_delay (
    Distance_km INT,
    Weather VARCHAR(50),
    DayOfWeek VARCHAR(20),
    TimeOfDay VARCHAR(20),
    TrainType VARCHAR(20),
    Delay INT,
    Congestion VARCHAR(20)
);
LOAD DATA LOCAL INFILE 'C:\\Users\\ayush\\Downloads\\train_delay_cleaned.csv'
INTO TABLE train_delay
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Distance_km, Weather, DayOfWeek, TimeOfDay, TrainType, Delay, Congestion);

-- ===================================================
-- 🔹 1. Quick Data Check
-- ===================================================
SELECT COUNT(*) FROM train_delay;
SELECT * FROM train_delay LIMIT 10;

-- ===================================================
-- 🔹 2. Average Delay by Weather Condition
-- ===================================================
SELECT Weather, AVG(Delay) AS AvgDelay
FROM train_delay
GROUP BY Weather
ORDER BY AvgDelay DESC;

-- ===================================================
-- 🔹 3. Average Delay by Train Type
-- ===================================================
SELECT TrainType, AVG(Delay) AS AvgDelay
FROM train_delay
GROUP BY TrainType
ORDER BY AvgDelay DESC;

-- ===================================================
-- 🔹 4. Trains Delayed due to Weather
-- ===================================================
SELECT Weather, COUNT(*) AS TrainsDelayed
FROM train_delay
WHERE Delay > 0
GROUP BY Weather
ORDER BY TrainsDelayed DESC;

-- ===================================================
-- 🔹 5. Best Time to Travel (Least Delay)
-- ===================================================
SELECT TimeOfDay, AVG(Delay) AS AvgDelay
FROM train_delay
GROUP BY TimeOfDay
ORDER BY AvgDelay ASC
LIMIT 1;

-- ===================================================
-- 🔹 6. Worst Day × Time Combination (Top 5)
-- ===================================================
SELECT DayOfWeek, TimeOfDay, AVG(Delay) AS AvgDelay
FROM train_delay
GROUP BY DayOfWeek, TimeOfDay
ORDER BY AvgDelay DESC
LIMIT 5;

-- ===================================================
-- 🚆 END OF SCRIPT
-- ===================================================