import org.mindrot.jbcrypt.BCrypt;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class CreateUser {
    public static void main(String[] args) {
        String email = "test@example.com";
        String password = "test123";
        
        // Generate hash
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(10));
        
        System.out.println("Creating user...");
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        System.out.println("Hash: " + hash);
        
        // Test the hash immediately
        boolean testMatch = BCrypt.checkpw(password, hash);
        System.out.println("Immediate verification: " + (testMatch ? "SUCCESS" : "FAILED"));
        
        // Insert into database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Login_Test_Web", 
                "root", 
                "root"
            );
            
            // Delete existing user
            PreparedStatement delete = conn.prepareStatement("DELETE FROM users WHERE email = ?");
            delete.setString(1, email);
            int deleted = delete.executeUpdate();
            System.out.println("\nDeleted " + deleted + " existing user(s)");
            
            // Insert new user
            PreparedStatement insert = conn.prepareStatement(
                "INSERT INTO users (email, password) VALUES (?, ?)"
            );
            insert.setString(1, email);
            insert.setString(2, hash);
            insert.executeUpdate();
            
            System.out.println("User created successfully!");
            System.out.println("\n===========================================");
            System.out.println("You can now login with:");
            System.out.println("Email: " + email);
            System.out.println("Password: " + password);
            System.out.println("===========================================");
            
            conn.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
