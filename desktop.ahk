#Requires AutoHotkey v2.0-a
#SingleInstance Force ; The script will Reload if launched while already running
KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability
SetKeyDelay 75
; Globals
DesktopCount := 2        ; Windows starts with 2 desktops at boot
CurrentDesktop := 1      ; Desktop count is 1-indexed (Microsoft numbers them this way)
LastOpenedDesktop := 1
NextDesktop := CurrentDesktop             ; For loop desktop

DesktopMiniCount := 2   ; keep desktop mini count at script boot.
DesktopBeforeScriptBoot := -1 ; this param will keep desktop location before script run. desktop mini count will create new desktop while switch to new desktop.

; desktop associate with background picture
AutoAssociateBackgroundWithDesktop := false
BackgroundPicPaths := [".\bgPic\1.jpg", ".\bgPic\2.jpg"]


; DLL 预加载dll库
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\VirtualDesktopAccessor.dll", "Ptr")

; DllCall 参数解释：方法，参数1类型，参数1参数值 ,参数2类型，参数2参数值,。。。。 返回值类型
global IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsWindowOnDesktopNumber", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")

global IsPinnedWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsPinnedWindow", "Ptr")
global PinWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "PinWindow", "Ptr")
global UnPinWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "UnPinWindow", "Ptr")
global IsPinnedAppProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsPinnedApp", "Ptr")
global PinAppProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "PinApp", "Ptr")
global UnPinAppProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "UnPinApp", "Ptr")

; Main

mapDesktopsFromRegistry()
OutputDebug "loading] desktops: " . DesktopCount "current:" . CurrentDesktop

initDesktopMiniCount()
; return

;
; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
; On Windows 11 the current desktop UUID appears to be in the same location
; On previous versions in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
mapDesktopsFromRegistry()
{
    global CurrentDesktop, DesktopCount, DesktopBeforeScriptBoot, NextDesktop

    ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
    IdLength := 32
    SessionId := getSessionId()
    if (SessionId) {
        CurrentDesktopId := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops", 'CurrentVirtualDesktop')
        if A_LastError != 0 {
            ; 这个注册表内容，在win11上没发现。
            CurrentDesktopId := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\" . %SessionId% . "\VirtualDesktops\CurrentVirtualDesktop")
        }
        if (CurrentDesktopId) {
            IdLength := StrLen(CurrentDesktopId)
        }
    }

    ; Get a list of the UUIDs for all virtual desktops on the system
    DesktopList := RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops', 'VirtualDesktopIDs')

    if (DesktopList) {
        DesktopListLength := StrLen(DesktopList)
        ; Figure out how many virtual desktops there are
        DesktopCount := floor(DesktopListLength / IdLength)
    }
    else {
        DesktopCount := 1
    }

    ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
    i := 0
    while (CurrentDesktopId and i < DesktopCount) {
        StartPos := (i * IdLength) + 1
        DesktopIter := SubStr(DesktopList, StartPos, IdLength)
        OutputDebug "The iterator is pointing at " . DesktopIter . "and count is" i

        ; Break out if we find a match in the list. If we didn't find anything, keep the
        ; old guess and pray we're still correct :-D.
        if (DesktopIter = CurrentDesktopId) {
            CurrentDesktop := i + 1
            OutputDebug "Current desktop number is " . CurrentDesktop . "with an ID of" DesktopIter
            break
        }
        i++
    }
    DesktopBeforeScriptBoot := CurrentDesktop

    NextDesktop := CurrentDesktop + 1
    NextDesktop := (NextDesktop > DesktopCount ? NextDesktop - DesktopCount : NextDesktop)
}

;
; This functions finds out ID of current session.
;
getSessionId()
{
    try {

        ProcessId := DllCall("GetCurrentProcessId", "UInt")
        OutputDebug " Current Process Id:" . ProcessId
    } catch Error as e {

        OutputDebug "Error getting current process id:" . e.Message
        return
    }

    SessionId := 0
    try {
        ; 注意，Uint* ，后面是一个VarRef 即，&value
        DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", &SessionId)
        OutputDebug "Current Session Id: " SessionId
    } catch Error as e {

        OutputDebug "Error getting session id:" %e.Message%
        return
    }

    return SessionId
}

