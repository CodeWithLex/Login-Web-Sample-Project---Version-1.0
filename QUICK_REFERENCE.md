# ⚡ Quick Reference Card

## 🚀 Quick Start (30 Seconds)

```bash
1. Double-click: TEST_SYSTEM.bat          # Verify everything
2. Double-click: START_SERVER_COMPLETE.bat  # Start server
3. Open in browser: frontend/Version 1.0/index.html
4. Login: test@example.com / test123
```

---

## 📂 Important Files

| File | Location | Purpose |
|------|----------|---------|
| **Login Page** | `frontend/Version 1.0/index.html` | Main login interface |
| **Register** | `frontend/Version 1.0/register.html` | Create new account |
| **Dashboard** | `frontend/Version 1.0/dashboard.html` | After login |
| **Start Server** | `START_SERVER_COMPLETE.bat` | Launch backend |
| **Test System** | `TEST_SYSTEM.bat` | Verify setup |
| **Main Docs** | `README.md` | Full documentation |

---

## 🔧 Common Commands

### Start Server
```bash
# Method 1: Complete startup (recommended)
START_SERVER_COMPLETE.bat

# Method 2: Quick start
cd backend
mvn tomcat7:run

# Method 3: Emergency start
EMERGENCY_START.bat
```

### Test System
```bash
TEST_SYSTEM.bat
```

### Database Setup
```sql
mysql -u root -p < backend/FINAL_FIX.sql
```

### Check Server Status
```powershell
netstat -ano | findstr :8081
```

---

## 🌐 URLs

| Service | URL |
|---------|-----|
| **Frontend** | Open `index.html` in browser |
| **API Base** | `http://localhost:8081/login-backend/api` |
| **Login API** | `POST http://localhost:8081/login-backend/api/login` |
| **Register API** | `POST http://localhost:8081/login-backend/api/register` |

---

## 👤 Default Test Account

```
Email:    test@example.com
Password: test123
```

---

## 🐛 Quick Fixes

### Server won't start
```bash
# Kill Java processes
taskkill /F /IM java.exe

# Check port 8081
netstat -ano | findstr :8081

# Clean build
cd backend
rd /s /q target
mvn clean install
```

### Database connection fails
```bash
# Start MySQL
net start MySQL80

# Verify credentials in:
backend/src/main/java/com/mysample_app/DatabaseConnection.java
```

### Login fails
```sql
# Check database
mysql -u root -p
USE Login_Test_Web;
SELECT * FROM users;

# If empty, run:
source backend/FINAL_FIX.sql
```

---

## 📊 Project Structure

```
Project Root/
├── frontend/Version 1.0/  → HTML, CSS, JS
├── backend/               → Java servlets
│   ├── src/main/java/    → Java code
│   └── pom.xml           → Maven config
├── *.bat / *.ps1         → Startup scripts
└── *.md                  → Documentation
```

---

## 🔑 Key Configuration

### Database (DatabaseConnection.java)
```java
URL: jdbc:mysql://localhost:3306/Login_Test_Web
USER: root
PASSWORD: root  // Change this!
```

### Server (pom.xml)
```xml
Port: 8081
Path: /login-backend
```

### API Base (Frontend)
```javascript
http://localhost:8081/login-backend/api
```

---

## ✅ Verification Checklist

- [ ] Java 21+ installed (`java -version`)
- [ ] Maven installed (`mvn -version`)
- [ ] MySQL running (`Get-Service MySQL*`)
- [ ] Database created (`Login_Test_Web`)
- [ ] Users table exists
- [ ] Test user exists
- [ ] Dependencies installed (`mvn install`)
- [ ] Server started (port 8081)
- [ ] Frontend opens in browser
- [ ] Login works

---

## 📚 Documentation Quick Links

| Document | Purpose |
|----------|---------|
| `README.md` | Complete project documentation |
| `SETUP_GUIDE.md` | Step-by-step setup instructions |
| `PROJECT_SUMMARY.md` | Project overview and status |
| `FIX_SUMMARY.md` | Quick troubleshooting |
| `COMPLETE_FIX_GUIDE.md` | Comprehensive troubleshooting |

---

## 🎯 API Request Examples

### Login Request
```json
POST /api/login
Content-Type: application/json

{
  "email": "test@example.com",
  "password": "test123"
}
```

### Register Request
```json
POST /api/register
Content-Type: application/json

{
  "email": "new@example.com",
  "password": "newpass123"
}
```

---

## 🔒 Security Notes

- ✅ Passwords hashed with BCrypt
- ✅ SQL injection prevention
- ✅ Input validation (client + server)
- ✅ CORS enabled
- ⚠️ Change default DB password
- ⚠️ Use HTTPS in production

---

## 📱 Testing

### Desktop
1. Open `index.html` in any browser
2. Test login/register flows
3. Check dashboard

### Mobile
1. Open `mobile-test.html`
2. Test on actual device
3. Test portrait/landscape

### API
```powershell
# Test OPTIONS (CORS)
Invoke-WebRequest -Uri http://localhost:8081/login-backend/api/login -Method OPTIONS

# Test POST (Login)
$body = @{email="test@example.com"; password="test123"} | ConvertTo-Json
Invoke-RestMethod -Uri http://localhost:8081/login-backend/api/login -Method POST -Body $body -ContentType "application/json"
```

---

## 🚨 Emergency Procedures

### Complete Reset
```bash
# 1. Stop everything
taskkill /F /IM java.exe

# 2. Reset database
mysql -u root -p
DROP DATABASE Login_Test_Web;
CREATE DATABASE Login_Test_Web;
USE Login_Test_Web;
SOURCE backend/FINAL_FIX.sql;

# 3. Clean build
cd backend
rd /s /q target
mvn clean install

# 4. Restart
START_SERVER_COMPLETE.bat
```

### Can't Access Files
```bash
# Close VS Code
# Run as Administrator
cd backend
rd /s /q target
```

---

## 💡 Tips & Tricks

1. **Always run TEST_SYSTEM.bat first** - Catches 90% of issues
2. **Use START_SERVER_COMPLETE.bat** - Has built-in checks
3. **Keep server terminal open** - See real-time logs
4. **Check browser console (F12)** - Frontend errors show here
5. **Check server terminal** - Backend errors show here

---

## 🎯 Next Steps After Setup

1. ✅ Verify login works with test account
2. ✅ Create new account via registration
3. ✅ Test mobile compatibility
4. ✅ Customize UI colors (css/base.css)
5. ✅ Change database password
6. ✅ Read full documentation
7. ✅ Add new features

---

## 📞 Getting Help

1. **Problem?** → Check `FIX_SUMMARY.md`
2. **Still stuck?** → Read `COMPLETE_FIX_GUIDE.md`
3. **Need setup help?** → Follow `SETUP_GUIDE.md`
4. **Want details?** → Read `README.md`

---

## ⚡ Speed Commands

```bash
# Full test and start
TEST_SYSTEM.bat && START_SERVER_COMPLETE.bat

# Quick restart
cd backend && mvn tomcat7:run

# Database check
mysql -u root -p -e "USE Login_Test_Web; SELECT * FROM users;"

# Port check
netstat -ano | findstr :8081
```

---

**Keep this card handy for quick reference!** 📌

---

**Version:** 1.0  
**Last Updated:** November 23, 2025  
**Status:** ✅ Complete
