#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\lib\helpers.ahk

#NoEnv

;; Configuration Variables
gun_id := "tundra"
IniRead, ads, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, ads

LButton::quickscope(ads)

#Include %A_MyDocuments%\XIM Link\Scripts\lib\bindings.ahk
