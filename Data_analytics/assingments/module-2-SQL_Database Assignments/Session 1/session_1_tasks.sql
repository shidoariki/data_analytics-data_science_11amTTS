-- =============================================================================
-- SESSION 1: Introduction to Databases & Installation
-- Assignment SQL Solutions
-- Target Folder: D:\DA\Data_analytics\assingments\Session 1
-- =============================================================================

-- -----------------------------------------------------------------------------
-- DEMO REQUIREMENT:
-- Create database analytics_db
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS analytics_db;

-- -----------------------------------------------------------------------------
-- TASK 2:
-- Open MySQL Workbench or DB Browser, connect to your local MySQL server,
-- and create a new database called music_streaming_db.
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS music_streaming_db;

-- -----------------------------------------------------------------------------
-- TASK 3:
-- Write the SQL command to create a new database named food_delivery_db
-- and execute it in your SQL Workbench or DB Browser.
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS food_delivery_db;

-- -----------------------------------------------------------------------------
-- VERIFICATION:
-- List all databases to verify that analytics_db, music_streaming_db,
-- and food_delivery_db have been successfully created.
-- -----------------------------------------------------------------------------
SHOW DATABASES;
