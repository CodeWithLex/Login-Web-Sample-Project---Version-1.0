# Login Web Sample Project - Version 1.0

A modern, full-stack web application with secure user authentication using Java Servlets, MySQL, and responsive front-end design.

**Created by:** Lex Edrick Asherjesse C. Matondo

---

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Running the Application](#running-the-application)
- [Usage Guide](#usage-guide)
- [API Documentation](#api-documentation)
- [Database Schema](#database-schema)
- [Troubleshooting](#troubleshooting)
- [Security Features](#security-features)
- [Mobile Compatibility](#mobile-compatibility)

---

## ✨ Features

### Frontend Features
- ✅ Modern, responsive UI with smooth animations
- ✅ Mobile-first design with full touch support
- ✅ Cross-platform compatibility (Desktop, Tablet, Mobile)
- ✅ Real-time form validation
- ✅ Password visibility toggle
- ✅ "Remember me" functionality
- ✅ Clean, accessible design
- ✅ Animated gradient backgrounds
- ✅ Interactive button effects

### Backend Features
- ✅ RESTful API architecture
- ✅ Secure password hashing with BCrypt
- ✅ CORS support for cross-origin requests
- ✅ JSON request/response handling
- ✅ SQL injection prevention
- ✅ Detailed logging for debugging
- ✅ Error handling and validation
- ✅ Session management ready

### Security
- ✅ BCrypt password hashing (industry standard)
- ✅ SQL prepared statements (prevents injection)
- ✅ Input validation on client and server
- ✅ Secure password storage (60-character hashes)
- ✅ HTTPS-ready architecture

---

## 🛠️ Tech Stack

### Frontend
- **HTML5** - Semantic markup
- **CSS3** - Modern styling with animations
- **JavaScript (ES6+)** - Client-side logic
- **Fetch API** - Async communication

### Backend
- **Java 21** - Server-side programming
- **Maven** - Dependency management & build tool
- **Tomcat 7 Plugin** - Embedded server
- **Servlets 4.0** - HTTP request handling

### Libraries & Dependencies
- **BCrypt (jBCrypt 0.4)** - Password hashing
- **Gson 2.10.1** - JSON parsing
- **MySQL Connector 8.2.0** - Database connectivity

### Database
- **MySQL 8.0+** - Relational database

---

## 📁 Project Structure

```
SAMPLE PROJECT - LOGIN/
│
├── frontend/
│   └── Version 1.0/
│       ├── index.html              # Login page
│       ├── register.html           # Registration page
│       ├── dashboard.html          # User dashboard
│       ├── welcome.html            # Welcome splash page
│       ├── mobile-test.html        # Mobile testing page
│       ├── css/
│       │   ├── base.css           # Base styles & animations
│       │   ├── form.css           # Form-specific styles
│       │   └── dashboard.css      # Dashboard styles
│       ├── CROSS_PLATFORM_SUMMARY.md
│       └── MOBILE_COMPATIBILITY_GUIDE.md
│
├── backend/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/mysample_app/
│   │       │   ├── DatabaseConnection.java
│   │       │   ├── LoginServlet.java
│   │       │   ├── RegisterServlet.java
│   │       │   ├── PasswordHashGenerator.java
│   │       │   ├── GenerateTestHash.java
│   │       │   └── models/
│   │       │       └── User.java
│   │       ├── resources/
│   │       │   └── application.properties
│   │       └── webapp/
│   │           └── WEB-INF/
│   │               └── web.xml
│   ├── pom.xml                    # Maven configuration
│   ├── FINAL_FIX.sql             # Database setup script
│   ├── create_test_users.sql     # Test user creation
│   └── DEBUG_CHECKLIST.md        # Debugging guide
│
├── START_SERVER.bat               # Server startup script
├── EMERGENCY_START.bat            # Emergency server start
├── QUICK_START.bat                # Quick start (no rebuild)
├── FIX_SUMMARY.md                 # Common issues guide
├── COMPLETE_FIX_GUIDE.md          # Comprehensive troubleshooting
└── README.md                      # This file
```

---

## 📦 Prerequisites

Before running this project, ensure you have:

### Required Software
1. **Java Development Kit (JDK) 21** or higher
   - Download: https://www.oracle.com/java/technologies/downloads/
   - Verify: `java -version`

2. **Apache Maven 3.6+**
   - Download: https://maven.apache.org/download.cgi
   - Verify: `mvn -version`

3. **MySQL Server 8.0+**
   - Download: https://dev.mysql.com/downloads/mysql/
   - Verify: `mysql --version`

4. **Modern Web Browser**
   - Chrome, Firefox, Safari, or Edge (latest versions)

### Environment Setup
- Java and Maven should be in your system PATH
- MySQL should be running as a service
- Port 8081 should be available (or modify in `pom.xml`)
- Port 3306 should be open for MySQL

---

## 🚀 Installation & Setup

### Step 1: Clone/Download the Project
```bash
git clone <repository-url>
cd "SAMPLE PROJECT - LOGIN"
```

### Step 2: Setup MySQL Database

1. **Start MySQL Server**
   ```bash
   # Windows (as Administrator)
   net start MySQL80

   # Or check MySQL service in Services app
   ```

2. **Create Database**
   ```sql
   mysql -u root -p
   ```
   
   Enter your MySQL password, then:
   ```sql
   CREATE DATABASE Login_Test_Web;
   USE Login_Test_Web;

   CREATE TABLE users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       email VARCHAR(255) UNIQUE NOT NULL,
       password VARCHAR(255) NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

3. **Create Test User (Optional)**
   ```sql
   -- Run: backend/FINAL_FIX.sql
   -- This creates test user: test@example.com / test123
   ```

### Step 3: Configure Database Connection

Edit `backend/src/main/java/com/mysample_app/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/Login_Test_Web";
private static final String USER = "root";          // Your MySQL username
private static final String PASSWORD = "root";      // Your MySQL password
```

### Step 4: Install Dependencies
```bash
cd backend
mvn clean install
```

---

## ▶️ Running the Application

### Method 1: Using Batch Scripts (Recommended for Windows)

**Option A: Emergency Start** (Most Reliable)
```bash
# Double-click: EMERGENCY_START.bat
# OR run in terminal:
.\EMERGENCY_START.bat
```

**Option B: Normal Start**
```bash
.\START_SERVER.bat
```

**Option C: Quick Start** (No rebuild, faster)
```bash
.\QUICK_START.bat
```

### Method 2: Using Maven Directly
```bash
cd backend
mvn tomcat7:run
```

### Method 3: Using PowerShell
```powershell
.\START_SERVER_NEW.ps1
```

### Verify Server is Running
You should see:
```
[INFO] Starting ProtocolHandler ["http-bio-8081"]
```

**Test the server:**
```bash
# Windows PowerShell
Invoke-WebRequest -Uri http://localhost:8081/login-backend/api/login -Method OPTIONS

# Command Prompt
curl http://localhost:8081/login-backend/api/login
```

---

## 📖 Usage Guide

### Accessing the Application

1. **Welcome Page** (Optional)
   - Open: `frontend/Version 1.0/welcome.html`
   - Automatic redirect to login after 5 seconds

2. **Login Page**
   - Open: `frontend/Version 1.0/index.html`
   - Default test user: `test@example.com` / `test123`

3. **Register Page**
   - Open: `frontend/Version 1.0/register.html`
   - Create a new account

### User Workflow

```
1. Open welcome.html
   ↓ (auto-redirect)
2. Login page (index.html)
   ├─→ New user? → register.html → Create account → Back to login
   └─→ Existing user → Enter credentials → dashboard.html
```

### Creating a New Account

1. Navigate to `register.html`
2. Enter valid email address
3. Enter password (minimum 6 characters)
4. Confirm password
5. Click "Create Account"
6. Redirected to login page on success

### Logging In

1. Navigate to `index.html`
2. Enter registered email
3. Enter password
4. Optional: Check "Remember me"
5. Click "Sign in"
6. Redirected to dashboard on success

---

## 🔌 API Documentation

### Base URL
```
http://localhost:8081/login-backend/api
```

### Endpoints

#### 1. User Login
```http
POST /login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "userpassword",
  "remember": false
}
```

**Success Response:**
```json
{
  "success": true,
  "email": "user@example.com",
  "message": "Login successful"
}
```

**Error Response:**
```json
{
  "success": false,
  "message": "Invalid email or password"
}
```

#### 2. User Registration
```http
POST /register
Content-Type: application/json

{
  "email": "newuser@example.com",
  "password": "newpassword"
}
```

**Success Response:**
```json
{
  "success": true,
  "email": "newuser@example.com",
  "message": "User registered successfully"
}
```

**Error Response:**
```json
{
  "success": false,
  "message": "Email already registered"
}
```

---

## 🗄️ Database Schema

### Users Table

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Columns:**
- `id` - Auto-incrementing unique identifier
- `email` - User's email address (unique, required)
- `password` - BCrypt hashed password (60 characters)
- `created_at` - Timestamp of account creation

**Indexes:**
- PRIMARY KEY on `id`
- UNIQUE INDEX on `email`

---

## 🔧 Troubleshooting

### Common Issues

#### 1. Server Won't Start

**Problem:** "Address already in use: bind"
```bash
# Solution: Kill process on port 8081
netstat -ano | findstr :8081
taskkill /PID <PID> /F

# Or change port in pom.xml
```

**Problem:** "Target directory cannot be deleted"
```bash
# Solution: Close VS Code, then:
cd backend
rd /s /q target
mvn clean install
```

#### 2. Connection Errors in Browser

**Problem:** "Connection error. Make sure the server is running."
```bash
# Check if server is running:
netstat -ano | findstr :8081

# If not running, start server:
.\EMERGENCY_START.bat
```

#### 3. Login Fails with Valid Credentials

**Problem:** "Invalid email or password"
```sql
-- Check database:
USE Login_Test_Web;
SELECT id, email, 
  SUBSTRING(password, 1, 7) as hash_format,
  LENGTH(password) as hash_length 
FROM users;

-- Expected: hash_format = '$2a$10$', hash_length = 60

-- If wrong, run: backend/FINAL_FIX.sql
```

#### 4. CORS Errors

**Problem:** "No 'Access-Control-Allow-Origin' header"
- Servlets already configured with CORS headers
- Make sure you're accessing from the same protocol (http://)
- Don't use file:// protocol

#### 5. Database Connection Failed

**Problem:** "Unable to connect to database"
```bash
# Check MySQL is running:
Get-Service MySQL* | Select-Object Status,Name

# If not running:
net start MySQL80

# Verify credentials in DatabaseConnection.java
```

### Debug Mode

Enable detailed logging in servlets:
```java
System.out.println("=== DEBUG INFO ===");
// Already present in LoginServlet and RegisterServlet
```

Check console output for detailed error messages.

### Getting Help

1. Check `COMPLETE_FIX_GUIDE.md` for comprehensive troubleshooting
2. Check `FIX_SUMMARY.md` for quick fixes
3. Check `backend/DEBUG_CHECKLIST.md` for backend issues

---

## 🔒 Security Features

### Password Security
- **BCrypt Hashing** - Industry-standard algorithm
- **Salted Hashes** - Unique salt for each password
- **Cost Factor 10** - Balance between security and performance
- **60-char hashes** - Standardized BCrypt format

### SQL Injection Prevention
- **Prepared Statements** - All queries use parameterized inputs
- **No String Concatenation** - Eliminates injection vectors

### Input Validation
- **Client-Side** - Immediate feedback, better UX
- **Server-Side** - Security layer, cannot be bypassed
- **Email Format** - Regex validation
- **Password Length** - Minimum 6 characters

### Best Practices Implemented
- ✅ No plain text passwords
- ✅ No sensitive data in logs (passwords redacted)
- ✅ Proper error messages (no information leakage)
- ✅ HTTPS-ready (add SSL certificate for production)

---

## 📱 Mobile Compatibility

### Supported Devices
- ✅ iOS (iPhone, iPad)
- ✅ Android (phones, tablets)
- ✅ Windows Mobile
- ✅ Desktop browsers

### Mobile Features
- Touch-optimized buttons (44px minimum)
- Responsive layouts
- Viewport scaling disabled on inputs (prevents zoom)
- PWA-ready meta tags
- Landscape mode support

### Testing on Mobile
1. Open `frontend/Version 1.0/mobile-test.html`
2. Check all features work correctly
3. Test in both portrait and landscape

See `MOBILE_COMPATIBILITY_GUIDE.md` for details.

---

## 🎨 Customization

### Changing Colors
Edit `frontend/Version 1.0/css/base.css`:
```css
:root {
    --bg: #81b6fa;        /* Background color */
    --accent: #2563eb;    /* Primary button color */
    --card: #ffffff;      /* Card background */
    --muted: #6b7280;     /* Secondary text */
    --danger: #ef4444;    /* Error messages */
}
```

### Changing Port
Edit `backend/pom.xml`:
```xml
<configuration>
    <port>8081</port>  <!-- Change this -->
    <path>/login-backend</path>
</configuration>
```

Also update frontend fetch URLs:
```javascript
// Change in index.html and register.html
fetch('http://localhost:8081/login-backend/api/login', ...)
```

### Adding New Fields
1. Alter database table
2. Update User.java model
3. Modify servlets to handle new fields
4. Update frontend forms

---

## 📊 Performance

### Optimization Tips
- Use connection pooling for production
- Enable MySQL query caching
- Minify CSS/JS for production
- Enable GZIP compression
- Use CDN for static assets

### Current Performance
- Login request: ~50-200ms
- Registration: ~100-300ms
- Page load: <1s (on localhost)

---

## 🚀 Deployment

### For Production
1. **Change database credentials** in `DatabaseConnection.java`
2. **Use environment variables** for sensitive data
3. **Enable HTTPS** with SSL certificate
4. **Set up connection pooling**
5. **Deploy to Tomcat server** (not embedded)
6. **Use production MySQL server**
7. **Minify frontend assets**
8. **Enable security headers**
9. **Set up logging framework** (Log4j/SLF4J)
10. **Configure CORS** properly for your domain

---

## 📝 License

This project is created for educational purposes.

**Author:** Lex Edrick Asherjesse C. Matondo
**Version:** 1.0
**Date:** November 2025

---

## 🤝 Contributing

Feel free to fork this project and submit pull requests for improvements!

---

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review the documentation files
3. Check console logs for errors
4. Verify all prerequisites are installed

---

## 🎯 Future Enhancements

Potential features to add:
- [ ] Email verification
- [ ] Password reset functionality
- [ ] Social login (Google, Facebook)
- [ ] User profile management
- [ ] Session timeout handling
- [ ] Two-factor authentication
- [ ] Account deletion
- [ ] Password strength indicator
- [ ] Activity logging
- [ ] Admin panel

---

## ✅ Quick Start Checklist

- [ ] Java 21+ installed
- [ ] Maven installed
- [ ] MySQL running
- [ ] Database `Login_Test_Web` created
- [ ] Users table created
- [ ] Database credentials configured
- [ ] Dependencies installed (`mvn clean install`)
- [ ] Server started (`EMERGENCY_START.bat`)
- [ ] Browser opened to `index.html`
- [ ] Test login works

---

**🎉 Congratulations! Your login system is ready to use!**
