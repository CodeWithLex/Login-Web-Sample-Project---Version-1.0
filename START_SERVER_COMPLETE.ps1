# ========================================
# Complete Server Startup Script
# ========================================
# This script performs a complete check and startup

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Sample Login Project - Server Starter" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Function to check if a command exists
function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Function to check port availability
function Test-Port {
    param($Port)
    try {
        $connection = Test-NetConnection -ComputerName localhost -Port $Port -WarningAction SilentlyContinue
        return $connection.TcpTestSucceeded
    } catch {
        return $false
    }
}

Write-Host "[1/7] Checking prerequisites..." -ForegroundColor Yellow

# Check Java
if (Test-Command "java") {
    $javaVersion = java -version 2>&1 | Select-String "version" | Out-String
    Write-Host "  ✓ Java installed: $($javaVersion.Trim())" -ForegroundColor Green
} else {
    Write-Host "  ✗ Java not found! Please install Java JDK 21+" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check Maven
if (Test-Command "mvn") {
    $mavenVersion = mvn -version 2>&1 | Select-String "Apache Maven" | Out-String
    Write-Host "  ✓ Maven installed: $($mavenVersion.Trim())" -ForegroundColor Green
} else {
    Write-Host "  ✗ Maven not found! Please install Apache Maven" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check MySQL
Write-Host "`n[2/7] Checking MySQL service..." -ForegroundColor Yellow
$mysqlService = Get-Service MySQL* -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq 'Running'}
if ($mysqlService) {
    Write-Host "  ✓ MySQL is running: $($mysqlService.Name)" -ForegroundColor Green
} else {
    Write-Host "  ⚠ MySQL service not running!" -ForegroundColor Red
    $startMySQL = Read-Host "  Would you like to start MySQL? (Y/N)"
    if ($startMySQL -eq 'Y' -or $startMySQL -eq 'y') {
        try {
            Start-Service MySQL* -ErrorAction Stop
            Write-Host "  ✓ MySQL started successfully" -ForegroundColor Green
        } catch {
            Write-Host "  ✗ Failed to start MySQL. Please start it manually." -ForegroundColor Red
            Read-Host "Press Enter to continue anyway"
        }
    }
}

# Check if port 8081 is available
Write-Host "`n[3/7] Checking port availability..." -ForegroundColor Yellow
if (Test-Port 8081) {
    Write-Host "  ⚠ Port 8081 is already in use!" -ForegroundColor Red
    $killPort = Read-Host "  Kill process on port 8081? (Y/N)"
    if ($killPort -eq 'Y' -or $killPort -eq 'y') {
        $processId = (Get-NetTCPConnection -LocalPort 8081 -ErrorAction SilentlyContinue).OwningProcess
        if ($processId) {
            Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
            Write-Host "  ✓ Killed process on port 8081" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
    } else {
        Write-Host "  ⚠ Server may fail to start. Continuing anyway..." -ForegroundColor Yellow
    }
} else {
    Write-Host "  ✓ Port 8081 is available" -ForegroundColor Green
}

# Kill any existing Java processes (optional)
Write-Host "`n[4/7] Cleaning up old processes..." -ForegroundColor Yellow
$javaProcesses = Get-Process java -ErrorAction SilentlyContinue
if ($javaProcesses) {
    Write-Host "  Found $($javaProcesses.Count) Java process(es) running" -ForegroundColor Yellow
    $killJava = Read-Host "  Kill all Java processes? (Y/N)"
    if ($killJava -eq 'Y' -or $killJava -eq 'y') {
        Stop-Process -Name java -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Java processes terminated" -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
} else {
    Write-Host "  ✓ No old Java processes found" -ForegroundColor Green
}

# Navigate to backend directory
Write-Host "`n[5/7] Navigating to backend directory..." -ForegroundColor Yellow
$backendPath = Join-Path $PSScriptRoot "backend"
if (Test-Path $backendPath) {
    Set-Location $backendPath
    Write-Host "  ✓ Changed to: $backendPath" -ForegroundColor Green
} else {
    Write-Host "  ✗ Backend directory not found!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Clean target directory (optional)
Write-Host "`n[6/7] Preparing build environment..." -ForegroundColor Yellow
$targetPath = Join-Path $backendPath "target"
if (Test-Path $targetPath) {
    $cleanBuild = Read-Host "  Clean build directory? (Y/N)"
    if ($cleanBuild -eq 'Y' -or $cleanBuild -eq 'y') {
        Write-Host "  Cleaning target directory..." -ForegroundColor Yellow
        try {
            Remove-Item -Path $targetPath -Recurse -Force -ErrorAction Stop
            Write-Host "  ✓ Target directory cleaned" -ForegroundColor Green
        } catch {
            Write-Host "  ⚠ Could not delete target directory (may be locked)" -ForegroundColor Yellow
            Write-Host "  Continuing anyway..." -ForegroundColor Yellow
        }
        Start-Sleep -Seconds 1
    }
}

# Start the server
Write-Host "`n[7/7] Starting Tomcat server..." -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Cyan
Write-Host "Server will start on: http://localhost:8081/login-backend" -ForegroundColor Cyan
Write-Host "API Endpoints:" -ForegroundColor Cyan
Write-Host "  - Login:    POST http://localhost:8081/login-backend/api/login" -ForegroundColor White
Write-Host "  - Register: POST http://localhost:8081/login-backend/api/register" -ForegroundColor White
Write-Host "`nFrontend: Open frontend/Version 1.0/index.html in your browser" -ForegroundColor Cyan
Write-Host "`nPress Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Cyan

Start-Sleep -Seconds 2

# Run Maven Tomcat
try {
    mvn tomcat7:run
} catch {
    Write-Host "`n✗ Server failed to start!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
