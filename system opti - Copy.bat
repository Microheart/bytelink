@echo off
echo Cleaning and optimizing your PC...
echo.

:: Clearing temporary files
echo Clearing temporary files...
del /q/f/s %temp%\*.*
del /q/f/s %systemroot%\temp\*.*
echo Temporary files cleared.
echo.

:: Deleting Internet Explorer/Edge temporary files
echo Clearing Internet Explorer/Edge temporary files...
del /q/f/s %systemroot%\Temp\*.*
del /q/f/s %systemroot%\System32\dllcache\*.*
echo Internet Explorer temporary files cleared.
echo.

:: Deleting Windows update cache
echo Clearing Windows update cache...
net stop wuauserv
del /q/f/s %systemroot%\SoftwareDistribution\*.*
net start wuauserv
echo Windows update cache cleared.
echo.


:: Checking disk errors
echo Checking disk errors...
chkdsk /f /r
echo Disk errors checked and repaired if any.
echo.


:: Running System File Checker
echo Running System File Checker...
sfc /scannow
echo System File Checker completed.
echo.

echo Cleaning and optimization completed. Your PC should perform better now.
pause

--------------------