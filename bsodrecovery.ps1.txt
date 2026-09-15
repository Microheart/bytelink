# PowerShell Script: Automated BSOD Recovery Toolkit
# Save as: BSOD_Recovery.ps1
# Run as Administrator

Write-Host "=== Starting BSOD Recovery Toolkit ===" -ForegroundColor Cyan

# Step 1: System File Checker
Write-Host "Running System File Checker (SFC)..." -ForegroundColor Yellow
sfc /scannow

# Step 2: DISM Repair (Windows Image)
Write-Host "Repairing Windows Image with DISM..." -ForegroundColor Yellow
DISM /Online /Cleanup-Image /RestoreHealth

# Step 3: Check Disk for Errors
Write-Host "Scheduling CHKDSK on C: drive..." -ForegroundColor Yellow
chkdsk C: /f /r

# Step 4: Boot Configuration Repair
Write-Host "Repairing Boot Configuration..." -ForegroundColor Yellow
bootrec /fixmbr
bootrec /fixboot
bootrec /scanos
bootrec /rebuildbcd

Write-Host "=== Recovery Commands Completed ===" -ForegroundColor Green
Write-Host "Please restart the system to apply changes." -ForegroundColor Cyan
