-- Check all tables exist
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'

-- Check books were inserted
SELECT COUNT(*) AS TotalBooks FROM Books

-- Check users were inserted  
SELECT COUNT(*) AS TotalUsers FROM Users

-- Check stored procedures exist
SELECT NAME 
FROM sys.procedures
ORDER BY NAME