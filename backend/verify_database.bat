@echo off
echo ============================================
echo DATABASE VERIFICATION SCRIPT
echo ============================================
echo.
echo This script will check your database setup
echo.
echo Please enter your MySQL root password when prompted
echo.
pause

mysql -u root -p -e "USE Login_Test_Web; SELECT id, email, SUBSTRING(password, 1, 10) as hash_start, LENGTH(password) as hash_len, CASE WHEN password LIKE '$2a$%%' THEN 'OK' ELSE 'WRONG FORMAT' END as format_check FROM users;"

echo.
echo ============================================
echo If you see a user above, note the format_check
echo It should say 'OK' for BCrypt to work
echo ============================================
echo.
pause
