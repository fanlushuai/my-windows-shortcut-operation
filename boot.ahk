#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

#Include %A_ScriptDir%\common.ahk
#Include %A_ScriptDir%\desktop.ahk
#Include %A_ScriptDir%\shortcut.ahk

return