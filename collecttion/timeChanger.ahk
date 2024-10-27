#Requires AutoHotkey v2.0

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}


setTimeTo9_8_0() {
    Run A_ComSpec ' /c date 2024-09-08 && time 00:00:00.00', , 'Hide'
    OutputDebug "setTimeTo980"
}

setTimeToBeijingTime() {
    Run A_ComSpec ' /c net start w32time', , 'Hide'
    Run A_ComSpec ' /c w32tm /resync', , 'Hide'
    OutputDebug "setTimeToBeijingTime"
}


; 1:: setTimeToBeijingTime()

; 2:: setTimeTo9_8_0()