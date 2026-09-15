# Computer Configuration Dashboard Script (Fixed Version)
# Shows system details in color-coded sections

function Show-Section($Title, $Color="Cyan") {
    Write-Host "`n===== $Title =====" -ForegroundColor $Color
}

# --- System Info ---
Show-Section "System Info" "Yellow"
Get-ComputerInfo | Select-Object CsName, OsName, OsArchitecture, WindowsVersion, BiosManufacturer, BiosVersion | Format-List

# --- CPU Info ---
Show-Section "CPU Info" "Green"
Get-CimInstance Win32_Processor | 
    Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed | 
    Format-Table -AutoSize

# --- RAM Info ---
Show-Section "RAM Info" "Magenta"
Get-CimInstance Win32_PhysicalMemory | 
    Select-Object Manufacturer, Speed, @{Name="Capacity(GB)";Expression={[math]::Round($_.Capacity/1GB,2)}} | 
    Format-Table -AutoSize

# --- Disk Info ---
Show-Section "Disk Info" "Blue"
Get-CimInstance Win32_DiskDrive | 
    Select-Object Model, InterfaceType, @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}} | 
    Format-Table -AutoSize

# --- Operating System Info ---
Show-Section "Operating System Info" "Cyan"
Get-CimInstance Win32_OperatingSystem | 
    Select-Object Caption, Version, BuildNumber, OSArchitecture, @{Name="LastBootUpTime";Expression={$_.LastBootUpTime}} | 
    Format-Table -AutoSize

# --- GPU Info ---
Show-Section "GPU Info" "Red"
Get-CimInstance Win32_VideoController | 
    Select-Object Name, @{Name="VRAM(GB)";Expression={[math]::Round($_.AdapterRAM/1GB,2)}}, DriverVersion | 
    Format-Table -AutoSize

Write-Host "`nDashboard complete!" -ForegroundColor White -BackgroundColor DarkGreen
