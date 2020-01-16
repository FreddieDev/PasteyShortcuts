@echo off
cls

REM Script settings:
title Uninstalling PasteyShortcuts...
color 70
mode con: cols=50 lines=20
set "installDir=%USERPROFILE%\Documents\PasteyShortcuts"
set "startupDir=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

echo.
echo Stopping app...
taskkill /F /IM  PasteyShortcuts.exe

echo.
echo Removing from startup...
del "%startupDir%\PasteyShortcuts.lnk"

echo.
echo Removing PasteyShortcuts files...
rmdir %installDir% /S /Q


REM echo.
REM echo.
REM echo Done! Press any key to quit...
REM pause>nul