class Settings {
	Change() {
		global
		Gui, Destroy ; Close existing windows
		
		Gui, Add, Text,, Email address:
		Gui, Add, Edit, vEmailAddress w200, %EmailAddress%

		Gui, Add, Text,, Employee number:
		Gui, Add, Edit, vEmployeeNumber w110, %EmployeeNumber%
		
		Gui, Add, Text,,
		if (UseMediaControls)
			Gui, Add, Checkbox, Checked vUseMediaControls, Enable media control hotkeys
		else
			Gui, Add, Checkbox, vUseMediaControls, Enable media control hotkeys
		
		
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
		IniWrite, @, %SettingsName%, Hotkeys, PasteEmailAddress
		IniWrite, #, %SettingsName%, Hotkeys, PasteEmployeeNumber
	}

	Load() {
		global
		
		; Load settings into global variables
		IniRead, EmailAddress, %SettingsName%, Details, EmailAddress
		IniRead, EmployeeNumber, %SettingsName%, Details, EmployeeNumber
		IniRead, UseMediaControls, %SettingsName%, Hotkeys, UseMediaControls
	}
}