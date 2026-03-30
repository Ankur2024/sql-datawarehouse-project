-- Create the main database
CREATE DATABASE DatawarehouseProject;

-- NOTE: PostgreSQL does not support `USE`
-- Connect to the database manually (via pgAdmin or psql)

-- Verify current connection
SELECT current_database();

-- Create schemas for data warehouse layers
CREATE SCHEMA IF NOT EXISTS bronze;  -- raw data
CREATE SCHEMA IF NOT EXISTS silver;  -- cleaned/transformed data
CREATE SCHEMA IF NOT EXISTS gold;    -- final/analytics-ready data
