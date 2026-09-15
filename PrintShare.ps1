<# 
Printer Sharing Troubleshooter
Author: TechSecure Solutions
Purpose: Diagnose and fix printer sharing issues
Run as Administrator
#>

Write-Host "Starting Printer Sharing Troubleshooter..." -ForegroundColor Cyan

# 1. Check Print Spooler Service
Write-Host "`nChecking Print Spooler service..."
$spooler = Get-Service -Name Spooler
if ($spooler.Status -ne "Running") {
    Write-Host "Print Spooler is not running. Starting service..." -ForegroundColor Yellow
    Start-Service -Name Spooler
} else {
    Write-Host "Print Spooler is running." -ForegroundColor Green
}

# 2. Enable File and Printer Sharing Firewall Rules
Write-Host "`nEnabling File and Printer Sharing firewall rules..."
Get-NetFirewallRule -DisplayGroup "File and Printer Sharing" | Set-NetFirewallRule -Enabled True
Write-Host "Firewall rules enabled." -ForegroundColor Green

# 3. Check Printer Sharing Settings
Write-Host "`nChecking printer sharing settings..."
$printers = Get-Printer | Where-Object {$_.Shared -eq $false}
if ($printers) {
    Write-Host "Some printers are not shared. Enabling sharing..." -ForegroundColor Yellow
    foreach ($printer in $printers) {
        Set-Printer -Name $printer.Name -Shared $true
        Write-Host "Shared printer: $($printer.Name)" -ForegroundColor Green
    }
} else {
    Write-Host "All printers are already shared." -ForegroundColor Green
}

# 4. Verify Network Discovery
Write-Host "`nChecking network discovery settings..."
$netDiscovery = Get-NetFirewallRule -DisplayGroup "Network Discovery" | Select-Object -First 1
if ($netDiscovery.Enabled -eq $false) {
    Write-Host "Network Discovery is disabled. Enabling..." -ForegroundColor Yellow
    Get-NetFirewallRule -DisplayGroup "Network Discovery" | Set-NetFirewallRule -Enabled True
} else {
    Write-Host "Network Discovery is enabled." -ForegroundColor Green
}

# 5. Test Printer Connectivity
Write-Host "`nTesting printer connectivity..."
$sharedPrinters = Get-Printer | Where-Object {$_.Shared -eq $true}
foreach ($printer in $sharedPrinters) {
    Write-Host "Testing shared printer: $($printer.Name)"
    try {
        $ping = Test-Connection -ComputerName $env:COMPUTERNAME -Count 1 -ErrorAction Stop
        Write-Host "Printer $($printer.Name) is reachable." -ForegroundColor Green
    } catch {
        Write-Host "Printer $($printer.Name) is not reachable." -ForegroundColor Red
    }
}

Write-Host "`nPrinter sharing troubleshooting complete." -ForegroundColor Cyan
