#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <StringConstants.au3>
#include <File.au3>

;urAutomaton
;Author: Ferhat Tohidi Far
;ferhat064@hotmail.de


Opt("GUIOnEventMode" , 1);event mode: ACTIVATED

; Add hotkeys
HotKeySet("+1", "addLeft")
HotKeySet("+2", "addRight")

HotKeySet("+a", "addLetterKey")
HotKeySet("+b", "addLetterKey")
HotKeySet("+c", "addLetterKey")
HotKeySet("+d", "addLetterKey")
HotKeySet("+e", "addLetterKey")

HotKeySet("+f", "addLetterKey")
HotKeySet("+g", "addLetterKey")
HotKeySet("+h", "addLetterKey")
HotKeySet("+i", "addLetterKey")
HotKeySet("+j", "addLetterKey")

HotKeySet("+k", "addLetterKey")
HotKeySet("+l", "addLetterKey")
HotKeySet("+m", "addLetterKey")
HotKeySet("+n", "addLetterKey")
HotKeySet("+o", "addLetterKey")

HotKeySet("+p", "addLetterKey")
HotKeySet("+q", "addLetterKey")
HotKeySet("+r", "addLetterKey")
HotKeySet("+s", "addLetterKey")
HotKeySet("+t", "addLetterKey")

HotKeySet("+u", "addLetterKey")
HotKeySet("+v", "addLetterKey")
HotKeySet("+w", "addLetterKey")
HotKeySet("+x", "addLetterKey")
HotKeySet("+y", "addLetterKey")

HotKeySet("+z", "addLetterKey")

HotKeySet("+{SPACE}", "addLetterKey")
HotKeySet("+{ENTER}", "addLetterKey")
HotKeySet("+{TAB}", "addLetterKey")
HotKeySet("+{BS}", "addLetterKey")

HotKeySet("+{UP}", "addLetterKey")
HotKeySet("+{DOWN}", "addLetterKey")
HotKeySet("+{LEFT}", "addLetterKey")
HotKeySet("+{RIGHT}", "addLetterKey")

HotKeySet("+3", "repeat")
HotKeySet("+4", "Pause")
HotKeySet("+5", "resetStack")
HotKeySet("{Esc}", "Quit")

; Quits the program
Func Quit()
    SetStatus("QUIT")
    GUIDelete()
    Exit
EndFunc

Global $pause = true

; Helper to pause the program
Func Pause()
    if $pause then
        $pause = false
	GUICtrlSetBkColor($s4, 0xFF0000)
	SetStatus("stopped!")
	Sleep(100)
	GUICtrlSetBkColor($s4, 0xFFFFFF)
    EndIf
EndFunc

; GUI CODE
$meinGui =  GUICreate("urAutomaton (Stack)", 800, 500)
GUISetBkColor(0xAAAAAA)

; Left side
$statusLabel = GUICtrlCreateLabel("status information:", 10, 10, 390, 20)
GUICtrlSetBkColor($statusLabel, 0x00AAFF)
GUICtrlSetColor($statusLabel, 0x000000)


Global $ctrl_status = GuiCtrlCreateInput("instructions see below!", 10, 40,390, 30)
GUICtrlSetBkColor($ctrl_status, 0x777777)
GUICtrlSetColor($ctrl_status, 0xFFFFFF)

; statusbox function
Func SetStatus( $msg )
    GUICtrlSetData( $ctrl_status, $msg )
EndFunc

