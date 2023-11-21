#Requires AutoHotkey v2.0-a
#SingleInstance Force ; The script will Reload if launched while already running
KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory
SendMode "Input" ; Recommended for new scripts due to its superior speed and reliability

#Include %A_ScriptDir%\common.ahk
#Include %A_ScriptDir%\desktop.ahk
#Include %A_ScriptDir%\shortcut.ahk
#Include %A_ScriptDir%\shortcutWithContext.ahk

#HotIf WinActive("my-windows-shortcut-operation")
#s:: {
    Send "{^s}" ; save the script .
    MsgBox , "Save & Reload ", "16T0.4"
    Reload
}
#HotIf

#c:: CloseChrome()

return