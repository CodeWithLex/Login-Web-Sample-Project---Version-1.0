@echo off
title EMERGENCY SERVER START
color 0C
cls

echo.
echo ========================================================
echo   EMERGENCY SERVER START - BRUTE FORCE METHOD
echo ========================================================
echo.
echo This script will:
echo  1. Kill ALL Java processes
echo  2. Forcefully delete target directory
echo  3. Wait to ensure files are unlocked
echo  4. Start server fresh
echo.
echo WARNING: This will close any running Java applications!
echo.
pause

echo.
echo [STEP 1] Killing all Java processes...
taskkill /F /IM java.exe /T 2>nul
taskkill /F /IM javaw.exe /T 2>nul
echo Done!

echo.
echo [STEP 2] Waiting for processes to terminate...
timeout /t 5 /nobreak

echo.
echo [STEP 3] Navigating to backend...
cd /d "%~dp0backend"
echo Current directory: %CD%

echo.
echo [STEP 4] Removing target directory (FORCE)...
if exist "target" (
    echo Attempting removal...
    rd /s /q "target" 2>nul
    if exist "target" (
        echo First attempt failed, trying alternative method...
        rmdir /s /q "target" 2>nul
    )
    if exist "target" (
        echo Still exists, using DEL command...
        del /f /s /q "target\*.*" 2>nul
        rd /s /q "target" 2>nul
    )
)

echo.
echo [STEP 5] Waiting for file system to update...
timeout /t 3 /nobreak

echo.
echo [STEP 6] Checking if target was removed...
if exist "target" (
    echo [WARNING] Target directory still exists!
    echo [WARNING] Files might be locked by Windows Defender or another process
    echo.
    echo Attempting to continue anyway...
) else (
    echo [SUCCESS] Target directory removed!
)

echo.
echo ========================================================
echo   STARTING SERVER
echo ========================================================
echo.
echo Server URL: http://localhost:8081/login-backend
echo API Endpoint: http://localhost:8081/login-backend/api/login
echo.
echo Press Ctrl+C to stop the server
echo.

mvn tomcat7:run

echo.
echo ========================================================
echo   SERVER STOPPED
echo ========================================================
echo.
pause