$red = GUICtrlCreateLabel("Control keys: ", 10, 280, 390)
GUICtrlSetBkColor($red, 0x00EEFF)
$s1 = GUICtrlCreateLabel("Shift + 1 to register left click on current mouse position! ", 10, 300, 390)
$s2 = GUICtrlCreateLabel("Shift + 2 to register right click on current mouse position! ", 10, 320, 390)
$s3 = GUICtrlCreateLabel("Shift + 3 to play the stack. ", 10, 340, 390)
$s4 = GUICtrlCreateLabel("Shift + 4 to stop the stack. ", 10, 360, 390)
$s5 = GUICtrlCreateLabel("Shift + (a-z) to register a letter key to be pressed", 10, 380, 390)
$s6 = GUICtrlCreateLabel("PC option activates PixelChecksum and checks for different pixels", 10, 400, 390)
$s7 = GUICtrlCreateLabel("on click position since you saved your click. If pixels changed->no click! ", 10, 420, 390)
GUICtrlSetBkColor($s1, 0xFFFFFF)
GUICtrlSetBkColor($s2, 0xFFFFFF)
GUICtrlSetBkColor($s3, 0xFFFFFF)
GUICtrlSetBkColor($s4, 0xFFFFFF)
GUICtrlSetBkColor($s5, 0xFFFFFF)
GUICtrlSetBkColor($s6, 0x00EEFF)
GUICtrlSetBkColor($s7, 0x00EEFF)

;profile save and load buttons
$profileSave = GUICtrlCreateButton("Save profile", 95, 240, 80)
GUICtrlSetBkColor($profileSave, 0x00AAFF)
GUICtrlSetColor($profileSave, 0x000000)
GUICtrlSetOnEvent($profileSave, "createProfile")

$profileLoad = GUICtrlCreateButton("Load profile", 175, 240, 80)
GUICtrlSetBkColor($profileLoad, 0x00AAFF)
GUICtrlSetColor($profileLoad, 0x000000)
GUICtrlSetOnEvent($profileLoad, "loadProfile")




Func createProfile()
$i = 0
;$NewFilePath = @ScriptDir & "\profile.txt" ;New file path defined
$NewFilePath = FileOpenDialog("Choose save directory and filename", @ScriptDir, "Text files (*.txt)")
	  While $i <= $index
		 $n = 0
		 While $n <= 3
			if $i < $index then
			FileWriteLine($NewFilePath, ($stack[$i])[$n])
			EndIf
			$n = $n + 1
		 WEnd
		 $i = $i + 1
	  WEnd
EndFunc

Func loadProfile()
$i = 1
resetStack()
;$OldFilePath = @ScriptDir & "\profile.txt" ;Old file path defined
$OldFilePath = FileOpenDialog("Choose profile file -> .txt", @ScriptDir, "Text files (*.txt)")
   While $i <= _FileCountLines($OldFilePath)
	  $n = 0
	  Local $tempArray[4]
		 While $n <= 3
			if(FileReadLine($OldFilePath, $i)="0") AND $n==2 Then
			$tempArray[$n] = 0
			ElseIf(FileReadLine($OldFilePath, $i)="1") AND $n==2 Then
			$tempArray[$n] = 1
			Else
			$tempArray[$n] = FileReadLine($OldFilePath, $i) ;Read the line

			EndIf
			$n = $n + 1
			$i = $i + 1

		 WEnd
	  $stack[$index] = $tempArray

	  if $tempArray[2] == 0 then
	  $labelStack[$index] = GUICtrlCreateListViewItem($tempArray[0] & "|" & $tempArray[1] & "|" & "left click|" & $tempArray[3] , $idListview)
	  elseif $tempArray[2] == 1 then
	  $labelStack[$index] = GUICtrlCreateListViewItem($tempArray[0] & "|" & $tempArray[1] & "|" & "right click|" & $tempArray[3] , $idListview)
	  else
	  $labelStack[$index] = GUICtrlCreateListViewItem($tempArray[0] & "|" & $tempArray[1] & "|" & $tempArray[2] &"|" & $tempArray[3]  , $idListview)
	  EndIf

	  $index = $index + 1
   WEnd
EndFunc

;checker
Global $checker = GUICtrlCreateCheckbox("Pixel check toggle (PC)", 10, 450)
Global $enableChecker
Global $pCH[100]

Func pixelCheck()
    $pCH[$index] = PixelChecksum(MouseGetPos(0)-3,MouseGetPos(1)-3, MouseGetPos(0)+3, MouseGetPos(1)+3)
EndFunc

