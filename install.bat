@echo off
cls

REM Script settings:
title Installing PasteyShortcuts...
color 70
mode con: cols=50 lines=20
set "installDir=%USERPROFILE%\Documents\PasteyShortcuts"
set "startupDir=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Make install folder if it doesn't exist
IF NOT EXIST %installDir% (
	echo.
	echo Making PasteyShortcuts folder...
	mkdir %installDir%
)

REM Kill PasteyShortcuts.exe if it's running
tasklist /FI "IMAGENAME eq PasteyShortcuts.exe" 2>NUL | find /I /N "PasteyShortcuts.exe">NUL
if "%ERRORLEVEL%"=="0" (
	echo.
	echo Closing open instances of PasteyShortcuts...
	taskkill /F /IM PasteyShortcuts.exe
)

echo.
echo Installing files...
copy PasteyShortcuts.exe %installDir%\PasteyShortcuts.exe
copy PasteyShortcuts.ini %installDir%\PasteyShortcuts.ini

echo.
echo Adding to startup...
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%startupDir%\PasteyShortcuts.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%installDir%\PasteyShortcuts.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%


echo.
echo Starting app...
start "" "%installDir%\PasteyShortcuts.exe"

echo.
echo.
echo Done! Press any key to quit...
pause>nul