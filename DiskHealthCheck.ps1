# Hard Disk Health & Bad Sector Check Script
# Save as DiskHealthCheck.ps1 and run as Administrator

# 1. Get SMART status via WMIC
Write-Host "Checking SMART status..."
$smartStatus = (Get-WmiObject -Namespace root\wmi -Class MSStorageDriver_FailurePredictStatus).PredictFailure
if ($smartStatus -eq $true) {
    Write-Host "SMART predicts failure! Backup data immediately." -ForegroundColor Red
} else {
    Write-Host "SMART status: Healthy" -ForegroundColor Green
}

# 2. List physical disks and health status
Write-Host "`nListing physical disks..."
Get-PhysicalDisk | Select FriendlyName, OperationalStatus, HealthStatus, Size | Format-Table -AutoSize

# 3. Run CHKDSK for bad sector scan (C: drive example)
Write-Host "`nRunning CHKDSK on C: drive..."
Start-Process -FilePath "chkdsk.exe" -ArgumentList "C: /F /R" -Verb RunAs

# 4. Log results to file
$logPath = "C:\Reports\DiskHealthReport.txt"
Write-Host "`nSaving report to $logPath"
Get-PhysicalDisk | Select FriendlyName, OperationalStatus, HealthStatus, Size | Out-File $logPath
