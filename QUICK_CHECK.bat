@echo off
:: Quick System Check Script
echo.
echo ========================================
echo   Quick System Check
echo ========================================
echo.

echo [1/5] Checking Java...
where java >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Java is installed
    java -version 2>&1 | findstr "version"
) else (
    echo   [FAIL] Java not found!
)

echo.
echo [2/5] Checking Maven...
where mvn >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Maven is installed
    mvn -version 2>&1 | findstr "Apache Maven"
) else (
    echo   [FAIL] Maven not found!
)

echo.
echo [3/5] Checking MySQL Service...
sc query MySQL80 | findstr "RUNNING" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] MySQL is running
) else (
    echo   [WARN] MySQL service not running or not found
    echo   Try: net start MySQL80
)

echo.
echo [4/5] Checking Port 8081...
netstat -ano | findstr ":8081" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [WARN] Port 8081 is in use
) else (
    echo   [OK] Port 8081 is available
)

echo.
echo [5/5] Checking Project Files...
if exist "backend\pom.xml" (
    echo   [OK] Backend files found
) else (
    echo   [FAIL] Backend files missing!
)

if exist "frontend\Version 1.0\index.html" (
    echo   [OK] Frontend files found
) else (
    echo   [FAIL] Frontend files missing!
)

echo.
echo ========================================
echo   Check Complete!
echo ========================================
echo.
echo Next steps:
echo   1. If all checks pass, run: START_SERVER_COMPLETE.bat
echo   2. Then open: frontend\Version 1.0\index.html
echo.

pause