Func pixelCheckRunTime()
    MouseMove(($stack[$hilfeRepeat])[0], ($stack[$hilfeRepeat])[1], 1)
    $a = PixelChecksum(MouseGetPos(0)-3,MouseGetPos(1)-3, MouseGetPos(0)+3, MouseGetPos(1)+3)
    $b = $pCH[$hilfeRepeat]
    SetStatus($a & "  " & $b)

    if  $a =  $b Then
        return True
    Else
        return False
    EndIf

EndFunc

; User input area
GUICtrlCreateLabel("Repeat stack ... times", 10, 80)
Global $wieOft = GuiCtrlCreateInput("1", 10, 100,390, 30)
GUICtrlCreateLabel("Delay between actions?", 10, 130)
Global $clickDelay = GuiCtrlCreateInput("10", 10, 150,390, 30)
GUICtrlCreateLabel("Delay between stack replays?", 10, 180)
Global $repeatDelay = GuiCtrlCreateInput("10", 10, 200,390, 30)

; Stack variables
Global $stack[1000]
Global $index = 0
Global $labelStack[1000]


; Global variables
Global $boolean = false
Global $hilfeRepeat = 0

;RESET BUTTON
$resetButton = GUICtrlCreateButton("Reset stack", 10, 240, 80)
GUICtrlSetBkColor($resetButton, 0x00AAFF)
GUICtrlSetColor($resetButton, 0x000000)
GUICtrlSetOnEvent($resetButton, "resetStack")


$COPY = GUICtrlCreateButton("copy", 330, -1)
GUICtrlSetBkColor($COPY, 0x00AAFF)
GUICtrlSetColor($COPY, 0x000000)
GUICtrlSetOnEvent($COPY, "addCopy")

$PASTE = GUICtrlCreateButton("paste", 370, -1)
GUICtrlSetBkColor($PASTE, 0x00AAFF)
GUICtrlSetColor($PASTE, 0x000000)
GUICtrlSetOnEvent($PASTE, "addPaste")


Func resetStack()
    SetStatus("Reset started")

   While $index > 0
        GuiCtrlDelete($labelStack[$index])
        $index = $index - 1
		 GuiCtrlDelete($labelStack[$index])
   WEnd

    GuiCtrlSetState($checker, $GUI_ENABLE)
    SetStatus("Reset complete")
EndFunc

; ListView side
Global $idListview = GUICtrlCreateListView("X coord | Y coord | action | delay after action ", 420, 50, 340, 402)

$lab = GUICtrlCreateLabel("your stack:", 420, 10, 240)
GUICtrlSetBkColor($lab, 0x00AAFF)
GUICtrlSetColor($lab, 0x000000)

GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "Quit")

While 1
WEnd


;<BotPart>
Func addLeft()
    GUICtrlSetBkColor($s1, 0x00AAFF)

    $x = MouseGetPos(0)
    $y = MouseGetPos(1)

    if GUICtrlRead($checker) = $GUI_CHECKED then
		 pixelCheck()
		 $enableChecker = false
    EndIf

    GuiCtrlSetState($checker, $GUI_DISABLE)
    Local $internalArray[4] = [$x, $y, 0, GUICtrlRead($clickDelay)]
    $stack[$index] = $internalArray

    $labelStack[$index] = GUICtrlCreateListViewItem($internalArray[0] & "|" & $internalArray[1] & "|left|" & $internalArray[3] , $idListview)
    $index = $index +1
    SetStatus("X Position " & $internalArray[0] & " Y Position "  & $internalArray[1] & " left click, delay: " & $internalArray[3])


    _GUICtrlListView_Scroll($idListview, 0, 20)
    GUICtrlSetBkColor($s1, 0xFFFFFF)
EndFunc


Func addRight()
    GUICtrlSetBkColor($s2, 0x00AAFF)

    $x = MouseGetPos(0)
    $y = MouseGetPos(1)

    if GUICtrlRead($checker) = $GUI_CHECKED then
		 pixelCheck()
		 $enableChecker = false
    EndIf

    GuiCtrlSetState($checker, $GUI_DISABLE)
    Local $internalArray[4] = [$x, $y, 1, GUICtrlRead($clickDelay)]
    $stack[$index] = $internalArray

    $labelStack[$index] = GUICtrlCreateListViewItem($internalArray[0] & "|" & $internalArray[1] & "|right|" & $internalArray[3] , $idListview)
    $index = $index +1
    SetStatus("X Position " & $internalArray[0] & " Y Position "  & $internalArray[1] & " right click, delay: "  & $internalArray[3])


    _GUICtrlListView_Scroll($idListview, 0, 20)
    GUICtrlSetBkColor($s2, 0xFFFFFF)
