import org.mindrot.jbcrypt.BCrypt;

public class QuickPasswordTest {
    public static void main(String[] args) {
        // The hash from FIX_LOGIN.sql
        String storedHash = "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1T3e.Gy";
        
        // Test passwords
        String[] testPasswords = {
            "test123",
            "Test123",
            "test123 ",
            " test123",
            "test1234"
        };
        
        System.out.println("============================================");
        System.out.println("PASSWORD VERIFICATION TEST");
        System.out.println("============================================");
        System.out.println("Testing against hash: " + storedHash.substring(0, 20) + "...");
        System.out.println();
        
        for (String pwd : testPasswords) {
            System.out.println("Testing: '" + pwd + "' (length: " + pwd.length() + ")");
            try {
                boolean matches = BCrypt.checkpw(pwd, storedHash);
                System.out.println("Result: " + (matches ? "✓ MATCH" : "✗ NO MATCH"));
            } catch (Exception e) {
                System.out.println("Result: ERROR - " + e.getMessage());
            }
            System.out.println();
        }
        
        System.out.println("============================================");
        System.out.println("If none match, there may be an issue with:");
        System.out.println("1. The password you're typing");
        System.out.println("2. The hash in your database");
        System.out.println("3. Extra spaces or hidden characters");
        System.out.println("============================================");
    }
}
