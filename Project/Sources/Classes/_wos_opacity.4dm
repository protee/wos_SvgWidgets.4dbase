// *****
// *
// Class: _wos_cap
// Olivier Grimbert — Protée sarl — 20/04/2026 16:30:12
//
// Description: 
//
// Date       | Who | Comment
// 20/04/2026 | OG  | Updated
// *
// *****

Class extends _WIDGETS

Class constructor
	Super:C1705("j_opacity")
	This:C1470.l_value:=0
	
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_width; $vL_height : Integer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vP_vL_width->:=$vL_width
	$vP_vL_height->:=$vL_height
	
	
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
		: ($vL_event_code=On Clicked:K2:4)
			If ($vT_objectName="canvas")
				This:C1470._canvas_clicked()
			End if 
	End case 
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height; $vL_svg_xl; $vL_h; $vL_svg_xr; $y : Integer
	var $vL_yt; $vL_yb; $vL_xr; $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	var $y1 : Integer
	var $is_ruler : Boolean
	var $vJ_wos_ruler : Object
	var $vT_canvas; $vT_wos_ruler : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vT_canvas:="canvas"
	$vT_wos_ruler:="wos_ruler"
	
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$vL_svg_xl:=2
	$vL_xr:=$vL_width-2
	$vL_h:=$vL_yb-$vL_yt
	$is_ruler:=($vL_width>=100)
	OBJECT SET VISIBLE:C603(*; $vT_wos_ruler; $is_ruler)
	If ($is_ruler)
		$vL_svg_xr:=$vL_svg_xl+$vL_h
		OBJECT GET COORDINATES:C663(*; $vT_wos_ruler; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h:=$vL_bottom-$vL_top
		$y:=$vL_yt+8
		$y:=$vL_h/2+$vL_yt-6
		$y:=$vL_h/2+$vL_yt+24
		$y:=wox_max($vL_yt; wox_min($y; $vL_yb)-30)
		$y1:=wox_min($vL_yb; $y+$vL_h)
		OBJECT SET COORDINATES:C1248(*; $vT_wos_ruler; $vL_svg_xr+4; $y; $vL_xr-10; $y1)
		$vJ_wos_ruler:=OBJECT Get value:C1743($vT_wos_ruler)
		$vJ_wos_ruler.j_value:=This:C1470
		$vJ_wos_ruler.t_property:="l_value"
		$vJ_wos_ruler.resize()
	Else 
		$vL_svg_xr:=$vL_width-4
	End if 
	OBJECT SET COORDINATES:C1248(*; $vT_canvas; $vL_svg_xl; $vL_yt; $vL_svg_xr; $vL_yb)
	// *
	// *****
	
	
Function _redraw()
	var $vL_value : Integer
	var $is_editing; $is_ruler : Boolean
	var $vJ_wos_ruler : Object
	var $vT_wos_ruler : Text
	$is_editing:=This:C1470.is_editing
	$vL_value:=This:C1470._ext_read_l()
	
	$vT_wos_ruler:="wos_ruler"
	$is_ruler:=OBJECT Get visible:C1075(*; $vT_wos_ruler)
	If ($is_ruler)
		$vJ_wos_ruler:=OBJECT Get value:C1743($vT_wos_ruler)
		$vJ_wos_ruler.is_editing:=$is_editing
		$vJ_wos_ruler.t_mode:=This:C1470.t_mode
		$vJ_wos_ruler.redraw()
	End if 
	This:C1470._opacity_svg($vL_value)
	// *
	// *****
	
	
	// *****
	// *
Function _opacity_chge($vJ_widget : Object; $vL_event_code : Integer)
	var $is_editing : Boolean
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		CALL SUBFORM CONTAINER:C1086($vL_event_code)  // Move
		This:C1470._redraw()
	Else 
		wox_sounds_play_edit()
	End if 
	
	
Function _opacity_menu()
	var $isOk : Boolean
	var $vL_value : Integer
	var $vT_MenuRef; $vT_answerMenu; $vT_mode : Text
	$vL_value:=This:C1470._ext_read_l()
	$vT_mode:=This:C1470.t_mode
	$vT_MenuRef:=svgE_MENU_opacity($vL_value; $vT_mode)
	$vT_answerMenu:=Dynamic pop up menu:C1006($vT_MenuRef)
	RELEASE MENU:C978($vT_MenuRef)
	$isOk:=($vT_answerMenu#"")
	If ($isOk)
		$vT_answerMenu:=Replace string:C233($vT_answerMenu; $vT_mode+"-opacity-"; "")
		$vL_value:=Num:C11($vT_answerMenu)
		This:C1470._ext_write_l($vL_value)
		CALL SUBFORM CONTAINER:C1086(k_OnDataChange)  // Click
		This:C1470._redraw()
	End if 
	// *
	// *****
	
	
Function _canvas_events($vP_canvas : Pointer)
	var $is_editing; $isOk : Boolean
	var $vL_value : Integer
	var $vJ_params : Object
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		If (Right click:C712)
			This:C1470._opacity_menu()
		Else 
			$vJ_params:=New object:C1471
			$vJ_params.t_label:="Opacity "+This:C1470.t_mode
			$vJ_params.l_min:=0
			$vJ_params.l_max:=100
			$vJ_params.l_unit:=20
			$vJ_params.l_step:=1
			$vJ_params.t_mode:=This:C1470.t_mode
			$vL_value:=This:C1470._ext_read_l()
			$vJ_params.l_value:=$vL_value
			$isOk:=wos_rulerPicker_vJ($vJ_params)
			If ($isOk)
				$vL_value:=$vJ_params.l_value
				This:C1470._ext_write_l($vL_value)
				CALL SUBFORM CONTAINER:C1086(k_OnDataChange)  // Click
				This:C1470._redraw()
			End if 
		End if 
	Else 
		wox_sounds_play_edit()
	End if 
	
	
	
Function _opacity_svg($vL_value : Integer)
	var $is_small : Boolean
	var $vL_width; $vL_height; $vL_svg_scale; $vL_colors; $vL_type; $vL_cx; $vL_cy; $vL_d; $vL_rxy; $vL_r1; $vL_size : Integer
	var $vL_r : Integer
	var $vJ_prefs : Object
	var $vP_canvas : Pointer
	var $vR_dx; $vR_dy; $vR_rx; $vR_ry; $vR_coef : Real
	var $vT_svg_ref; $vT_stroke; $vT_fill; $vT_svg_group; $vT_svg_rect; $vT_svg_circle; $vT_text; $vT_font_face; $vT_svg_txt : Text
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	x_widthHeight_Object($vP_canvas; ->$vL_width; ->$vL_height)
	$is_small:=($vL_height<30)
	$vJ_prefs:=wos__storage_prefs()
	$vL_svg_scale:=$vJ_prefs.l_svg_scale
	$vL_width*=$vL_svg_scale
	$vL_height*=$vL_svg_scale
	
	$vL_colors:=This:C1470.l_colors
	$vL_type:=This:C1470.l_type
	$vR_coef:=This:C1470.r_coef
	//$type:=1
	
	
	$vT_svg_ref:=SVG_New($vL_width; $vL_height; "SVG_zoom"; "SVG_zoom"; True:C214; Truncated centered:K6:1)
	
	$vL_cx:=$vL_width/2
	$vL_cy:=$vL_height/2
	
	// Text in Black or White
	woc_sp_colors_to_svg($vL_colors; ->$vT_stroke; ->$vT_fill)
	//$vT_colourRGB_svg:=woc_sp_colourToColourRGB($vT_colour_svg)
	//$vL_rgb:=woc_sp_colourToColorRGB($vT_colourRGB_svg)
	////$vT_colour_text:=Choose(woc_colorRGB_isWhiteFor($vL_rgb); "white"; "black")
	//$vT_colour_text:=woc_sp_color_to_svg(woc_sp_color_s_for_f($vL_rgb))
	
	$vT_svg_group:=SVG_New_group($vT_svg_ref)
	If ($is_small)
		$vR_dx:=$vL_width*$vR_coef
		$vR_dy:=$vL_height*$vR_coef
		$vL_d:=$vR_dx  // For text size
		
		$vL_rxy:=0
		$vR_rx:=$vR_dx/2
		$vR_ry:=$vR_dy/2
		$vT_svg_rect:=SVG_New_rect($vT_svg_group; $vL_cx-$vR_rx; $vL_cy-$vR_ry; $vR_dx; $vR_dy; $vL_rxy; $vL_rxy; k_none; $vT_fill)
		
	Else 
		$vL_d:=wox_min($vL_width; $vL_height)*$vR_coef
		$vL_r:=$vL_d/2
		$vT_svg_circle:=SVG_New_circle($vT_svg_group; $vL_cx; $vL_cy; $vL_r; k_none; $vT_fill)
		$vL_r1:=$vL_r/6
		//$vT_svg_circle:=SVG_New_circle ($vT_svg_g;$vL_cx+$vL_r-$vL_r1;$vL_cy;$vL_r1;k_none;$vT_colour_text)
		$vT_svg_circle:=SVG_New_circle($vT_svg_group; $vL_cx+$vL_r-$vL_r1; $vL_cy; $vL_r1; k_none; $vT_stroke)
		SVG_SET_TRANSFORM_ROTATE($vT_svg_circle; $vL_value; $vL_cx; $vL_cy)
	End if 
	
	
	$vT_text:=String:C10($vL_value)
	$vT_font_face:=wox_font_face_default()
	$vL_size:=$vL_d*0.4*$vL_svg_scale
	$vT_svg_txt:=SVG_New_text($vT_svg_ref; $vT_text; $vL_cx; $vL_cy-($vL_size*wos__storage_prefs.r_fontOffset_coef); $vT_font_face; $vL_size; Bold:K14:2; 3; $vT_stroke)
	SVG_SET_TEXT_RENDERING($vT_svg_txt; "geometricPrecision")
	
	$vP_canvas->:=SVG_Export_to_picture($vT_svg_ref; 0)
	SVG_CLEAR($vT_svg_ref)
	