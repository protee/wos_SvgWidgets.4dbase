//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __compiler_init_obs
//
// Parameter Type Description
//
//
// Description:
// Main object initialization
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.

// *
// ***** MAIN Objects
// *
var $vJ_widgets; $vJ_widget; $vJ_widget_paper; $vJ_widget_margin; $vJ_enablers : Object
$vJ_widgets:=New shared object:C1526
Use (Storage:C1525)
	Storage:C1525.j_widgets:=$vJ_widgets
End use 


Use ($vJ_widgets)
	
	// ***** wos_width 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_width:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	
	// ***** wos_dash 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_dash:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	
	// ***** wos_marker
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_marker:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	
	// ***** wos_join
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_join:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	
	// ***** wos_cap 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_cap:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	
	// ***** wos_tools 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_tools:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.is_sticky:=False:C215
	$vJ_widget.is_sticked:=False:C215
	$vJ_widget.t_label:="Tools"
	$vJ_widget.t_value:="SELECT"  // tool
	
	
	// ***** wos_actions 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_actions:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Actions"
	$vJ_widget.l_mask:=0x006B  // 110 1011 File, ClearAll, Clear, layer, group, distribute, align
	$vJ_widget.l_count:=0
	$vJ_widget.t_value:=""  // action
	
	
	// ***** wos_edits 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_edits:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Edit"
	$vJ_widget.l_mask:=0x003F  // 11 1111 Clear, Paste, Copy, Cut, Redo, Undo
	$vJ_enablers:=New shared object:C1526
	$vJ_widget.j_enablers:=$vJ_enablers
	$vJ_enablers.is_undo:=False:C215
	$vJ_enablers.is_redo:=False:C215
	$vJ_enablers.is_cut:=True:C214
	$vJ_enablers.is_copy:=True:C214
	$vJ_enablers.is_paste:=False:C215
	$vJ_enablers.is_clear:=True:C214
	$vJ_widget.t_value:=""  // edit
	
	
	// ***** wos_ruler 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_ruler:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Ruler"
	$vJ_widget.t_tip:=""
	$vJ_widget.l_min:=0
	$vJ_widget.l_max:=100
	$vJ_widget.l_unit:=20
	$vJ_widget.l_step:=5
	$vJ_widget.l_value:=0  // .ruler
	
	
	// ***** wos_rotate 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_rotate:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Rotate"
	$vJ_widget.l_colors:=0xAA00009E  // [swo:0] – [swo:158]
	$vJ_widget.l_type:=0  // Circle, Square
	$vJ_widget.r_coef:=0.9
	$vJ_widget.l_value:=0  // 0-360°
	
	
	// ***** wos_zoom
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_zoom:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Zoom"
	$vJ_widget.l_colors:=0xAA00009E  // [swo:0] – [swo:158]
	$vJ_widget.l_type:=0  // Square, circle
	$vJ_widget.r_coef:=0.9
	$vJ_widget.l_value:=100  // 0-100
	
	
	// ***** wos_opacity
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_opacity:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Opacity"
	$vJ_widget.l_colors:=0xAA00009E  // [swo:0] – [swo:158]
	$vJ_widget.t_mode:="stroke"
	$vJ_widget.r_coef:=0.9
	$vJ_widget.l_value:=0  // 0-100
	
	
	// ***** wos_fill
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_fill:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Fill"
	$vJ_widget.is_displayText:=True:C214
	$vJ_widget.t_colour:="black"
	$vJ_widget.l_opacity:=100
	
	
	// ***** wos_stroke 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_stroke:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Stroke"
	$vJ_widget.is_displayText:=True:C214
	$vJ_widget.t_colour:="black"
	$vJ_widget.l_opacity:=100
	$vJ_widget.is_marker:=True:C214
	$vJ_widget.is_join:=True:C214
	$vJ_widget.is_cap:=True:C214
	$vJ_widget.l_width:=0  // Always
	$vJ_widget.l_dash:=0  // Always
	$vJ_widget.l_marker:=0
	$vJ_widget.l_join:=0
	$vJ_widget.l_cap:=0
	
	
	// ***** wos_text 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_text:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Text"
	$vJ_widget.is_displayText:=True:C214
	$vJ_widget.t_colour:="black"
	$vJ_widget.l_opacity:=100
	$vJ_widget.t_face:=Choose:C955(Is macOS:C1572; "Lucida Grande"; "Segoe UI")
	$vJ_widget.l_size:=12
	$vJ_widget.l_style:=0
	$vJ_widget.l_align:=0
	// *
	// *****
	
	
	
	// ***** SVG EDITOR MAIN
	// *
	// *
	// ***** wos_editor 
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_editor:=$vJ_widget
	
	$vJ_widget.is_modified:=False:C215
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.is_toolsOnTop:=True:C214
	$vJ_widget.is_palettes:=True:C214
	$vJ_widget.is_palettesOnTop:=True:C214
	$vJ_widget.is_visibility:=False:C215
	$vJ_widget.is_sticky:=False:C215
	$vJ_widget.is_domToClose:=True:C214  // put false to use in multipages form
	$vJ_widget.is_spaces:=True:C214
	$vJ_widget.is_marker:=True:C214
	$vJ_widget.is_cap:=True:C214
	$vJ_widget.is_join:=True:C214
	
	$vJ_widget_paper:=New shared object:C1526
	$vJ_widget.j_paper:=$vJ_widget_paper
	$vJ_widget_paper.l_width:=595
	$vJ_widget_paper.l_height:=842
	
	$vJ_widget_margin:=New shared object:C1526
	$vJ_widget.j_margin:=$vJ_widget_margin
	$vJ_widget_margin.l_left:=16
	$vJ_widget_margin.l_top:=16
	$vJ_widget_margin.l_right:=16
	$vJ_widget_margin.l_bottom:=16
	// *
	// *****
	
	
End use 

