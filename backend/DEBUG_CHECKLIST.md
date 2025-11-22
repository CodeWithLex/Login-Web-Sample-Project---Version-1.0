# LOGIN DEBUG CHECKLIST

## Please answer these questions:

### 1. Did you run the FIX_LOGIN.sql script?
- [ ] Yes, I ran it in MySQL Workbench
- [ ] Yes, I ran it in MySQL Command Line
- [ ] No, I haven't run it yet

### 2. What email are you trying to login with?
Your answer: _______________

### 3. What password are you trying?
Your answer: _______________

### 4. What exact error message do you see?
- [ ] "Invalid email or password"
- [ ] "Connection error. Make sure the server is running."
- [ ] Other: _______________

### 5. Check your database NOW - Run this in MySQL:
```sql
USE Login_Test_Web;
SELECT * FROM users;
```

How many users do you see? _______________
What email(s)? _______________

---

## IMPORTANT: Most Common Mistakes

### ❌ Mistake #1: Didn't run the SQL script
**You must actually execute FIX_LOGIN.sql in MySQL!**
- Open MySQL Workbench
- File → Open SQL Script → Select FIX_LOGIN.sql
- Click the lightning bolt (Execute)
- Check the output shows 1 row inserted

### ❌ Mistake #2: Using wrong email
The script creates user: `test@example.com`
NOT: 
- ~~test@gmail.com~~
- ~~admin@example.com~~
- ~~your-email@example.com~~

### ❌ Mistake #3: Using wrong password
The password is: `test123`
NOT:
- ~~Test123~~ (capital T)
- ~~test1234~~ (extra 4)
- ~~test123 ~~ (space at end)

### ❌ Mistake #4: Typos
Check carefully:
- Email: exactly `test@example.com`
- Password: exactly `test123`

---

## What to do RIGHT NOW:

### Step 1: Verify Database
Open MySQL Workbench and run:
```sql
USE Login_Test_Web;
SELECT email, LENGTH(password), SUBSTRING(password, 1, 4) FROM users;
```

**Expected result:**
- email: `test@example.com`
- LENGTH: `60`
- SUBSTRING: `$2a$`

**If you don't see this, run FIX_LOGIN.sql again!**

### Step 2: Try Login
1. Open your browser to the login page
2. Enter exactly:
   - Email: `test@example.com`
   - Password: `test123`
3. Click Sign in

### Step 3: Check Browser Console
1. Press F12 (open Developer Tools)
2. Go to Console tab
3. Try logging in again
4. Look for any error messages (red text)
5. Copy and paste the errors here

### Step 4: Check Server Console
1. Look at the terminal where you ran `mvn tomcat7:run`
2. When you try to login, you should see:
```
=== LOGIN ATTEMPT ===
Email: test@example.com
Password entered: 'test123'
User found in database!
Password match result: true
```

**What do YOU see?** (Copy and paste it):

---

## Still Not Working? Try This:

### Nuclear Option: Complete Reset

1. **Stop the server** (Ctrl+C in the terminal running Maven)

2. **Reset database:**
```sql
USE Login_Test_Web;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO users (email, password) VALUES 
('test@example.com', '$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1T3e.Gy');
```

3. **Restart the server:**
```bash
cd backend
mvn clean compile tomcat7:run
```

4. **Clear browser cache:** Ctrl+Shift+Delete

5. **Try login again** with:
   - Email: `test@example.com`
   - Password: `test123`

---

## Report Back

After trying the above, tell me:
1. What you see in the browser console (F12)
2. What you see in the server terminal
3. What the database query returns
4. The exact error message you see on screen