_switchDesktopToTarget(targetDesktop)
{
    ; Globals variables should have been updated via updateGlobalVariables() prior to entering this function
    global CurrentDesktop, DesktopCount, LastOpenedDesktop, NextDesktop

    ; Don't attempt to switch to an invalid desktop
    if (targetDesktop > DesktopCount || targetDesktop < 1 || targetDesktop == CurrentDesktop) {
        OutputDebug "[invalid] target:" targetDesktop "current:" CurrentDesktop
        return
    }

    LastOpenedDesktop := CurrentDesktop

    ; Fixes the issue of active windows in intermediate desktops capturing the switch shortcut and therefore delaying or stopping the switching sequence. This also fixes the flashing window button after switching in the taskbar. More info: https://github.com/pmb6tz/windows-desktop-switcher/pull/19
    WinActivate "ahk_class Shell_TrayWnd"

    ; Go right until we reach the desktop we want
    while (CurrentDesktop < targetDesktop) {
        Send "{LWin down}{LCtrl down}{Right down}{LWin up}{LCtrl up}{Right up}"
        CurrentDesktop++
        OutputDebug "[right] target:" targetDesktop "current:" CurrentDesktop
    }

    ; Go left until we reach the desktop we want
    while (CurrentDesktop > targetDesktop) {
        Send "{LWin down}{LCtrl down}{Left down}{Lwin up}{LCtrl up}{Left up}"
        CurrentDesktop--
        OutputDebug "[left] target: " targetDesktop "current:" CurrentDesktop
    }

    NextDesktop := CurrentDesktop + 1
    NextDesktop := (NextDesktop > DesktopCount ? NextDesktop - DesktopCount : NextDesktop)

    ; Makes the WinActivate fix less intrusive
    Sleep 50
    focusTheForemostWindow(targetDesktop)

    ; associate with background picture
    changeBackgroundWithDesktopId()
}

updateGlobalVariables()
{
    ; Re-generate the list of desktops and where we fit in that. We do this because
    ; the user may have switched desktops via some other means than the script.
    mapDesktopsFromRegistry()
}

switchDesktopByNumber(targetDesktop)
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(targetDesktop)
}

switchDesktopToLastOpened()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    updateGlobalVariables()
    _switchDesktopToTarget(LastOpenedDesktop)
}

switchDesktopToNext()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop, NextDesktop
    updateGlobalVariables()
    _switchDesktopToTarget(NextDesktop)
}

switchDesktopToRight()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1)
}

switchDesktopToLeft()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1)
}

focusTheForemostWindow(targetDesktop) {
    foremostWindowId := getForemostWindowIdOnDesktop(targetDesktop)
    if foremostWindowId != "" && isWindowNonMinimized(foremostWindowId) {
        WinActivate "ahk_id" . foremostWindowId
    }
}

isWindowNonMinimized(windowId) {
    return WinGetMinMax("ahk_id" . windowId) == -1
}

getForemostWindowIdOnDesktop(n)
{
    n := n - 1 ; Desktops start at 0, while in script it's 1

    ; winIDList contains a list of windows IDs ordered from the top to the bottom for each desktop.
    winIDList := WinGetList()
    for windowID in winIDList
    {
        windowIsOnDesktop := DllCall(IsWindowOnDesktopNumberProc, "UInt", windowID, "UInt", n)
        ; Select the first (and foremost) window which is in the specified desktop.
        OutputDebug "w->" windowIsOnDesktop
        ; //fix 这里，并不能找到=1的值。
        if (windowIsOnDesktop == 1) {
            return windowID
        }
    }
}

MoveCurrentWindowToDesktop(desktopNumber) {
    activeHwnd := WinGetControlsHwnd("A")
    DllCall(MoveWindowToDesktopNumberProc, "UInt", activeHwnd, "UInt", desktopNumber - 1)
    switchDesktopByNumber(desktopNumber)
}

MoveCurrentWindowToLastOpened() {
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    activeHwnd := WinGetControlsHwnd("A")
    DllCall(MoveWindowToDesktopNumberProc, "UInt", activeHwnd, "UInt", LastOpenedDesktop - 1)
    switchDesktopByNumber(LastOpenedDesktop)
}

MoveCurrentWindowToNext() {
    global CurrentDesktop, DesktopCount, LastOpenedDesktop, NextDesktop
    activeHwnd := WinGetControlsHwnd("A")
    DllCall(MoveWindowToDesktopNumberProc, "UInt", activeHwnd, "UInt", NextDesktop - 1)
    switchDesktopByNumber(NextDesktop)
}

