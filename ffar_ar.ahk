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

; Constants
health := 150
burst_sleep := 300

; Per Gun Config
;; AK74u
rpm := 909
damage := 28

; Values
global shots_to_kill := health / damage
time_to_kill := shots_to_kill / (rpm / 60)
global bullet_duration := time_to_kill / shots_to_kill * 1000 ;to milliseconds

; Functions
main() {
    global isEnabled, burst_sleep
    if %isEnabled% {
        while GetKeyState("LButton", "P") {
            burst()
            Sleep %burst_sleep%
        }
    }
}

burst() {
    global
    Click, down
    Loop %shots_to_kill% {
        Sleep %bullet_duration%
        mouseXY(-65, 225)
    }
    Click, up
}

mouseXY(x,y) {
    DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
    Sleep 1
}

; Bindings
isEnabled := true
WheelUp::isEnabled := ! isEnabled
~LButton::main()

WheelDown::Suspend
