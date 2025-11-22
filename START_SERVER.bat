@echo off
title Login Backend Server
color 0A
echo.
echo ================================================
echo   LOGIN BACKEND SERVER - STARTING
echo ================================================
echo.

REM Change to backend directory
cd /d "%~dp0backend"

echo [INFO] Current directory: %CD%
echo.

REM Check if Maven is available
where mvn >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Maven is not installed or not in PATH!
    echo [ERROR] Please install Maven first.
    pause
    exit /b 1
)

echo [OK] Maven found
echo.

REM Kill any existing Java processes that might lock files
echo [INFO] Stopping any running Java processes...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Clean target directory if exists
if exist "target" (
    echo [INFO] Removing old target directory...
    rd /s /q "target" >nul 2>&1
    timeout /t 1 /nobreak >nul
)

echo [INFO] Building and starting server...
echo [INFO] Server will run on: http://localhost:8081/login-backend
echo [INFO] Press Ctrl+C to stop the server
echo.
echo ================================================
echo   SERVER STARTING - PLEASE WAIT...
echo ================================================
echo.

REM Start Maven Tomcat
mvn clean package tomcat7:run -DskipTests

if errorlevel 1 (
    echo.
    echo [ERROR] Server failed to start!
    echo [ERROR] Check the error messages above
    pause
    exit /b 1
)

pause