EndFunc

Func addLetterKey()
   Local $pressedKey = ""
   GUICtrlSetBkColor($s5, 0x00AAFF)

   Switch @HotKeyPressed
		 Case "+a"
            $pressedKey = "a"
        Case "+b"
            $pressedKey = "b"
        Case "+c"
            $pressedKey = "c"
	    Case "+d"
            $pressedKey = "d"
        Case "+e"
            $pressedKey = "e"

		 Case "+f"
            $pressedKey = "f"
        Case "+g"
            $pressedKey = "g"
        Case "+h"
            $pressedKey = "h"
	    Case "+i"
            $pressedKey = "i"
        Case "+j"
            $pressedKey = "j"

		 Case "+k"
            $pressedKey = "k"
        Case "+l"
            $pressedKey = "l"
        Case "+m"
            $pressedKey = "m"
	    Case "+n"
            $pressedKey = "n"
        Case "+o"
            $pressedKey = "o"

		 Case "+p"
            $pressedKey = "p"
        Case "+q"
            $pressedKey = "q"
        Case "+r"
            $pressedKey = "r"
	    Case "+s"
            $pressedKey = "s"
        Case "+t"
            $pressedKey = "t"

		 Case "+u"
            $pressedKey = "u"
        Case "+v"
            $pressedKey = "v"
        Case "+w"
            $pressedKey = "w"
	    Case "+x"
            $pressedKey = "x"
        Case "+y"
            $pressedKey = "y"

		 Case "+z"
            $pressedKey = "z"



		 Case "+{SPACE}"
			$pressedKey = "{SPACE}"

		 Case "+{ENTER}"
			$pressedKey = "{ENTER}"

		 Case "+{TAB}"
			$pressedKey = "{TAB}"

		 Case "+{BS}"
			$pressedKey = "{BS}"

		 Case "+{UP}"
			$pressedKey = "{UP}"
		 Case "+{DOWN}"
			$pressedKey = "{DOWN}"
		 Case "+{LEFT}"
			$pressedKey = "{LEFT}"
		 Case "+{RIGHT}"
			$pressedKey = "{RIGHT}"

   EndSwitch


   Local $internalArray[4] = ["-", "-", $pressedKey, GUICtrlRead($clickDelay)]
   $stack[$index] = $internalArray

   SetStatus("Pressed Key: " & ($stack[$index])[2])

   $labelStack[$index] = GUICtrlCreateListViewItem($internalArray[0] & "|" & $internalArray[1] & "|" & $pressedKey &"|" & $internalArray[3] , $idListview)
   $index = $index +1

   _GUICtrlListView_Scroll($idListview, 0, 20)
   GUICtrlSetBkColor($s5, 0xFFFFFF)

EndFunc


Func addCopy()
   Local $pressedKey = "copy"
   Local $internalArray[4] = ["-", "-", $pressedKey, GUICtrlRead($clickDelay)]
   $stack[$index] = $internalArray

   SetStatus("Pressed Key: " & ($stack[$index])[2])

   $labelStack[$index] = GUICtrlCreateListViewItem($internalArray[0] & "|" & $internalArray[1] & "|" & $pressedKey &"|" & $internalArray[3] , $idListview)
   $index = $index +1

   _GUICtrlListView_Scroll($idListview, 0, 20)
   GUICtrlSetBkColor($s5, 0xFFFFFF)
EndFunc

