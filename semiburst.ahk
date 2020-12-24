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
rpm := 675
global stk := 6

; Advanced
ttk := stk / (rpm / 60)
global bullet_time := ttk / stk * 1000

; Bindings
isEnabled := true
WheelUp::isEnabled := ! isEnabled
WheelDown::Suspend
~LButton::main()

burst() {
    global
    Loop 3 {
        if GetKeyState("LButton", "P") {
            Click, down
            Sleep %bullet_time%
            Click, up
            Sleep %bullet_time%
        }
    }
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