;
; This function creates a new virtual desktop and switches to it
;
createVirtualDesktop()
{
    global CurrentDesktop, DesktopCount
    Send "#^d"
    DesktopCount++
    CurrentDesktop := DesktopCount
    OutputDebug "[create] desktops:" . DesktopCount . "current:" . CurrentDesktop
}

;
; This function deletes the current virtual desktop
;
deleteVirtualDesktop()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    Send "#^{F4}"
    if (LastOpenedDesktop >= CurrentDesktop) {
        LastOpenedDesktop--
    }
    DesktopCount--
    CurrentDesktop--
    OutputDebug "[delete] desktops:" . DesktopCount . "current:" . CurrentDesktop
}

changeBackgroundWithDesktopId()
{
    global CurrentDesktop, BackgroundPicPaths, AutoAssociateBackgroundWithDesktop
    filePath := BackgroundPicPaths[CurrentDesktop]
    isRelative := (substr(filePath, 1, 1) == ".")
    if (isRelative) {
        filePath := (A_WorkingDir . substr(filePath, 2))
    }
    if (AutoAssociateBackgroundWithDesktop and filePath and FileExist(filePath)) {
        DllCall("SystemParametersInfo", "UInt", 0x14, "UInt", 0, "Str", filePath, "UInt", 1)
    }
}

initDesktopMiniCount()
{
    global DeskTopMiniCount, DesktopCount, CurrentDesktop, DesktopBeforeScriptBoot
    i := DeskTopMiniCount - DesktopCount
    j := i
    while (i-- > 0) {
        createVirtualDesktop()
        OutputDebug "[initCount] DeskTopMiniCount: " . DeskTopMiniCount . "desktops:" . DesktopCount . "current:" . CurrentDesktop
    }

    if (j > 0 && DesktopBeforeScriptBoot > 0) {
        _switchDesktopToTarget(DesktopBeforeScriptBoot > DesktopCount ? DesktopCount : DesktopBeforeScriptBoot)
    }
}

_GetCurrentWindowID() {
    return WinGetID("A")
}

_GetCurrentWindowTitle() {
    return WinGetTitle("A")
}

_GetCurrentWindowProcess() {
    return WinGetProcessName("A")
}

OnTogglePinOnTopPress() {
    _notif(_GetCurrentWindowProcess(), "Toggled 'Pin On Top'")
    WinSetAlwaysOnTop -1, "A"
}

OnTogglePinWindowPress() {
    windowID := _GetCurrentWindowID()
    processName := _GetCurrentWindowProcess()
    if (_GetIsWindowPinned(windowID)) {
        _UnpinWindow(windowID)
        _notif(processName, "Unpinned Window")
    }
    else {
        _PinWindow(windowID)
        _notif(processName, "Pinned Window")
    }
}

OnTogglePinAppPress() {
    windowID := _GetCurrentWindowID()
    processName := _GetCurrentWindowProcess()
    if (_GetIsAppPinned(windowID)) {
        _UnpinApp(windowID)
        _notif(processName, "Unpinned App")
    }
    else {
        _PinApp(windowID)
        _notif(processName, "Pinned App")
    }
}

_PinWindow(windowID := "") {
    _CallWindowProc(PinWindowProc, windowID)
}

_UnpinWindow(windowID := "") {
    _CallWindowProc(UnpinWindowProc, windowID)
}

_GetIsWindowPinned(windowID := "") {
    return _CallWindowProc(IsPinnedWindowProc, windowID)
}

_PinApp(windowID := "") {
    _CallWindowProc(PinAppProc, windowID)
}

_UnpinApp(windowID := "") {
    _CallWindowProc(UnpinAppProc, windowID)
}

_GetIsAppPinned(windowID := "") {
    return _CallWindowProc(IsPinnedAppProc, windowID)
}

_CallWindowProc(proc, window := "") {
    if (window == "") {
        window := _GetCurrentWindowID()
    }
    return DllCall(proc, "UInt", window)
}

_notif(txt, title := "") {
    HideTrayTip()
    title := _TruncateString(title, 100)
    TrayTip %txt%, %title%, "Iconi Mute"
}

HideTrayTip() {
    TrayTip  ; 尝试以普通的方式隐藏它.
    if SubStr(A_OSVersion, 1, 3) = "10." {
        A_IconHidden := true
        Sleep 200  ; 可能有必要调整 sleep 的时间.
        A_IconHidden := false
    }
}

_TruncateString(string := "", n := 10) {
    return (StrLen(string) > n ? SubStr(string, 1, n - 3) . "..." : string)
}