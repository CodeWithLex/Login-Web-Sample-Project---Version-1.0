# Start Server PowerShell Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Login Backend Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to backend directory
$backendPath = Join-Path $PSScriptRoot "backend"
Set-Location $backendPath

Write-Host "Current directory: $((Get-Location).Path)" -ForegroundColor Yellow
Write-Host ""

# Check Maven
Write-Host "Checking if Maven is installed..." -ForegroundColor Yellow
$mavenCheck = Get-Command mvn -ErrorAction SilentlyContinue
if (-not $mavenCheck) {
    Write-Host "ERROR: Maven is not installed or not in PATH" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "Maven found!" -ForegroundColor Green
Write-Host ""

# Remove locked files from target directory
Write-Host "Cleaning up locked files..." -ForegroundColor Yellow
$targetPath = Join-Path $backendPath "target"
if (Test-Path $targetPath) {
    # Try to unlock and remove tomcat directory
    $tomcatPath = Join-Path $targetPath "tomcat"
    if (Test-Path $tomcatPath) {
        Write-Host "Removing Tomcat configuration directory..." -ForegroundColor Yellow
        Remove-Item $tomcatPath -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    # Try to remove maven-status
    $mavenStatusPath = Join-Path $targetPath "maven-status"
    if (Test-Path $mavenStatusPath) {
        Write-Host "Removing Maven status directory..." -ForegroundColor Yellow
        Remove-Item $mavenStatusPath -Recurse -Force -ErrorAction SilentlyContinue
    }
}
Write-Host ""

# Start server
Write-Host "Starting Tomcat Server on port 8081..." -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""
Write-Host "Server will be available at: http://localhost:8081/login-backend" -ForegroundColor Green
Write-Host ""

# Run Maven Tomcat
mvn tomcat7:run

Write-Host ""
Read-Host "Press Enter to exit"
