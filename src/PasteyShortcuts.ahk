#Persistent  ; Keep the script running until the user exits it.
#SingleInstance force ; Only allow one instance of this script and don't prompt on replace
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include lib\Settings.ahk



; Global vars (leave empty)
global EmailAddress :=
global EmployeeNumber :=
global EmailAddressKey :=
global EmployeeNumberKey :=
global UseMediaControls :=

; Vars
SettingsName := "PasteyShortcuts.ini"

; Cleanup tray menu items
Menu, Tray, Tip, PasteyShortcuts
Menu, Tray, NoStandard

; Add change settings button
MenuChangeSettingsText := "Change settings"
Menu, Tray, Add, %MenuChangeSettingsText%, MenuHandler

; Creates a separator line
Menu, Tray, Add

; Add option to reload the current script (in case changes were made)
MenuReloadScriptText := "Restart"
Menu, Tray, Add, %MenuReloadScriptText%, MenuHandler
Menu, Tray, Default, %MenuReloadScriptText%

; Add option to exit the current script
MenuExitScriptText := "Exit"
Menu, Tray, Add, %MenuExitScriptText%, MenuHandler

; Change the tray icon
GEAR_CHECKLIST_ICON := 110
Menu, Tray, Icon, imageres.dll, %GEAR_CHECKLIST_ICON%



; If setting file doesn't exist run first time setup
if (!FileExist(SettingsName)) {
	MsgBox, Thanks for downloading my tool! To use it, you must enter your details...
	Settings.Change()
} else {
	Settings.Load()
}

; Load hotkeys into global variables
IniRead, EmailAddressKey, %SettingsName%, Hotkeys, PasteEmailAddress
IniRead, EmployeeNumberKey, %SettingsName%, Hotkeys, PasteEmployeeNumber

; Register hotkeys
Hotkey, ~$%EmailAddressKey%, EmailAddressKeyHandler
if (StrLen(EmployeeNumber) != 0) { ; Only register employee number if a valid string is set
	Hotkey, ~$%EmployeeNumberKey%, EmployeeNumberKeyHandler
}

; Register media keys
if (UseMediaControls) {
	Hotkey, ^!Space, Media_Play_Pause_Handler ; CTRL+ALT+SPACE play/pause
	Hotkey, ^!Left, Media_Prev_Handler ; CTRL+ALT+SPACE previous song
	Hotkey, ^!Right, Media_Next_Handler ; CTRL+ALT+RIGHT next song
	Hotkey, ^!Up, Media_VolUp_Handler ; CTRL+ALT+UP volume increase
	Hotkey, ^!Down, Media_VolDown_Handler ; CTRL+ALT+DOWN volume decrease
}


return ; Stop handlers running on script start


GuiClose:
	Gui, Destroy
	return

ButtonSave:
	Gui, Submit, NoHide ; Save the input from the user to each control's associated variable.
	
	; Re-run setup until user settings are valid
	if (StrLen(EmailAddress) < 3) {
		MsgBox, Invalid email address entered!
		return
	}
	
	Settings.Save()
	MsgBox, Setup complete! Double press %EmailAddressKey% to paste your email or %EmployeeNumberKey% to paste your employee number!
	Gui, Destroy
	
	
	; Restart script to load changed hotkeys
	Reload
	
	return


MenuHandler:
	if (A_ThisMenuItem = MenuReloadScriptText) {
		Reload
		return
	} else if (A_ThisMenuItem = MenuExitScriptText) {
		ExitApp
	} else if (A_ThisMenuItem = MenuChangeSettingsText) {
		Settings.Change()
	}

	return
	

; Media key senders
Media_Play_Pause_Handler:
	Send, {Media_Play_Pause}
	return
Media_Prev_Handler:
	Send {Media_Prev}
	return
Media_Next_Handler:
	Send {Media_Next}
	return
Media_VolUp_Handler:
	; SoundSet, +6 ; Customisable but doesn't show Windows volume OSD
	Send {Volume_Up}
	return
Media_VolDown_Handler:
	Send {Volume_Down}
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
