#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#NoEnv
#InstallKeybdHook
#InstallMouseHook
#MaxThreads 30
#MaxThreadsBuffer on
#KeyHistory 0
#UseHook
SendMode Input
SetDefaultMouseSpeed, 0
SetMouseDelay, 10
SetKeyDelay, -1
SetWinDelay, -1
SetBatchLines, -1
SetControlDelay -1

; Per Gun Config
rpm := 909
global stk := 6

; Advanced
ttk := stk / (rpm / 60)          ; 0.396 seconds
global bullet_time := ttk / stk * 1000  ; 0.056 seconds / 56ms

; Bindings
isEnabled := true
WheelUp::isEnabled := ! isEnabled
~LButton::burst()

burst() {
    global
    if isEnabled {
        Click, down
        Loop %stk% {
            Sleep %bullet_time%
            MouseMove -125, -100, , R
        }
        Click, up
    }
}

WheelDown::Suspend