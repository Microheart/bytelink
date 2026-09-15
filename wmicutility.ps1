<# 
   MicroHeart - AMC Client PC Health Report
    Runs WMIC checks for CPU, Disk, BIOS, and OS
    Outputs structured dashboard-style results
#>

Write-Host "===== AMC Client PC Health Report =====" -ForegroundColor Cyan

# CPU Info
Write-Host "`n--- CPU Information ---" -ForegroundColor Yellow
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors /format:list

# Disk Status
Write-Host "`n--- Disk Health ---" -ForegroundColor Yellow
wmic diskdrive get Model,Status,Size /format:list

# BIOS Serial Number
Write-Host "`n--- BIOS Information ---" -ForegroundColor Yellow
wmic bios get Manufacturer,Name,SerialNumber,Version /format:list

# Operating System
Write-Host "`n--- Operating System ---" -ForegroundColor Yellow
wmic os get Caption,Version,OSArchitecture,LastBootUpTime /format:list

# Network Adapter
Write-Host "`n--- Network Adapter ---" -ForegroundColor Yellow
wmic nic where "NetEnabled=true" get Name,MACAddress /format:list

Write-Host "`n===== End of Report =====" -ForegroundColor Cyan
