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

cmd(cmdStr) {
    Run A_ComSpec ' /c' cmdStr, , 'Hide'
}

setTimeTo9_8_0() {
    cmd 'date 2024-09-08 && time 00:00:00.00'
}

setTimeToBeijingTime() {
    cmd 'net start w32time'
    Sleep 1000
    cmd 'w32tm /resync'

    OutputDebug "setTimeToBeijingTime"
}


; 1:: setTimeToBeijingTime()

; 2:: setTimeTo9_8_0()
