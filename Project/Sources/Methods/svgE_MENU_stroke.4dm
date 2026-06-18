//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_STROKE
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 02/03/2021   OG   Initial version.

#DECLARE($vT_refMenu : Text; $vJ_wos_stroke : Object; $is_marker : Boolean; $is_cap : Boolean; $is_join : Boolean; $vL_space : Integer)->$vT_refMenu_answer : Text

var $vL_cap; $vL_dash; $vL_join; $vL_marker; $vL_opacity; $vL_rgb; $vL_width : Integer
var $vT_colour : Text
$vT_colour:=$vJ_wos_stroke.t_colour
$vL_opacity:=$vJ_wos_stroke.l_opacity
$vL_width:=$vJ_wos_stroke.l_width
$vL_dash:=$vJ_wos_stroke.l_dash
$vL_marker:=$vJ_wos_stroke.l_marker
$vL_cap:=$vJ_wos_stroke.l_cap
$vL_join:=$vJ_wos_stroke.l_join

$vL_rgb:=woc_sp_colourToColorRGB($vT_colour)
$vT_refMenu_answer:=Create menu:C408
woc_colour_create_menu($vL_rgb; $vL_space; "stroke"; $vT_refMenu_answer)
svgE_MENU_opacity($vL_opacity; "stroke"; $vT_refMenu_answer)
svgE_MENU_width($vT_refMenu_answer; $vL_width)
svgE_MENU_dash($vT_refMenu_answer; $vL_dash)
If ($is_marker)
	svgE_MENU_marker($vT_refMenu_answer; $vL_marker)
End if 
If ($is_cap)
	svgE_MENU_cap($vT_refMenu_answer; $vL_cap)
End if 
If ($is_join)
	svgE_MENU_join($vT_refMenu_answer; $vL_join)
End if 

APPEND MENU ITEM:C411($vT_refMenu; "Stroke"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

