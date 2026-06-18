//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x_form_xy_calculate
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

var $vL_width; $vL_height : Integer
If ($vP_table=Null:C1517)
	FORM GET PROPERTIES:C674($vT_form; $vL_width; $vL_height)
Else 
	FORM GET PROPERTIES:C674($vP_table->; $vT_form; $vL_width; $vL_height)
End if 

Case of 
	: ($vL_framed=0)
	: ($vL_framed=1)
		$vP_top->:=$vP_top->-($vL_height/2)
	: ($vL_framed=2)
		$vP_top->:=$vP_top->-$vL_height
	: ($vL_framed=3)
		$vP_left->:=$vP_left->-($vL_width/2)
	: ($vL_framed=4)
		$vP_left->:=$vP_left->-($vL_width/2)
		$vP_top->:=$vP_top->-($vL_height/2)
	: ($vL_framed=5)
		$vP_left->:=$vP_left->-($vL_width/2)
		$vP_top->:=$vP_top->-$vL_height
	: ($vL_framed=6)
		$vP_left->:=$vP_left->-$vL_width
	: ($vL_framed=7)
		$vP_left->:=$vP_left->-$vL_width
		$vP_top->:=$vP_top->-($vL_height/2)
	: ($vL_framed=8)
		$vP_left->:=$vP_left->-$vL_width
		$vP_top->:=$vP_top->-$vL_height
End case 

wox_form_xy_resize($vL_width; $vL_height; $vP_left; $vP_top)





