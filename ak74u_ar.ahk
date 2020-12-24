#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\util.ahk

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

;; Configuration Variables
gun_id := "ak74u"
pull_x := -30
pull_y := 60

; shouldn't need to change from here down
INIRead, burst_sleep, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, constants, burst_sleep
INIRead, health, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, constants, health
config := build_config(gun_id)
gun := new Weapon(config, health)

MsgBox, % gun.TTK

; Bindings
is_enabled := true
WheelUp::is_enabled := ! is_enabled
WheelDown::Suspend
~LButton::main(gun, burst_sleep)

; Functions
main(weapon, burst_sleep) {
    global is_enabled, pull_x, pull_y
    if %is_enabled% {
        while GetKeyState("LButton", "P") {
            burstAR(weapon, pull_x, pull_y)
            Sleep burst_sleep
        }
    }
}