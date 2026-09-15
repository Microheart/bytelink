echo off

echo Running DISM CheckHealth...

dism /Online /Cleanup-Image /CheckHealth

echo CheckHealth Completed.

echo.



echo Running DISM ScanHealth...

dism /Online /Cleanup-Image /ScanHealth

echo ScanHealth Completed.

echo.



echo Running DISM RestoreHealth...

dism /Online /Cleanup-Image /RestoreHealth

echo Health Restoration Completed.

echo.



pause
