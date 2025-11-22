# 🔧 COMPLETE FIX GUIDE - Connection Error Resolution

## ⚠️ ROOT CAUSE
The "Connection error. Make sure the server is running" occurs because:
1. **Backend server is NOT running** on `http://localhost:8081`
2. **File locks** are preventing Maven from building the project
3. Windows is locking files in `backend/target` directory

---

## ✅ ULTIMATE FIX - STEP BY STEP

### **SOLUTION 1: Manual Server Start (MOST RELIABLE)**

1. **Close ALL applications that might lock files:**
   - Close VS Code completely
   - Close any IDEs (IntelliJ, Eclipse)
   - Close File Explorer windows in the project folder

2. **Open PowerShell as Administrator:**
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

3. **Kill all Java processes:**
   ```powershell
   taskkill /F /IM java.exe
   timeout /t 3
   ```

4. **Navigate to backend:**
   ```powershell
   cd "E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\backend"
   ```

5. **Force delete target directory:**
   ```powershell
   cmd /c "rd /s /q target"
   timeout /t 2
   ```

6. **Build and start server:**
   ```powershell
   mvn clean package tomcat7:run
   ```

7. **Wait for success message:**
   ```
   INFO: Starting ProtocolHandler ["http-bio-8081"]
   ```

8. **Test the server:**
   - Open browser: `http://localhost:8081/login-backend/`
   - Should show Tomcat page or error (not "Connection refused")

9. **Open your login page:**
   - `E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\frontend\Version 1.0\index.html`

---

### **SOLUTION 2: Exclude from Windows Defender**

The file locking might be caused by Windows Defender scanning:

1. **Open Windows Security:**
   - Press `Win + I` → Update & Security → Windows Security
   - Click "Virus & threat protection"
   - Scroll down to "Virus & threat protection settings"
   - Click "Manage settings"

2. **Add exclusion:**
   - Scroll to "Exclusions"
   - Click "Add or remove exclusions"
   - Click "Add an exclusion" → "Folder"
   - Select: `E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\backend`

3. **Retry server start:**
   ```powershell
   cd "E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\backend"
   mvn tomcat7:run
   ```

---

### **SOLUTION 3: Use Process Explorer to Find Locks**

1. **Download Process Explorer:**
   - https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer

2. **Find locked files:**
   - Run Process Explorer as Administrator
   - Press `Ctrl + F`
   - Search for: `inputFiles.lst`
   - Find which process is locking it
   - Right-click → Kill Process

3. **Restart server**

---

### **SOLUTION 4: Restart Computer (Nuclear Option)**

If all else fails:

1. Save all work
2. Restart Windows
3. Don't open VS Code yet
4. Open PowerShell as Admin
5. Run the server start commands above
6. Then open VS Code

---

## 🎯 VERIFICATION STEPS

After server starts successfully, verify:

### 1. **Check if server is running:**
```powershell
netstat -ano | findstr :8081
```
Should show something like:
```
TCP    0.0.0.0:8081    0.0.0.0:0    LISTENING    12345
```

### 2. **Test backend API:**
```powershell
curl http://localhost:8081/login-backend/
```
Should NOT show "Connection refused"

### 3. **Test login endpoint:**
Open PowerShell and run:
```powershell
$body = @{
    email = "test@example.com"
    password = "test123"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8081/login-backend/api/login" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body
```

### 4. **Open frontend:**
- Double-click: `E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\frontend\Version 1.0\index.html`
- Try logging in
- Should NOT show "Connection error"

---

## 🔍 TROUBLESHOOTING

### Error: "Port 8081 already in use"
```powershell
# Find process using port 8081
netstat -ano | findstr :8081

# Kill it (replace XXXX with PID from above)
taskkill /F /PID XXXX
```

### Error: "Maven not found"
```powershell
# Check if Maven is installed
mvn --version

# If not, download from: https://maven.apache.org/download.cgi
# Add to PATH environment variable
```

### Error: "Access denied for user 'root'@'localhost'"
1. Check MySQL is running:
   ```powershell
   Get-Service MySQL*
   ```

2. Update credentials in:
   - `backend/src/main/resources/application.properties`
   - `backend/src/main/java/com/mysample_app/DatabaseConnection.java`

### Error: "Unknown database 'Login_Test_Web'"
```sql
-- Open MySQL Workbench and run:
CREATE DATABASE Login_Test_Web;
USE Login_Test_Web;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 📝 QUICK CHECKLIST

Before starting server, ensure:
- [ ] MySQL service is running
- [ ] Port 8081 is free
- [ ] Maven is installed and in PATH
- [ ] JDK 21 is installed
- [ ] No VS Code or IDE has the project open
- [ ] Windows Defender exclusion added (optional)
- [ ] All Java processes are stopped

---

## 🚀 EXPECTED RESULT

When everything works:

1. **Server console shows:**
   ```
   INFO: Starting ProtocolHandler ["http-bio-8081"]
   INFO: Server startup in [X] milliseconds
   ```

2. **Browser at http://localhost:8081/login-backend shows:**
   - Some response (even if error page)
   - NOT "This site can't be reached"

3. **Login page works:**
   - No "Connection error" message
   - Can attempt login
   - Gets proper response from server

---

## 💡 ALTERNATIVE: Use Different Port

If port 8081 is problematic, change it:

1. **Edit `backend/pom.xml`:**
   ```xml
   <configuration>
       <port>9090</port>  <!-- Change to 9090 or any free port -->
       <path>/login-backend</path>
   </configuration>
   ```

2. **Update frontend files** (`index.html`, `register.html`, `dashboard.html`):
   ```javascript
   // Change this:
   fetch('http://localhost:8081/login-backend/api/login', {
   
   // To this:
   fetch('http://localhost:9090/login-backend/api/login', {
   ```

3. **Restart server** on new port

---

## 📞 STILL NOT WORKING?

Try this final diagnostic:

```powershell
# Run this diagnostic script
cd "E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\backend"

Write-Host "=== DIAGNOSTIC REPORT ===" -ForegroundColor Cyan

Write-Host "`n1. Maven Version:" -ForegroundColor Yellow
mvn --version

Write-Host "`n2. Java Processes:" -ForegroundColor Yellow
Get-Process java -ErrorAction SilentlyContinue | Format-Table

Write-Host "`n3. Port 8081 Status:" -ForegroundColor Yellow
netstat -ano | findstr :8081

Write-Host "`n4. MySQL Service:" -ForegroundColor Yellow
Get-Service MySQL* | Format-Table

Write-Host "`n5. Target Directory:" -ForegroundColor Yellow
Test-Path "target"

Write-Host "`n6. POM File:" -ForegroundColor Yellow
Test-Path "pom.xml"

Write-Host "`n=== END DIAGNOSTIC ===" -ForegroundColor Cyan
```

Save this output and analyze what's missing!

---

**Created by:** Your friendly AI assistant
**Last Updated:** November 23, 2025
