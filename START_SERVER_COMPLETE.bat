@echo off
:: ========================================
:: Complete Server Startup Wrapper
:: ========================================

echo.
echo ========================================
echo   Sample Login Project - Quick Start
echo ========================================
echo.

:: Check if PowerShell is available
where powershell >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] PowerShell not found!
    echo Please run the server manually using Maven.
    pause
    exit /b 1
)

:: Run the PowerShell script
echo Starting server with enhanced checks...
echo.
powershell -ExecutionPolicy Bypass -File "%~dp0START_SERVER_COMPLETE.ps1"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Server failed to start!
    echo.
    echo Please check:
    echo   1. MySQL is running
    echo   2. Java and Maven are installed
    echo   3. Port 8081 is available
    echo.
    pause
    exit /b 1
)

pause
