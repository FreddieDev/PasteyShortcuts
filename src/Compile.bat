@echo off
title PasteyShortcuts compiler...
cls

echo Recompiling initiated

echo Killing apps...
taskkill /F /IM installer.exe
taskkill /F /IM uninstaller.exe
taskkill /F /IM PasteyShortcuts.exe

echo.
echo Recompiling PasteyShortcuts...
start "" "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "PasteyShortcuts.ahk"

echo Recompiling installer...
start "" "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "lib\uninstaller.ahk"

echo Recompiling uninstaller...
start "" "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "lib\installer.ahk"

echo.
echo.
echo Recompile finished!
echo Press any key to exit...
pause>nul