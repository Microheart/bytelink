# Run as Administrator
# MicroHeart System & Solutions - AMC Performance Toolkit

Write-Host "Starting performance optimization..."

### 1. Registry Tweaks (Performance Boost)
# Disable Visual Effects
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSettings" -Value 2 -Force

# Prioritize Foreground Apps
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 10 -Force

# Faster Shutdown
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "2000" -Force

# Disable Power Throttling
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottling" -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -Force

# Remove Startup Delay
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "Serialize" -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Force

### 2. System Cleanup
Write-Host "Cleaning temporary files..."
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Clearing Windows Update cache..."
Stop-Service wuauserv -Force
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service wuauserv

### 3. Startup Optimization
Write-Host "Disabling unnecessary startup apps..."
# Example: Disable OneDrive auto-start
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "OneDrive" -Value "" -Force

### 4. Network Speed Test Logging
Write-Host "Testing network speed..."
$NetTest = Test-Connection -ComputerName google.com -Count 5 | Measure-Object ResponseTime -Average
$SpeedLog = "C:\PerformanceLogs\network_speed.txt"
New-Item -ItemType Directory -Force -Path "C:\PerformanceLogs"
"Average Ping to Google: $($NetTest.Average) ms" | Out-File $SpeedLog -Append

### 5. Health Report
Write-Host "Generating system health report..."
$Report = Get-ComputerInfo
$Report | Out-File "C:\PerformanceLogs\system_health.txt"

Write-Host "Optimization complete! Logs saved in C:\PerformanceLogs"

