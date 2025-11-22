@echo off
:: ========================================
:: System Verification Wrapper
:: ========================================

echo.
echo ========================================
echo   System Verification Tool
echo ========================================
echo.

:: Check if PowerShell is available
where powershell >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] PowerShell not found!
    pause
    exit /b 1
)

:: Run the PowerShell test script
powershell -ExecutionPolicy Bypass -File "%~dp0TEST_SYSTEM.ps1"

exit /b %ERRORLEVEL%
