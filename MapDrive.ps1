<# 
Map Drive Troubleshooter
Author: TechSecure Solutions
Purpose: Diagnose and fix network drive mapping issues
Run as Administrator
#>

# Variables
$DriveLetter = "Z:"
$NetworkPath = "\\ServerName\SharedFolder"
$UserName = "DOMAIN\User"
$Password = "YourPassword"

Write-Host "Checking mapped drive status..." -ForegroundColor Cyan

# 1. Check if drive exists
if (Test-Path $DriveLetter) {
    Write-Host "Drive $DriveLetter is already mapped." -ForegroundColor Green
} else {
    Write-Host "Drive $DriveLetter not found. Attempting to map..." -ForegroundColor Yellow

    # 2. Remove any stale mapping
    net use $DriveLetter /delete /y | Out-Null

    # 3. Map drive with credentials
    net use $DriveLetter $NetworkPath /user:$UserName $Password /persistent:yes

    # 4. Verify mapping
    if (Test-Path $DriveLetter) {
        Write-Host "Drive mapped successfully to $NetworkPath" -ForegroundColor Green
    } else {
        Write-Host "Failed to map drive. Checking network connectivity..." -ForegroundColor Red
        Test-Connection -ComputerName ($NetworkPath.Split("\")[2]) -Count 2
    }
}

# 5. Optional: Reconnect all drives on startup
Write-Host "`nEnsuring drives reconnect on startup..."
Set-ItemProperty -Path "HKCU:\Network\$($DriveLetter.TrimEnd(':'))" -Name "Reconnect" -Value 1

Write-Host "`nDrive mapping check complete." -ForegroundColor Cyan
