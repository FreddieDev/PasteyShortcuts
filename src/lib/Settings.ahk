class Settings {
	Change() {
		global
		Gui, Destroy ; Close existing windows
		
		Gui, Add, Text,, Email address:
		Gui, Add, Edit, vEmailAddress w200, %EmailAddress%

		Gui, Add, Text,, Employee number:
		Gui, Add, Edit, vEmployeeNumber w110, %EmployeeNumber%
		
		Gui, Add, Text,,
		Gui, Add, Checkbox, Checked%UseMediaControls% vUseMediaControls, Enable media control hotkeys
		Gui, Add, Checkbox, Checked%UseBrightnessControls% vUseBrightnessControls, Enable brightness control hotkeys

		Gui, Add, Link,, Click <a href="https://github.com/FreddieDev/PasteyShortcuts/blob/master/README.md#welcome-to-pasteyshortcuts">here</a> for a list of hotkeys
		
		; Save button
		gui, add, text, section
		Gui, Add, Button, xm Center x140 h27 w70, Save

		gui, show,, PasteyShortcuts Settings
	}

	Save() {
		global
		
		; Strip unneeded characters
		EmailAddress := Trim(EmailAddress)
		EmployeeNumber := Trim(EmployeeNumber)
		
		; Write user's settings
		IniWrite, %EmailAddress%, %SettingsName%, Details, EmailAddress
		IniWrite, %EmployeeNumber%, %SettingsName%, Details, EmployeeNumber
		
		; Write default hotkeys
		IniWrite, %UseMediaControls%, %SettingsName%, Hotkeys, UseMediaControls
		IniWrite, %UseBrightnessControls%, %SettingsName%, Hotkeys, UseBrightnessControls
		IniWrite, @, %SettingsName%, Hotkeys, PasteEmailAddress
		IniWrite, #, %SettingsName%, Hotkeys, PasteEmployeeNumber
	}

	Load() {
		global
		
		; Load settings into global variables
		IniRead, EmailAddress, %SettingsName%, Details, EmailAddress
		IniRead, EmployeeNumber, %SettingsName%, Details, EmployeeNumber
		IniRead, UseMediaControls, %SettingsName%, Hotkeys, UseMediaControls
		IniRead, UseBrightnessControls, %SettingsName%, Hotkeys, UseBrightnessControls
	}
}