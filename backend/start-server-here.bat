@echo off
cd /d "%~dp0"
echo Starting server from: %CD%
mvn tomcat7:run
pause
