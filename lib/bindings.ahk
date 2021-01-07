#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reload Cancel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lastReloadedAt := 0
~R::
   {
      last_reload_start := A_NowUTC
   }
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 180 Turn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WheelDown::
   {
      XIMInputData("RightStickDirectional",90)
      Sleep 257
      XIMInputData("RightStickDirectional", -1)
   }
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Slide Cancel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
is_sliding := 0
should_cancel := 1

~LCtrl::
   {
      sprint := "Button1" ;; LS click
      crouch := "Button2" ;; B
      ; 0 = release ; 1 = pressed
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

PgUp::is_enabled := ! is_enabled
PgDn::Suspend
