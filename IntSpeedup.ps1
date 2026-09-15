<# 
Internet Speed Booster Script
Author: TechSecure Solutions
Purpose: Optimize Windows network performance
Run as Administrator
#>

Write-Host "Starting Internet Speed Optimization..." -ForegroundColor Cyan

# 1. Clear DNS Cache
Write-Host "`nClearing DNS cache..."
ipconfig /flushdns
Write-Host "DNS cache cleared." -ForegroundColor Green

# 2. Reset Winsock and TCP/IP
Write-Host "`nResetting Winsock and TCP/IP..."
netsh winsock reset
netsh int ip reset
Write-Host "Network stack reset complete." -ForegroundColor Green

# 3. Optimize TCP parameters
Write-Host "`nOptimizing TCP settings..."
netsh interface tcp set global autotuning=normal
netsh interface tcp set global chimney=enabled
netsh interface tcp set global rss=enabled
netsh interface tcp set global ecncapability=disabled
netsh interface tcp set global timestamps=disabled
Write-Host "TCP optimization applied." -ForegroundColor Green


# 4. Quick Ping Test
Write-Host "`nRunning quick ping test..."
$ping = Test-Connection -ComputerName google.com -Count 4 | Measure-Object ResponseTime -Average
Write-Host "Average Ping: $($ping.Average) ms" -ForegroundColor Yellow

Write-Host "`nInternet optimization complete. Restart your PC for best results." -ForegroundColor Cyan
