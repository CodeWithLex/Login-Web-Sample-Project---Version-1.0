package com.mysample_app;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHashGenerator {
    public static void main(String[] args) {
        System.out.println("==============================================");
        System.out.println("   BCrypt Password Hash Generator");
        System.out.println("==============================================\n");
        
        // Generate hash for password: test123
        String password = "test123";
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(10));
        
        System.out.println("Plain Text Password: " + password);
        System.out.println("BCrypt Hash Length: " + hashedPassword.length() + " characters");
        System.out.println("BCrypt Hash: " + hashedPassword);
        System.out.println("\n----------------------------------------------");
        System.out.println("SQL Statement to Insert User:");
        System.out.println("----------------------------------------------");
        System.out.println("USE Login_Test_Web;");
        System.out.println("DELETE FROM users WHERE email = 'test@example.com';");
        System.out.println("INSERT INTO users (email, password) VALUES");
        System.out.println("('test@example.com', '" + hashedPassword + "');");
        System.out.println("----------------------------------------------\n");
        
        // Test verification
        boolean matches = BCrypt.checkpw(password, hashedPassword);
        System.out.println("Hash Verification Test: " + (matches ? "✓ SUCCESS" : "✗ FAILED"));
        
        // Generate a few more examples
        System.out.println("\n==============================================");
        System.out.println("   Additional Test Users");
        System.out.println("==============================================\n");
        
        String[] testPasswords = {"password123", "admin123"};
        String[] testEmails = {"user@example.com", "admin@example.com"};
        
        for (int i = 0; i < testPasswords.length; i++) {
            String hash = BCrypt.hashpw(testPasswords[i], BCrypt.gensalt(10));
            System.out.println("Email: " + testEmails[i]);
            System.out.println("Password: " + testPasswords[i]);
            System.out.println("Hash: " + hash);
            System.out.println();
        }
        
        System.out.println("==============================================");
        System.out.println("Copy the SQL statements above and run them");
        System.out.println("in MySQL Workbench to create test users.");
        System.out.println("==============================================");
    }
}
