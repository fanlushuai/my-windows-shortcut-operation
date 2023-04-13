; 在vscode中使用vim键位，通过esc切换到normal模式的时候，希望输入法切换到英文。
#IfWinActive ahk_exe Code.exe

    !j::NumpadDown

    !k::NumpadUp

    ~Esc::
        Send, ^{F8} ; 此按键为，搜狗输入法激活*中文*输入法按键。
        Send, {Shift}
    Return

#IfWinActive

;; 切换翻译窗口。在utool上快捷键设置的为ctrl+alt+q，然后其没有提供最小化的功能
#IfWinActive ahk_exe uTools.exe
    ^!q::!Esc
#IfWinActive

#IfWinActive ahk_exe chrome.exe ; 配合地址栏，和搜索栏，以及surfingkeys。使用ctrl+n 和p 来切换下拉菜单

    ^n::Send , {Down}

    ^p::Send , {Up}

    ~Esc:: 
        Send, {Esc 2} ; 两次Esc，从地址栏回到页面选中
    Return
#IfWinActive ; 关闭上下文敏感
