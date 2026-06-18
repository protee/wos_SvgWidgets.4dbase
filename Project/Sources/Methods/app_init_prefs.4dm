//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __compiler_init
//
// Parameter Type Description
//
//
// Description:
// Main variables initializations
//
// Date        Init  Description
// ===================================================================
// 23/12/2023   OG   Compatible with 4DPop v20


// *****
// *
var $vJ_prefs : Object
$vJ_prefs:=wos__storage_prefs

// *
// ***** OBJECT GLOBAL OPTIONS
// *
Use ($vJ_prefs)
	// Window types
	$vJ_prefs.l_window_type:=Palette form window:K39:9
	
	$vJ_prefs.t_popup_idle:="Idle"
	
	$vJ_prefs.r_fontOffset_coef:=0.7
	$vJ_prefs.l_svg_scale:=1
	
	//$vJ_prefs.t_urlTaguthi_pasteboard:="org.protee.ogTaguthi.pp"
	
	//$vJ_prefs.t_uncheckCheck:=" ✓"
	//$vJ_prefs.t_arrowSeparator:="↤"
	//$vJ_prefs.t_splitSeparator:="—"
	
	
	// SVG Prefs
	// *
	// ***** svgEditor_ui <>vJ_svgEditor_ui
	// *
	var $vJ_prefs_ui : Object
	$vJ_prefs_ui:=New shared object:C1526
	$vJ_prefs.j_ui:=$vJ_prefs_ui
	
	// margin between widgets, see "svgE_EDIT_widgets_enabler"
	$vJ_prefs_ui.widgets_margin:=4
	
	// Editor options
	$vJ_prefs_ui.selection_fill:="#666666"
	$vJ_prefs_ui.selection_fill_opacity:=0.1
	$vJ_prefs_ui.selection_stroke:="#EEEEEE"
	$vJ_prefs_ui.selection_stroke_opacity:=0.7
	$vJ_prefs_ui.selection_stroke_width:=1
	// Handles
	$vJ_prefs_ui.handle_radius:=4  // handles squares "radius"
	$vJ_prefs_ui.handle_fill_opacity:=0.7
	$vJ_prefs_ui.handle_fill:="#9999FF"
	$vJ_prefs_ui.handle_stroke:="#EEEEEE"
	$vJ_prefs_ui.handle_stroke_opacity:=0.7
	$vJ_prefs_ui.handle_stroke_width:=0.5
	// Polylines handles
	$vJ_prefs_ui.line_handle_fill:="#FF6600"
	$vJ_prefs_ui.line_handle_stroke:="#FF6600"
	
	// For "Reserved" rectangles
	$vJ_prefs_ui.t_paper_fillColour:="white"
	$vJ_prefs_ui.t_margins_strokeColour:="lightgrey"
	$vJ_prefs_ui.t_margins_fillColour:=k_none
	
End use 




// 4DPOP
// MAIN MENU

//C_COLLECTION(<>col_main_menu)
//<>col_main_menu:=New collection
//<>col_main_menu.push(New object("label"; "GS_colourPop"; "menu"; "colourPop"))
//<>col_main_menu.push(New object("label"; ""; "menu"; ""))
//<>col_main_menu.push(New object("label"; "4dPop palette"; "menu"; "palette"))


