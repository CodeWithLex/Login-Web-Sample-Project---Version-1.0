@echo off
echo ========================================
echo Starting Login Backend Server
echo ========================================
echo.

cd /d "%~dp0backend"

echo Current directory: %CD%
echo.

echo Checking if Maven is installed...
where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Maven is not installed or not in PATH
    pause
    exit /b 1
)

echo Maven found!
echo.

echo Starting Tomcat Server on port 8081...
echo Press Ctrl+C to stop the server
echo.

mvn tomcat7:run-war-only
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Server failed to start using run-war-only, trying regular run...
    mvn tomcat7:run
)

pause
