package com.mysample_app;

import org.mindrot.jbcrypt.BCrypt;

public class GenerateTestHash {
    public static void main(String[] args) {
        String password = "test123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(10));
        
        System.out.println("==========================================");
        System.out.println("Password: " + password);
        System.out.println("Hash: " + hash);
        System.out.println("==========================================");
        System.out.println("SQL:");
        System.out.println("USE Login_Test_Web;");
        System.out.println("DELETE FROM users;");
        System.out.println("INSERT INTO users (email, password) VALUES");
        System.out.println("('test@example.com', '" + hash + "');");
        System.out.println("==========================================");
        
        // Verify it works
        boolean test = BCrypt.checkpw(password, hash);
        System.out.println("Verification: " + (test ? "SUCCESS ✓" : "FAILED ✗"));
    }
}
