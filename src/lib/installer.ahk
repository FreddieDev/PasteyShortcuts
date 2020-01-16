#SingleInstance Force
#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Font, s10 Norm
Gui Add, Button, x465 y253 w80 h27, Install
Gui Font
Gui Add, CheckBox, x138 y107 w27 h0, CheckBox
Gui Font, s10
Gui Add, CheckBox, x23 y69 w255 h21 vRunOnStartup +Checked, Run on startup
Gui Font
Gui Font, s14 Bold, Trebuchet MS
Gui Add, Text, hWndhTxt x12 y9 w471 h26 +0x200, Thanks for downloading PasteyShortcuts!
Gui Font
Gui Font, s10
Gui Add, Link, x19 y37 w465 h18 +0x200, Review the <a href="https://github.com/FreddieDev/PasteyShortcuts/blob/master/README.md">readme</a> for tips and help...
Gui Font
Gui Add, Text, x37 y88 w400 h23 +0x200, Automatically starts PasteyShortcuts when you login (recommended)

Gui Show, w559 h299, PasteyShortcuts installer
Return

GuiEscape:
GuiClose:
    ExitApp

ButtonInstall:
	Gui Submit ; Update variables
	
	parameters := " "
	
	if (RunOnStartup)
		parameters := parameters . "runOnStartup "
	
	RunWait install.bat %parameters%
	
	MsgBox,0,PasteyShortcuts installation, Install completed!
	
	ExitApp
