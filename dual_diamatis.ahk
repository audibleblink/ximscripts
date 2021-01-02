#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\lib\helpers.ahk

#NoEnv

bullets_per_burst := 30
~LButton::fireHandler(func("dualAuto"), bullets_per_burst, 0)

#Include %A_MyDocuments%\XIM Link\Scripts\lib\bindings.ahk
