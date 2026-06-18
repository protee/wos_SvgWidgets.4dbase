//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_FILL
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

#DECLARE($vT_refMenu : Text; $vJ_wos_fill : Object; $vL_space : Integer)->$vT_refMenu_answer : Text
var $vT_colour : Text
var $vL_opacity; $vL_rgb : Integer

$vT_colour:=$vJ_wos_fill.t_colour
$vL_opacity:=$vJ_wos_fill.l_opacity

$vL_rgb:=woc_sp_colourToColorRGB($vT_colour)
$vT_refMenu_answer:=Create menu:C408()
woc_colour_create_menu($vL_rgb; $vL_space; "fill"; $vT_refMenu_answer)
svgE_MENU_opacity($vL_opacity; "fill"; $vT_refMenu_answer)

APPEND MENU ITEM:C411($vT_refMenu; "Fill"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

