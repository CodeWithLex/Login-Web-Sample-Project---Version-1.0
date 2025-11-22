package com.mysample_app;

import com.google.gson.Gson;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/api/register")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        
        Gson gson = new Gson();
        RegisterRequest registerRequest = gson.fromJson(request.getReader(), RegisterRequest.class);
        
        java.util.Map<String, Object> responseMap = new java.util.HashMap<>();
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("=== REGISTRATION ATTEMPT ===");
            System.out.println("Email: " + registerRequest.getEmail());
            
            // Check if user already exists
            String checkSql = "SELECT COUNT(*) FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, registerRequest.getEmail());
            java.sql.ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("User already exists!");
                responseMap.put("success", false);
                responseMap.put("message", "Email already registered");
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            }
            
            // Hash password and insert new user
            String hashedPassword = BCrypt.hashpw(registerRequest.getPassword(), BCrypt.gensalt());
            System.out.println("Password hashed successfully");
            
            String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, registerRequest.getEmail());
            stmt.setString(2, hashedPassword);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("User registered successfully!");
                responseMap.put("success", true);
                responseMap.put("message", "User registered successfully");
                responseMap.put("email", registerRequest.getEmail());
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                System.err.println("Failed to insert user");
                responseMap.put("success", false);
                responseMap.put("message", "Failed to register user");
                response.setStatus(HttpServletResponse.SC_OK);
            }
            
            response.getWriter().write(gson.toJson(responseMap));
        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            e.printStackTrace();
            responseMap.put("success", false);
            responseMap.put("message", "Server error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(responseMap));
        }
    }
    
    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }
}

class RegisterRequest {
    private String email;
    private String password;
    
    public String getEmail() { return email; }
    public String getPassword() { return password; }
}
