//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_FONT
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

#DECLARE($vT_refMenu : Text; $vJ_wos_text : Object; $vL_space : Integer)->$vT_refMenu_answer : Text

var $vT_face; $vT_colour : Text
var $vL_size; $vL_opacity; $vL_rgb; $vL_style; $vL_align : Integer
$vT_face:=$vJ_wos_text.t_face
$vL_size:=$vJ_wos_text.l_size
$vT_colour:=$vJ_wos_text.t_colour
$vL_opacity:=$vJ_wos_text.l_opacity
$vL_style:=$vJ_wos_text.l_style
$vL_align:=$vJ_wos_text.l_align
$vL_rgb:=woc_sp_colourToColorRGB($vT_colour)

$vT_refMenu_answer:=Create menu:C408
svgE_MENU_font_face($vT_refMenu_answer; $vT_face)
svgE_MENU_font_size($vT_refMenu_answer; $vL_size)
woc_colour_create_menu($vL_rgb; $vL_space; "font"; $vT_refMenu_answer)
svgE_MENU_opacity($vL_opacity; "font"; $vT_refMenu_answer)
svgE_MENU_font_style($vT_refMenu_answer; $vL_style)
svgE_MENU_font_align($vT_refMenu_answer; $vL_align)

APPEND MENU ITEM:C411($vT_refMenu; "Font"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

