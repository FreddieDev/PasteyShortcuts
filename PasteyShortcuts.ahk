#Persistent  ; Keep the script running until the user exits it.
#SingleInstance force ; Only allow one instance of this script and don't prompt on replace
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SettingsName := "PasteyShortcuts.ini"

; Global vars (leave empty)
EmailAddress :=
EmployeeNumber :=
EmailAddressKey :=

; Cleanup tray menu items
Menu, Tray, NoStandard

; Add option to reload the current script (in case changes were made)
MenuReloadScriptText := "Reload script"
Menu, Tray, Add, %MenuReloadScriptText%, MenuHandler

; Add option to exit the current script
MenuExitScriptText := "Exit script"
Menu, Tray, Add, %MenuExitScriptText%, MenuHandler

; Change the tray icon
GEAR_CHECKLIST_ICON := 110
Menu, Tray, Icon, imageres.dll, %GEAR_CHECKLIST_ICON%


FirstTimeSetup(SettingsName) {
	InputBox, EmailAddress, PasteyShortcuts, Enter your email address,,310,150
	InputBox, EmployeeNumber, PasteyShortcuts, Enter your employee number (leave blank to disable # hotkey),,310,150
	
	; Write user's settings
	IniWrite, %EmailAddress%, %SettingsName%, Details, EmailAddress
	IniWrite, %EmployeeNumber%, %SettingsName%, Details, EmployeeNumber
	
	; Write default hotkeys
	IniWrite, @, %SettingsName%, Hotkeys, PasteEmailAddress
	IniWrite, #, %SettingsName%, Hotkeys, PasteEmployeeNumber
}

; If setting file doesn't exist run first time setup
if (!FileExist(SettingsName)) {
	MsgBox, %SettingsName% not found!
	FirstTimeSetup(SettingsName)
}

; Load settings into global variables
IniRead, EmailAddress, %SettingsName%, Details, EmailAddress
IniRead, EmployeeNumber, %SettingsName%, Details, EmployeeNumber
IniRead, EmailAddressKey, %SettingsName%, Hotkeys, PasteEmailAddress
IniRead, EmployeeNumberKey, %SettingsName%, Hotkeys, PasteEmployeeNumber


; Re-run first time setup until user settings are valid
while (EmailAddress = "") {
	FirstTimeSetup(SettingsName)
}

; Register hotkeys
Hotkey, ~$%EmailAddressKey%, EmailAddressKeyHandler
Hotkey, ~$%EmployeeNumberKey%, EmployeeNumberKeyHandler


return ; Stop handlers running on script start


MenuHandler:
	if (A_ThisMenuItem = MenuReloadScriptText) {
		Reload
		return
	} else if (A_ThisMenuItem = MenuExitScriptText) {
		ExitApp
	}

	return
	

; CTRL + ALT + SPACE to pause media
^!Space::
	Send {Media_Play_Pause}
	return

; CTRL+ALT+Left arrow for media previous
^!Left::
	Send {Media_Prev
	return
	
; CTRL+ALT+Left arrow for media next
^!Right::
	Send {Media_Next}
	return


; Press @ twice to paste email
EmailAddressKeyHandler:
	KeyWait, @, U
	KeyWait, @, D, T0.2
	If (ErrorLevel = 0)
	send, {backspace 2}%EmailAddress%
	return
	
; Press # twice to paste employee number
EmployeeNumberKeyHandler:
	KeyWait, #, U
	KeyWait, #, D, T0.2
	If (ErrorLevel = 0)
	send, {backspace 2}%EmployeeNumber%
	return