# Login Backend Server Startup Script
# PowerShell Version

$Host.UI.RawUI.WindowTitle = "Login Backend Server"
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  LOGIN BACKEND SERVER - STARTING" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to backend directory
$backendPath = Join-Path $PSScriptRoot "backend"
Set-Location $backendPath

Write-Host "[INFO] Current directory: $((Get-Location).Path)" -ForegroundColor Yellow
Write-Host ""

# Check Maven
$mavenExists = Get-Command mvn -ErrorAction SilentlyContinue
if (-not $mavenExists) {
    Write-Host "[ERROR] Maven is not installed or not in PATH!" -ForegroundColor Red
    Write-Host "[ERROR] Please install Maven first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[OK] Maven found" -ForegroundColor Green
Write-Host ""

# Kill any Java processes
Write-Host "[INFO] Stopping any running Java processes..." -ForegroundColor Yellow
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Remove target directory
if (Test-Path "target") {
    Write-Host "[INFO] Removing old target directory..." -ForegroundColor Yellow
    cmd /c "rd /s /q target" 2>$null
    Start-Sleep -Seconds 1
}

if (Test-Path "target_old_*") {
    Write-Host "[INFO] Removing old backup directories..." -ForegroundColor Yellow
    Get-ChildItem "target_old_*" | ForEach-Object { cmd /c "rd /s /q `"$($_.FullName)`"" 2>$null }
}

Write-Host "[INFO] Building and starting server..." -ForegroundColor Cyan
Write-Host "[INFO] Server will run on: http://localhost:8081/login-backend" -ForegroundColor Green
Write-Host "[INFO] Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  SERVER STARTING - PLEASE WAIT..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Start server
try {
    mvn clean package tomcat7:run -DskipTests
    if ($LASTEXITCODE -ne 0) {
        throw "Maven command failed with exit code $LASTEXITCODE"
    }
}
catch {
    Write-Host ""
    Write-Host "[ERROR] Server failed to start!" -ForegroundColor Red
    Write-Host "[ERROR] $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Read-Host "Press Enter to exit"
