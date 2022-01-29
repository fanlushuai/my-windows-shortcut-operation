; start or active or minimize 处理常见软件的，启动，激活窗口，和最小化。
callSoft(winUnique,proc,executablePath){
	If WinExist(winUnique) 
    {
        if WinActive(winUnique)
            WinMinimize ; Use the window found by WinExist. 注意！！！必须在前面使用一次winexist
        else
            WinActivate ; Use the window found by WinExist.
        return
    }
    
    if !ProcessExist(proc){
        Run %executablePath% ;
    }
    ; win not exist 的情况不知道怎么回事。
}

; 自动输入gg 关键字。充当全局网页搜索框
keyfunc_listary(){
    ; Send ctrl+space (the default hotkey of Listary) to activate Listary
    sendinput, ^{Space}

    ; Wait until Listary is activated
    winwait, ahk_exe Listary.exe, , 0.8

    ; {Text} will ignore IME 忽略输入法问题
    Send, {Text}gg
	Send, {Space}
}

SwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}