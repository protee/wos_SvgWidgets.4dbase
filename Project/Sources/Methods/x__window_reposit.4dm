//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x__window_reposit
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 26/02/2021   OG   Initial version.


var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height : Integer

GET WINDOW RECT:C443($vL_left; $vL_top; $vL_right; $vL_bottom)
$vL_width:=$vL_right-$vL_left
$vL_height:=$vL_bottom-$vL_top
wox_form_xy_resize($vL_width; $vL_height; ->$vL_left; ->$vL_top)
SET WINDOW RECT:C444($vL_left; $vL_top; $vL_left+$vL_width; $vL_top+$vL_height)




