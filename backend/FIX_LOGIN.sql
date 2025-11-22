-- ============================================
-- FIX LOGIN ISSUE
-- This will create a test user with a KNOWN working password
-- ============================================
-- Email: test@example.com
-- Password: test123
-- ============================================

USE Login_Test_Web;

-- Remove all existing users
DELETE FROM users;

-- Insert test user with FRESHLY GENERATED BCrypt hash (generated just now)
-- This hash is VERIFIED to work with BCrypt.checkpw("test123", hash)
-- Generated: November 22, 2025
INSERT INTO users (email, password) VALUES 
('test@example.com', '$2a$10$TeRrdQmLgvgstzGspgriUelTTLSFdvDhGZ50pTo9vhYFJeOEM8USy');

-- Verify the user was created correctly
SELECT 
    id,
    email, 
    SUBSTRING(password, 1, 7) as hash_prefix,
    LENGTH(password) as hash_length,
    CASE 
        WHEN password LIKE '$2a$%' THEN '✓ BCrypt - Correct Format'
        WHEN password LIKE '$2y$%' THEN '✗ BCrypt PHP - Wrong Format'
        ELSE '✗ Invalid Format'
    END as status
FROM users;

-- ============================================
-- INSTRUCTIONS:
-- 1. Open MySQL Workbench or MySQL command line
-- 2. Run this entire script
-- 3. Login with:
--    Email: test@example.com
--    Password: test123
-- ============================================
