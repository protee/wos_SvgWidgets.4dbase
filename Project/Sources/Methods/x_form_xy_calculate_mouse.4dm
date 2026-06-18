//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x_form_xy_calculate_mouse
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 02/04/2022   OG   Initial version.

var $vP_table; $vP_left; $vP_top : Pointer
var $vT_form : Text
var $vL_framed : Integer
$vP_table:=$1
$vT_form:=$2
$vP_left:=$3
$vP_top:=$4
If (Count parameters:C259>=5)
	$vL_framed:=$5
Else 
	$vL_framed:=k_form_rightBottom
End if 

var $x; $y; $vL_buttons : Integer
GET MOUSE:C468($x; $y; $vL_buttons; *)
$vP_left->:=$x
$vP_top->:=$y  //-($height/2)
x_form_xy_calculate($vP_table; $vT_form; $vP_left; $vP_top; $vL_framed)




