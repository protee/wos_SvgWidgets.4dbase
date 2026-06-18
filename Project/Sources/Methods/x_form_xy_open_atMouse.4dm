//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x_form_xy_open_mouse
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 08/04/2022   OG   Initial version.

var $vP_table : Pointer
var $vT_form; $vT_title : Text
var $vL_window_type; $vL_framed : Integer
var $vJ_form : Object
$vP_table:=$1
$vT_form:=$2
$vL_window_type:=$3
If (Count parameters:C259>=4)
	$vT_title:=$4
End if 
If (Count parameters:C259>=5)
	$vL_framed:=$5
Else 
	$vL_framed:=k_form_rightBottom
End if 
If (Count parameters:C259>=6)
	$vJ_form:=$6
End if 


var $isOk : Boolean
var $vL_windowRef : Integer
var $vL_left; $vL_top : Integer
x_form_xy_calculate_mouse($vP_table; $vT_form; ->$vL_left; ->$vL_top; $vL_framed)
If ($vP_table#Null:C1517)
	$vL_windowRef:=Open form window:C675($vP_table->; $vT_form; $vL_window_type; $vL_left; $vL_top)
	SET WINDOW TITLE:C213($vT_title; $vL_windowRef)
	DIALOG:C40($vP_table->; $vT_form; $vJ_form)
Else 
	$vL_windowRef:=Open form window:C675($vT_form; $vL_window_type; $vL_left; $vL_top)
	SET WINDOW TITLE:C213($vT_title; $vL_windowRef)
	DIALOG:C40($vT_form; $vJ_form)
End if 
$isOk:=(OK=1)
CLOSE WINDOW:C154($vL_windowRef)
$0:=$isOk




