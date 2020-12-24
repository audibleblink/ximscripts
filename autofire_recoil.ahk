#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#NoEnv
#InstallKeybdHook
#InstallMouseHook
SetDefaultMouseSpeed, 0
SetMouseDelay, -1
SetKeyDelay, -1
SetWinDelay, -1
SetBatchLines, -1
SetControlDelay -1
#MaxThreads 30
#MaxThreadsBuffer on
#KeyHistory 0
SendMode Input
#UseHook

_auto := true

~LButton::autofire()
WheelUp::_auto := ! _auto

autofire() {
    global _auto
    if _auto {
        Loop {
            if GetKeyState("LButton", "P") {
                SendInput {LButton DownTemp}
                Sleep 46
                mouseXY(0, 5)
                SendInput {LButton Up}
                Sleep 44
            }
            else
            break
        }
    }
}

mouseXY(x,y) {
    DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
}

;WheelDown::Suspend
