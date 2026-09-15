# Save this as Run-Bootrec.ps1
# Run PowerShell as Administrator

Write-Host "Running Bootrec /FixMbr..."
bootrec /FixMbr

Write-Host "Running Bootrec /FixBoot..."
bootrec /FixBoot

Write-Host "Running Bootrec /ScanOs..."
bootrec /ScanOs

Write-Host "Running Bootrec /RebuildBcd..."
bootrec /RebuildBcd

Write-Host "All Bootrec commands executed successfully."
