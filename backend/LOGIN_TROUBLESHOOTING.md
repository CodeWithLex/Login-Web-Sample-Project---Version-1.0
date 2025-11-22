# LOGIN ISSUE FIX - TROUBLESHOOTING GUIDE

## Problem: "Invalid password" error when trying to login

## Quick Fix (Most Common Solution)

### Step 1: Reset the Database User

1. **Open MySQL Workbench** or MySQL Command Line
2. **Run the SQL script:** `FIX_LOGIN.sql`
   - Located at: `backend/FIX_LOGIN.sql`
   - This will create a test user with a known working password

3. **Test Login:**
   - Email: `test@example.com`
   - Password: `test123`

---

## Common Causes & Solutions

### Cause 1: Wrong Password Hash Format ❌
**Problem:** Password stored with wrong BCrypt version (`$2y$` instead of `$2a$`)

**Check:**
```sql
USE Login_Test_Web;
SELECT email, SUBSTRING(password, 1, 4) as prefix, LENGTH(password) as len FROM users;
```

**Expected Result:**
- Prefix should be: `$2a$`
- Length should be: `60`

**Fix:** Use the `FIX_LOGIN.sql` script

---

### Cause 2: User Doesn't Exist ❌
**Problem:** The email you're using isn't in the database

**Check:**
```sql
USE Login_Test_Web;
SELECT * FROM users;
```

**Fix:** Create user with `FIX_LOGIN.sql`

---

### Cause 3: Password Mismatch ❌
**Problem:** You're entering a different password than what's stored

**Common passwords in this project:**
- `test123` (default test password)
- `password123`
- `admin123`

**Fix:** Either:
1. Use the correct password for your account
2. OR reset your password using `FIX_LOGIN.sql`

---

## Detailed Steps to Fix

### Method 1: Using MySQL Workbench (Recommended)

1. Open **MySQL Workbench**
2. Connect to your MySQL server
3. Open the file: `backend/FIX_LOGIN.sql`
4. Click the **⚡ Execute** button (lightning bolt icon)
5. Verify the output shows "✓ BCrypt - Correct Format"
6. Try logging in with:
   - Email: `test@example.com`
   - Password: `test123`

### Method 2: Using MySQL Command Line

```bash
mysql -u root -p < backend/FIX_LOGIN.sql
```

---

## Verify It's Working

### Check Server Logs
When you attempt to login, the server logs will show:
```
=== LOGIN ATTEMPT ===
Email: test@example.com
Password entered: 'test123'
User found in database!
Password match result: true
```

### Check Browser Console
- Open browser Developer Tools (F12)
- Go to Console tab
- You should see the response from the server
- Successful login will redirect to dashboard

---

## Still Not Working?

### Step 1: Verify Server is Running
```bash
cd backend
mvn tomcat7:run
```

Server should be running on: `http://localhost:8081`

### Step 2: Check Database Connection
```sql
USE Login_Test_Web;
SHOW TABLES;
```

Should show `users` table

### Step 3: Check Password Hash Generation
Generate a new hash:
```bash
cd backend
mvn compile
mvn exec:java -Dexec.mainClass="com.mysample_app.GenerateTestHash"
```

Copy the generated SQL and run it in MySQL

### Step 4: Clear Browser Cache
- Press Ctrl + Shift + Delete
- Clear cached images and files
- Try logging in again

---

## Create Additional Users

If you want to create more users, use this SQL template:

```sql
USE Login_Test_Web;

-- Generate hash first using GenerateTestHash.java
-- Then insert like this:
INSERT INTO users (email, password) VALUES 
('your-email@example.com', 'YOUR_BCRYPT_HASH_HERE');
```

**Important:** Always use BCrypt hashes starting with `$2a$` (not `$2y$`)

---

## Testing Checklist ✅

Before reporting issues, verify:
- [ ] MySQL server is running
- [ ] Database `Login_Test_Web` exists
- [ ] Table `users` exists and has data
- [ ] Password hash starts with `$2a$` and is 60 characters long
- [ ] Backend server is running on port 8081
- [ ] Frontend can reach `http://localhost:8081/login-backend/api/login`
- [ ] Using correct email and password combination
- [ ] No typos in email or password
- [ ] Browser console shows no CORS errors

---

## Quick Reference

| Item | Value |
|------|-------|
| **Test Email** | test@example.com |
| **Test Password** | test123 |
| **Database** | Login_Test_Web |
| **Table** | users |
| **Backend URL** | http://localhost:8081/login-backend |
| **API Endpoint** | http://localhost:8081/login-backend/api/login |
| **Hash Format** | $2a$10$... (60 chars) |

---

## Need More Help?

Check these files for diagnostics:
1. `backend/check_database.sql` - Check database status
2. `backend/target/tomcat/logs/` - Server logs
3. Browser Console (F12) - Frontend errors
