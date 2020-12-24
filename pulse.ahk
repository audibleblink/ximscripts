#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#NoEnv
#InstallKeybdHook
#InstallMouseHook
#MaxThreads 30
#MaxThreadsBuffer on
#KeyHistory 0
#UseHook
SendMode Input
SetDefaultMouseSpeed, 50
SetMouseDelay, 5
SetKeyDelay, -1
SetWinDelay, -1
SetBatchLines, -1
SetControlDelay -1

; Per Gun Config
rpm := 700
global stk := 6

; Advanced
ttk := stk / (rpm / 60)          ; 0.396 seconds
global bullet_time := ttk / stk * 1000  ; 0.056 seconds / 56ms

; Bindings
isEnabled := true
WheelUp::isEnabled := ! isEnabled
~LButton::main()

burst() {
    global
    Click, down
    Loop %stk% {
        Sleep %bullet_time%
    }
    Click, up
}

main() {
    global isEnabled
    if %isEnabled% {
        while GetKeyState("LButton", "P"){
            burst()
            Sleep 250
        }
    }
}

WheelDown::Suspend
