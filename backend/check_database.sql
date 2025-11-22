-- Check database and users
USE Login_Test_Web;

-- Show all users
SELECT 
    id,
    email,
    SUBSTRING(password, 1, 10) as password_start,
    LENGTH(password) as password_length,
    CASE 
        WHEN password LIKE '$2a$%' THEN 'BCrypt (Java compatible)'
        WHEN password LIKE '$2y$%' THEN 'BCrypt (PHP - NOT compatible with Java)'
        WHEN LENGTH(password) < 50 THEN 'NOT HASHED (Plain text or MD5)'
        ELSE 'Unknown format'
    END as password_format
FROM users;

-- Count users
SELECT COUNT(*) as total_users FROM users;
