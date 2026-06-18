//%attributes = {"invisible":true,"lang":"en"}
//Project Method: MCSU_UI_ButtonClicked(ButtonName{;LeaveClickedFg}) -> ClickedFg
//
//   Parameter        Type             Description
//   ButtonName       Text        ->   Object name of the button object to be
//                                     checked.
//   LeaveClickedFg   Boolean     ->   If True, the clicked state of the button
//                                     won't be reset by this method.
//   ClickedFg        Boolean     <-   True if the named button was clicked.
//
//Description:
//   Returns True if the named button has been clicked. Sets the button value
//   back to zero to prevent accidental subsequent false positives for certain
//   button types.
//
//Date        Init  Description
//===============================================================================
//07/10/2013   JC   Initial version.

var $0; $vB_Clicked : Boolean
var $1; $vT_ButtonName : Text
var $2; $vB_LeaveClicked : Boolean

var $vP_Button : Pointer

$vB_Clicked:=False:C215
$vT_ButtonName:=$1
If (Count parameters:C259>=2)
	$vB_LeaveClicked:=$2
Else 
	$vB_LeaveClicked:=($vT_ButtonName#"@_Btn")  //Leave radio buttons and checkboxes alone!
End if 

$vP_Button:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_ButtonName)

Case of 
	: (Is nil pointer:C315($vP_Button))
	: ($vP_Button->=0)
	Else 
		$vB_Clicked:=True:C214
		If (Not:C34($vB_LeaveClicked))
			$vP_Button->:=0
		End if 
End case 

$0:=$vB_Clicked



