//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos__set_svg_scale
//
// Parameter Type Description
// $1 <INT> THe zoom factor for all svg drawn.
//
// Description:
// Usefull to set to 2 or 4 with Retina screen.
// Take care to set the displayed area to proportionnal centered.
//
// Date        Init  Description
// ===================================================================
// 01/02/2021   OG   Initial version.


#DECLARE($vL_scale : Integer)  // {#1} optionnals
If ($vL_scale=0)
	$vL_scale:=1
End if 

var $vJ_prefs : Object
$vJ_prefs:=wos__storage_prefs
Use ($vJ_prefs)
	$vJ_prefs.l_svg_scale:=$vL_scale
End use 

