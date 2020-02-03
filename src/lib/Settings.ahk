class Settings {
	Change() {
		global
		Gui, Destroy ; Close existing windows
		
		Gui, Add, Text,, Email address:
		Gui, Add, Edit, vEmailAddress w200, %EmailAddress%

		Gui, Add, Text,, Employee number:
		Gui, Add, Edit, vEmployeeNumber w110, %EmployeeNumber%
		

		Gui, Add, Text,,
		Gui, Add, Checkbox, Checked%UseClipboardTrimmer% vUseClipboardTrimmer, One-word clipboard trimming
		Gui, Add, Checkbox, Checked%UseMediaControls% vUseMediaControls, Enable media control hotkeys
		Gui, Add, Checkbox, Checked%UseBrightnessControls% vUseBrightnessControls, Enable brightness control hotkeys

		Gui, Add, Link,, Click <a href="https://github.com/FreddieDev/PasteyShortcuts/blob/master/README.md#welcome-to-pasteyshortcuts">here</a> for a list of hotkeys
		

		; Save button
		gui, Add, Text, section
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
		IniWrite, %UseClipboardTrimmer%, %SettingsName%, Hotkeys, UseClipboardTrimmer
	}

	Load() {
		global
		
		; Load settings into global variables
		; Format: Output variable, config file, settings category, setting name, default value
		IniRead, EmailAddress, %SettingsName%, Details, EmailAddress, %EmailAddress%
		IniRead, EmployeeNumber, %SettingsName%, Details, EmployeeNumber, %EmployeeNumber%
		IniRead, UseMediaControls, %SettingsName%, Hotkeys, UseMediaControls, %UseMediaControls%
		IniRead, UseBrightnessControls, %SettingsName%, Hotkeys, UseBrightnessControls, %UseBrightnessControls%
		IniRead, UseClipboardTrimmer, %SettingsName%, Hotkeys, UseClipboardTrimmer, %UseClipboardTrimmer%
	}
}