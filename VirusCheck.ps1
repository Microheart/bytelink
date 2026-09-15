<# 
PC Infection Check Script
Author: MicroHeart
Purpose: Detect suspicious activity on Windows PCs
Run as Administrator
#>

Write-Host "Starting PC Infection Check..." -ForegroundColor Cyan

# 1. Check for suspicious processes
Write-Host "`nScanning running processes..."
Get-Process | Sort-Object CPU -Descending | Select-Object -First 15 Id, ProcessName, CPU

# 2. Look for unsigned executables
Write-Host "`nChecking for unsigned executables..."
Get-Process | ForEach-Object {
    try {
        $path = $_.Path
        if ($path) {
            $signature = Get-AuthenticodeSignature $path
            if ($signature.Status -ne "Valid") {
                Write-Host "Unsigned process detected: $($_.ProcessName) - $path" -ForegroundColor Red
            }
        }
    } catch {}
}

# 3. Check unusual network connections
Write-Host "`nListing active network connections..."
Get-NetTCPConnection | Where-Object { $_.State -eq "Established" } |
Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess

# 4. Verify system file integrity
Write-Host "`nRunning system file check (SFC)..."
sfc /scannow

# 5. Run Windows Defender quick scan
Write-Host "`nRunning Windows Defender quick scan..."
Start-MpScan -ScanType QuickScan

Write-Host "`nPC Infection Check complete. Review results above." -ForegroundColor Cyan