Func addPaste()
   Local $pressedKey = "paste"
   Local $internalArray[4] = ["-", "-", $pressedKey, GUICtrlRead($clickDelay)]
   $stack[$index] = $internalArray

   SetStatus("Pressed Key: " & ($stack[$index])[2])

   $labelStack[$index] = GUICtrlCreateListViewItem($internalArray[0] & "|" & $internalArray[1] & "|" & $pressedKey &"|" & $internalArray[3] , $idListview)
   $index = $index +1

   _GUICtrlListView_Scroll($idListview, 0, 20)
   GUICtrlSetBkColor($s5, 0xFFFFFF)
EndFunc



Func repeat()
   $pause = true
   GuiCtrlSetState($checker, $GUI_DISABLE)
   GUICtrlSetBkColor($s3, 0xFF0000)
   $hilfeRepeat = 0
   $von = 0
   $bis = GUICtrlRead($wieOft)

   While $von < $bis AND $pause

	  _GUICtrlListView_Scroll($idListview, 0, -2000)

	  While $hilfeRepeat < $index AND $pause

		 SetStatus("Action number: " & $hilfeRepeat & " Replay number: (" & $von+1 & "/" & $bis & ") ")

		 if IsString(($stack[$hilfeRepeat])[2]) = 1 Then;send key:char
			if(($stack[$hilfeRepeat])[2] = "copy") Then
			   GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0xFFFFFF)
			_GUICtrlListView_Scroll($idListview, 0, 20)
			SetStatus("Sending Key: " & ($stack[$hilfeRepeat])[2] )
			  Send ("^c");Send("{CTRLDOWN}c{CTRLUP}")
			GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			ElseIf (($stack[$hilfeRepeat])[2] = "paste") Then
			   			   GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0xFFFFFF)
			_GUICtrlListView_Scroll($idListview, 0, 20)
			SetStatus("Sending Key: " & ($stack[$hilfeRepeat])[2] )
			   Send ("^v");Send("{CTRLDOWN}v{CTRLUP}")
			GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			Else
			GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0xFFFFFF)
			_GUICtrlListView_Scroll($idListview, 0, 20)
			SetStatus("Sending Key: " & ($stack[$hilfeRepeat])[2] )
			Send("" & ($stack[$hilfeRepeat])[2]);important part
			GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			EndIf
		 EndIf

		 if Not IsString(($stack[$hilfeRepeat])[2]) = 1 Then
			if GUICtrlRead($checker) = $GUI_CHECKED Then;if pixelcheck is activated
			   if ($stack[$hilfeRepeat])[2] = 0 AND pixelCheckRunTime() = True Then
				  MouseClick("left", ($stack[$hilfeRepeat])[0], ($stack[$hilfeRepeat])[1], 1, 0);important part
				  GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			   EndIf
			   if ($stack[$hilfeRepeat])[2] = 1 AND pixelCheckRunTime() = true  Then
				  MouseClick("right", ($stack[$hilfeRepeat])[0], ($stack[$hilfeRepeat])[1], 1, 0);important part
				  GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			   EndIf
			Else;if pixelcheck is not activated
			   if ($stack[$hilfeRepeat])[2] = 0 Then;left click
				  MouseClick("left", ($stack[$hilfeRepeat])[0], ($stack[$hilfeRepeat])[1], 1, 0);important part
				  GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			   EndIf
			   if ($stack[$hilfeRepeat])[2] = 1 Then;right click
				  MouseClick("right", ($stack[$hilfeRepeat])[0], ($stack[$hilfeRepeat])[1], 1, 0);important part
				  GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0x00AAFF)
			   EndIf
			EndIf
		 EndIf

		 Sleep(($stack[$hilfeRepeat])[3]);sleep click delay
		 GuiCtrlSetBkColor($labelStack[$hilfeRepeat], 0xFFFFFF)
		 _GUICtrlListView_Scroll($idListview, 0, 20)
		 $hilfeRepeat = $hilfeRepeat + 1

	  WEnd

        $von = $von +1
        $hilfeRepeat = 0
        Sleep(GUICtrlRead($repeatDelay));sleep stack delay

   WEnd

    GUICtrlSetBkColor($s3, 0xFFFFFF)

    if $enableChecker then
        GuiCtrlSetState($checker, $GUI_ENABLE)
    EndIf

    SetStatus("Done!")

EndFunc