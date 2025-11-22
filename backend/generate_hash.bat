@echo off
echo Generating BCrypt hash for password: test123
echo.
cd /d "E:\BSCPE-2\FILES\SAMPLE PROJECT - LOGIN\backend"
mvn compile exec:java -Dexec.mainClass="com.mysample_app.PasswordHashGenerator" -q
pause
