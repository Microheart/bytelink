# Windows Boot Optimization Script
# Author: ByteLink
# Purpose: Reduce boot time by disabling delays, cleaning temp files, and optimizing services

# Create log file
$LogFile = "C:\BootOptimizationLog.txt"
Add-Content $LogFile "`n=== Boot Optimization Run: $(Get-Date) ==="

# 1. Remove Startup Delay
Try {
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" `
    -Name "StartupDelayInMSec" -Value 0 -PropertyType DWord -Force
    Add-Content $LogFile "Startup delay disabled successfully."
} Catch {
    Add-Content $LogFile "Failed to disable startup delay: $_"
}

# 2. Enable Fast Startup
Try {
    powercfg /hibernate on
    Add-Content $LogFile "Fast Startup enabled."
} Catch {
    Add-Content $LogFile "Failed to enable Fast Startup: $_"
}

# 3. Clean Temporary Files
Try {
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Add-Content $LogFile "Temporary files cleaned."
} Catch {
    Add-Content $LogFile "Failed to clean temp files: $_"
}

# 4. Optimize Services (example: SysMain)
Try {
    Set-Service -Name "SysMain" -StartupType Manual
    Add-Content $LogFile "SysMain service set to Manual."
} Catch {
    Add-Content $LogFile "Failed to adjust SysMain service: $_"
}

Add-Content $LogFile "Boot optimization completed."
