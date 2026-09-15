# Backup C Drive using PowerShell + Robocopy
# Change $backupPath to your desired destination

$sourcePath = "C:\"
$backupPath = "D:\BackupCDrive"

# Create destination folder if it doesn't exist
if (!(Test-Path -Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath
}

# Run Robocopy to mirror C:\ into backup folder
# /MIR = Mirror (adds new files, removes deleted ones)
# /R:2 = Retry 2 times on failure
# /W:5 = Wait 5 seconds between retries
# /LOG = Save log file for review
# /XA:SH = Exclude system/hidden files (optional)
# /XF pagefile.sys hiberfil.sys = Exclude system files

$logFile = "D:\BackupCDrive\BackupLog.txt"

robocopy $sourcePath $backupPath /MIR /R:2 /W:5 /XA:SH /XF pagefile.sys hiberfil.sys /LOG:$logFile
