@echo off
echo ================================================
echo   SIMPLE SERVER START - NO MAVEN CLEAN
echo ================================================
echo.

cd /d "%~dp0backend"

echo Killing Java processes...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo Starting server WITHOUT rebuild...
echo This uses existing compiled files
echo.

mvn tomcat7:run-war

pause
