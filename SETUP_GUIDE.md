# 🚀 Complete Setup Guide - Sample Login Project

This guide will walk you through setting up the entire project from scratch.

---

## 📋 Prerequisites Checklist

Before starting, ensure you have:

### ✅ Software Requirements

| Software | Version | Download Link | Verification Command |
|----------|---------|---------------|---------------------|
| Java JDK | 21+ | [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) | `java -version` |
| Apache Maven | 3.6+ | [Maven](https://maven.apache.org/download.cgi) | `mvn -version` |
| MySQL Server | 8.0+ | [MySQL](https://dev.mysql.com/downloads/mysql/) | `mysql --version` |
| Git | Latest | [Git](https://git-scm.com/downloads) | `git --version` |

### ✅ System Requirements
- Windows 10/11 (or macOS/Linux with minor adjustments)
- 4GB RAM minimum (8GB recommended)
- 500MB free disk space
- Internet connection (for Maven dependencies)

---

## 🔧 Step-by-Step Setup

### Step 1: Verify Java Installation

```powershell
# Check Java version
java -version

# Should show: java version "21" or higher
# If not installed:
# 1. Download JDK 21 from Oracle
# 2. Install with default settings
# 3. Add to PATH: C:\Program Files\Java\jdk-21\bin
# 4. Restart terminal and verify
```

### Step 2: Verify Maven Installation

```powershell
# Check Maven version
mvn -version

# Should show: Apache Maven 3.x.x
# If not installed:
# 1. Download Maven from Apache
# 2. Extract to C:\Program Files\Apache\maven
# 3. Add to PATH: C:\Program Files\Apache\maven\bin
# 4. Set M2_HOME: C:\Program Files\Apache\maven
# 5. Restart terminal and verify
```

### Step 3: Install and Configure MySQL

```powershell
# Check if MySQL is running
Get-Service MySQL* | Select-Object Status,Name

# If not running:
net start MySQL80

# Login to MySQL
mysql -u root -p
# Enter your password when prompted
```

**If MySQL is not installed:**

1. Download MySQL Installer from MySQL website
2. Run installer and select "Developer Default"
3. Set root password (remember this!)
4. Complete installation
5. Verify service is running

### Step 4: Create Database and Tables

```sql
-- Login to MySQL
mysql -u root -p

-- Create database
CREATE DATABASE Login_Test_Web;

-- Use the database
USE Login_Test_Web;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Verify table creation
DESCRIBE users;

-- Expected output:
-- +------------+--------------+------+-----+-------------------+
-- | Field      | Type         | Null | Key | Default           |
-- +------------+--------------+------+-----+-------------------+
-- | id         | int          | NO   | PRI | NULL              |
-- | email      | varchar(255) | NO   | UNI | NULL              |
-- | password   | varchar(255) | NO   |     | NULL              |
-- | created_at | timestamp    | YES  |     | CURRENT_TIMESTAMP |
-- +------------+--------------+------+-----+-------------------+
```

### Step 5: Create Test User

```sql
-- Still in MySQL, run:

-- Insert test user (email: test@example.com, password: test123)
INSERT INTO users (email, password) VALUES 
('test@example.com', '$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1T3e.Gy');

-- Verify insertion
SELECT id, email, SUBSTRING(password, 1, 7) as hash_format FROM users;

-- Expected output:
-- +----+------------------+-------------+
-- | id | email            | hash_format |
-- +----+------------------+-------------+
-- |  1 | test@example.com | $2a$10$     |
-- +----+------------------+-------------+

-- Exit MySQL
EXIT;
```

### Step 6: Configure Database Connection

1. Open `backend/src/main/java/com/mysample_app/DatabaseConnection.java`
2. Update with your MySQL credentials:

```java
private static final String URL = "jdbc:mysql://localhost:3306/Login_Test_Web";
private static final String USER = "root";          // Your MySQL username
private static final String PASSWORD = "root";      // Your MySQL password (change this!)
```

3. Save the file

### Step 7: Install Project Dependencies

```powershell
# Navigate to backend directory
cd "backend"

# Clean any previous builds
mvn clean

# Install dependencies
mvn install

# Expected output at end:
# [INFO] BUILD SUCCESS
# [INFO] Total time: X.XXX s
```

**If you see BUILD FAILURE:**
- Check internet connection (Maven downloads dependencies)
- Verify Maven settings.xml is correct
- Check Java version is 21+
- Review error messages carefully

### Step 8: Build the Project

```powershell
# Still in backend directory
mvn clean package

# This creates: target/login-backend.war
# Verify the WAR file exists:
ls target/login-backend.war
```

### Step 9: Start the Server

**Method A: Using Batch Script (Recommended)**
```powershell
# From project root
.\EMERGENCY_START.bat
```

**Method B: Using Maven**
```powershell
# From backend directory
mvn tomcat7:run
```

**Method C: Using PowerShell Script**
```powershell
# From project root
.\START_SERVER_NEW.ps1
```

**Wait for this message:**
```
[INFO] Starting ProtocolHandler ["http-bio-8081"]
```

### Step 10: Test the Backend

```powershell
# Open a new terminal (keep server running)

# Test OPTIONS request (CORS preflight)
Invoke-WebRequest -Uri http://localhost:8081/login-backend/api/login -Method OPTIONS

# Should return: StatusCode: 200

# Or using curl:
curl -X OPTIONS http://localhost:8081/login-backend/api/login
```

### Step 11: Open the Frontend

1. Navigate to `frontend/Version 1.0/` folder
2. Right-click `index.html`
3. Choose "Open with" → Your browser (Chrome, Firefox, Edge)
4. Or simply double-click `index.html`

**Important:** Use `http://` not `file://` protocol for proper API calls

### Step 12: Test Login

1. In the browser, you should see the login page
2. Enter test credentials:
   - Email: `test@example.com`
   - Password: `test123`
3. Click "Sign in"
4. You should be redirected to the dashboard

**If login fails:**
- Check browser console (F12) for errors
- Verify server is running (check terminal)
- Check MySQL is running
- Verify test user exists in database

### Step 13: Test Registration

1. Click "Create account" on login page
2. Enter new credentials:
   - Email: `your@email.com`
   - Password: `yourpassword` (minimum 6 characters)
   - Confirm password: `yourpassword`
3. Click "Create Account"
4. You should be redirected to login page
5. Login with new credentials

---

## ✅ Verification Checklist

After setup, verify everything works:

- [ ] Java version shows 21+
- [ ] Maven version shows 3.6+
- [ ] MySQL service is running
- [ ] Database `Login_Test_Web` exists
- [ ] `users` table exists with correct schema
- [ ] Test user exists in database
- [ ] Database credentials configured in code
- [ ] Maven dependencies installed successfully
- [ ] Project builds without errors
- [ ] Server starts and shows "Starting ProtocolHandler"
- [ ] Port 8081 is accessible
- [ ] Login page loads in browser
- [ ] Test login succeeds
- [ ] Registration page works
- [ ] Can create new account
- [ ] Dashboard loads after login

---

## 🔍 Common Setup Issues

### Issue 1: Java Version Mismatch

**Error:** `Unsupported class file major version XX`

**Solution:**
```powershell
# Check Java version
java -version

# If wrong version, set JAVA_HOME
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
```

### Issue 2: Maven Not Found

**Error:** `'mvn' is not recognized`

**Solution:**
```powershell
# Verify Maven installation
mvn -version

# If not found, download and install Maven
# Add to PATH: C:\Program Files\Apache\maven\bin
# Restart terminal
```

### Issue 3: MySQL Connection Failed

**Error:** `Unable to connect to database`

**Solution:**
```powershell
# Check MySQL is running
Get-Service MySQL*

# If stopped, start it
net start MySQL80

# Verify credentials in DatabaseConnection.java match MySQL
```

### Issue 4: Port Already in Use

**Error:** `Address already in use: bind :8081`

**Solution:**
```powershell
# Find process using port 8081
netstat -ano | findstr :8081

# Kill the process
taskkill /PID <PID_NUMBER> /F

# Or change port in pom.xml
```

### Issue 5: CORS Errors

**Error:** `No 'Access-Control-Allow-Origin' header`

**Solution:**
- Ensure you're using `http://localhost` not `file://`
- Verify servlets have CORS headers (already implemented)
- Check server is running on correct port

### Issue 6: Target Directory Locked

**Error:** `Failed to delete target directory`

**Solution:**
```powershell
# Close VS Code
# Run as Administrator
cd backend
rd /s /q target
mvn clean install
```

---

## 🎯 Quick Setup Script

For automated setup (PowerShell):

```powershell
# Save this as setup.ps1 and run

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Cyan
java -version
mvn -version
Get-Service MySQL* | Select-Object Status,Name

# Navigate to backend
cd backend

# Clean and install
Write-Host "Installing dependencies..." -ForegroundColor Cyan
mvn clean install

# Build project
Write-Host "Building project..." -ForegroundColor Cyan
mvn clean package

# Start server
Write-Host "Starting server..." -ForegroundColor Cyan
mvn tomcat7:run
```

---

## 📚 Next Steps

After successful setup:

1. **Read the README.md** for detailed documentation
2. **Explore the code** to understand the architecture
3. **Test on mobile** using mobile-test.html
4. **Customize the UI** by editing CSS files
5. **Add features** like password reset, email verification
6. **Deploy to production** (see README.md deployment section)

---

## 🆘 Getting Help

If you encounter issues:

1. **Check this setup guide** thoroughly
2. **Review error messages** carefully
3. **Check logs** in terminal/console
4. **Verify each step** was completed
5. **Consult troubleshooting** in README.md
6. **Review COMPLETE_FIX_GUIDE.md** for detailed fixes

---

## 🎓 Understanding the Project

### Project Architecture
```
Browser (Frontend) 
    ↕ HTTP/JSON
Backend (Servlets) 
    ↕ JDBC
Database (MySQL)
```

### Request Flow
```
1. User enters credentials in index.html
2. JavaScript sends POST to /api/login
3. LoginServlet receives request
4. Servlet queries MySQL database
5. BCrypt verifies password
6. Servlet sends JSON response
7. JavaScript handles response
8. User redirected to dashboard
```

### Security Flow
```
Registration:
Password → BCrypt Hash → Store in DB

Login:
Password + Hash from DB → BCrypt Compare → Success/Fail
```

---

## 🎉 Success!

If you've completed all steps successfully, you now have:

✅ A working login/registration system  
✅ Secure password hashing with BCrypt  
✅ RESTful API backend  
✅ Responsive frontend UI  
✅ MySQL database integration  
✅ Complete development environment  

**Congratulations! You're ready to start developing!** 🚀

---

**Created by:** Lex Edrick Asherjesse C. Matondo  
**Version:** 1.0  
**Last Updated:** November 2025
