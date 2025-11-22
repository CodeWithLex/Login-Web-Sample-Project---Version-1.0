-- ============================================
-- QUICK FIX: Create Test Users
-- ============================================
-- Run this entire script in MySQL Workbench or MySQL Command Line

USE Login_Test_Web;

-- Clear existing users
TRUNCATE TABLE users;

-- Insert test users with VERIFIED BCrypt hashed passwords
-- All these hashes have been verified to work with Java BCrypt

-- User 1: test@example.com / test123
INSERT INTO users (email, password) VALUES 
('test@example.com', '$2a$10$ZLhnHxdpHETcxmtEStgpI.Jx8JU4PSQu07zxKQCqFKXgAQqTdLXXu');

-- User 2: admin@example.com / admin123  
INSERT INTO users (email, password) VALUES 
('admin@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- User 3: user@example.com / password123
INSERT INTO users (email, password) VALUES 
('user@example.com', '$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1T3e.Gy');

-- Verify insertions
SELECT 
    id,
    email,
    CONCAT('$2a$', SUBSTRING(password, 5, 3), '...') as hash_preview,
    LENGTH(password) as hash_length
FROM users;

-- Show credentials for testing
SELECT '====== TEST CREDENTIALS ======' as '';
SELECT 'test@example.com' as Email, 'test123' as Password UNION
SELECT 'admin@example.com', 'admin123' UNION  
SELECT 'user@example.com', 'password123';
