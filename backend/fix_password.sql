-- Fix the password hash for test user
-- This will set the password to: test123
-- BCrypt hash generated with salt rounds = 10

USE Login_Test_Web;

-- First, check if the database exists
CREATE DATABASE IF NOT EXISTS Login_Test_Web;
USE Login_Test_Web;

-- Create the users table if it doesn't exist
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Delete existing test user if exists
DELETE FROM users WHERE email = 'test@example.com';

-- Insert with properly BCrypt hashed password (password: test123)
-- This hash was verified to work with BCrypt.checkpw()
INSERT INTO users (email, password) VALUES 
('test@example.com', '$2a$10$ZLhnHxdpHETcxmtEStgpI.Jx8JU4PSQu07zxKQCqFKXgAQqTdLXXu');

-- Verify the insertion
SELECT 
    id,
    email, 
    LEFT(password, 7) as hash_prefix,
    LENGTH(password) as hash_length 
FROM users 
WHERE email = 'test@example.com';

-- Show all users
SELECT email, LEFT(password, 30) as password_hash FROM users;
