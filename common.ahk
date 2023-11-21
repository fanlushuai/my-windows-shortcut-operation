#Requires AutoHotkey v2.0-a
; start or active or minimize 处理常见软件的，启动，激活窗口，和最小化。
; 在使用过程中，会存在迷惑行为。未搞清楚原因。目前某种情况会有bug

SetKeyDelay 0
SetWinDelay 200

; https://www.autohotkey.com/boards/viewtopic.php?t=59082#:~:text=What%20if%20you-,use%20the%20Click%20command,-to%20activate%20the
callSoft(winUnique, proc, executablePath) {
    If WinExist(winUnique)
    {
        if WinActive(winUnique) {
            ; WinMinimize ; Use the window found by WinExist. sometimes occur a bug windows active but also min
            SendInput "!{Esc}" ; open last active . but if last is not exist???? haha ,maybe wont occur
        } else {
            WinActivate ; Use the window found by WinExist.
        }

        ; Click ;
        return
    }
    if (PID := ProcessExist(proc)) {
        Run %executablePath% ;
    } else {
        Run %executablePath% ; win not exist 的情况不知道怎么回事。程序已经运行了。只是窗口没有。只能先通过这种方式，调出主窗口了。但是这存在一个问题，可能会调出来两次。
    }
}

; 自动输入gg 关键字。充当全局网页搜索框
keyfunc_listary() {
    ; Send ctrl+space (the default hotkey of Listary) to activate Listary
    sendinput "^{Space}"

    ; Wait until Listary is activated
    WinWait "ahk_exe Listary.exe", , 0.8

    ; {Text} will ignore IME 忽略输入法问题
    Send "{Text}gg"
    Send "{Space}"
}

; SwitchIME(dwLayout) {
;     HKL := DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
;     ControlGetFocus("A")
;     SendMessage 0x50, 0, HKL, %ctl%, A
; }

ToEnglishWithSoug() {
    Send "^{F8}" ; 此按键为，搜狗输入法激活*中文*输入法按键。
    Send "{Shift}"
}

CloseChrome() {
    SetTitleMatchMode 2
    WinClose "Google Chrome"
    WinClose "Google Chrome"
    WinClose "Google Chrome"
    WinClose "Google Chrome"
    WinClose "Google Chrome"
    WinClose "Google Chrome"
}