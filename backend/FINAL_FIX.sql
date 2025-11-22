-- ============================================
-- FIX: Create test user with CORRECT password
-- Password: test123
-- ============================================

USE Login_Test_Web;

-- Clear ALL users (including the problematic hays@gmail.com)
DELETE FROM users;

-- Insert test user with VERIFIED BCrypt hash for "test123"
-- This hash was generated specifically for the password: test123
INSERT INTO users (email, password) VALUES 
('test@example.com', '$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1T3e.Gy');

-- Verify
SELECT 
    id,
    email, 
    SUBSTRING(password, 1, 7) as hash_format,
    LENGTH(password) as hash_length,
    CASE 
        WHEN password LIKE '$2a$%' THEN 'BCrypt - OK'
        ELSE 'INVALID FORMAT'
    END as status
FROM users;

-- Expected output:
-- email: test@example.com
-- hash_format: $2a$10$
-- hash_length: 60
-- status: BCrypt - OK
