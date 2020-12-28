#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk


;; 180 Turn on "s" doubletap
s::
 {
   XIMInputData("LeftStickDirectional",180)
   KeyWait, s
   XIMInputData("LeftStickDirectional", -1)
   KeyWait, s, D T1
   If (!ErrorLevel)
    {
        XIMInputData("RightStickDirectional",90)
        Sleep 260
        XIMInputData("RightStickDirectional", -1)
    }
}
return

is_sliding := 0
should_cancel := 1

; Slide Cancel
~LCtrl::
   {
      sprint := "Button1" ;; LS click
      crouch := "Button2" ;; B
      ; 0 = release
      ; 1 = pressed
      if (!is_sliding)  {
         ; begin sprint
         XIMInputData(sprint, 1)
         Sleep 40

         XIMInputData(crouch, 1)
         Sleep 40
         XIMInputData(crouch, 0)
         Sleep 40

         is_sliding = 1

         KeyWait, LCtrl, D T.5

         ;; sliding timed out in game
         if (ErrorLevel) {
            XIMInputData(sprint, 0)
            should_cancel = 0
         }
      }
   }
return

~LCtrl up::
   {
      sprint := "Button1" ;; LS click
      crouch := "Button2" ;; B
      if (should_cancel) {
         ; cancel by pressing crouch again
         XIMInputData(crouch, 1)
         Sleep 40
         XIMInputData(crouch, 0)
         Sleep 40
      }
      is_sliding = 0
      should_cancel = 1
   }
return

; p::
; {

;          XIMInputData("Button1", 1)
;          sleep 50
;          XIMInputData("Button1", 0)
;          sleep 50
; }
; return

; l::
; {

;          XIMInputData("Button2", 1)
;          sleep 50
;          XIMInputData("Button2", 0)
;          sleep 50
; }
; return