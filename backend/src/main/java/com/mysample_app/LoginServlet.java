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
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        
        Gson gson = new Gson();
        LoginRequest loginRequest = gson.fromJson(request.getReader(), LoginRequest.class);
        
        Map<String, Object> responseMap = new HashMap<>();
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("=== LOGIN ATTEMPT ===");
            System.out.println("Email: " + loginRequest.getEmail());
            System.out.println("Password entered: '" + loginRequest.getPassword() + "'");
            System.out.println("Password length: " + loginRequest.getPassword().length());
            
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginRequest.getEmail());
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("User found in database!");
                String hashedPassword = rs.getString("password");
                System.out.println("Hash from DB starts with: " + hashedPassword.substring(0, Math.min(10, hashedPassword.length())));
                System.out.println("Hash length: " + hashedPassword.length());
                
                try {
                    boolean matches = BCrypt.checkpw(loginRequest.getPassword(), hashedPassword);
                    System.out.println("Password match result: " + matches);
                    
                    if (matches) {
                        responseMap.put("success", true);
                        responseMap.put("email", rs.getString("email"));
                        responseMap.put("message", "Login successful");
                        response.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        responseMap.put("success", false);
                        responseMap.put("message", "Invalid email or password");
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                } catch (Exception bcryptEx) {
                    System.err.println("BCrypt error: " + bcryptEx.getMessage());
                    bcryptEx.printStackTrace();
                    responseMap.put("success", false);
                    responseMap.put("message", "Password verification error: " + bcryptEx.getMessage());
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            } else {
                System.out.println("User NOT found in database!");
                responseMap.put("success", false);
                responseMap.put("message", "Invalid email or password");
                response.setStatus(HttpServletResponse.SC_OK);
            }
            
            response.getWriter().write(gson.toJson(responseMap));
        } catch (Exception e) {
            System.err.println("Database error: " + e.getMessage());
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

class LoginRequest {
    private String email;
    private String password;
    
    public String getEmail() { return email; }
    public String getPassword() { return password; }
}
