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
bullets_per_burst := 3
sleep_btwn_bursts := 250

; Bindings
isEnabled := true
WheelUp::isEnabled := ! isEnabled
WheelDown::Suspend
~LButton::main(bullets_per_burst, sleep_btwn_bursts)

main(times, rest) {
    global isEnabled
    if %isEnabled% {
        while GetKeyState("LButton", "P"){
            autofire(times)
            Sleep rest
        }
    }
}
