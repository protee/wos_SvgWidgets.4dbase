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
	Super:C1705("j_zoom")
	This:C1470.l_value:=0
	
	//This.at_events:=New collection()
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_tight_height; $vL_width; $vL_height : Integer
	$vL_tight_height:=88
	Case of 
		: ($vT_layout="tight")
			$vL_width:=55
			$vL_height:=44
		Else 
			$vL_width:=265
			$vL_height:=54
	End case 
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
	var $is_ruler : Boolean
	var $vP_ruler; $vP_canvas : Pointer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "zoom_Rlr")
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$vL_svg_xl:=2
	$vL_xr:=$vL_width-2
	$vL_h:=$vL_yb-$vL_yt
	$is_ruler:=($vL_width>=100)
	OBJECT SET VISIBLE:C603($vP_ruler->; $is_ruler)
	If ($is_ruler)
		$vL_svg_xr:=$vL_svg_xl+$vL_h
		OBJECT GET COORDINATES:C663($vP_ruler->; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h:=$vL_bottom-$vL_top
		$y:=$vL_yt+8
		$y:=$vL_h/2+$vL_yt-6
		$y:=$vL_h/2+$vL_yt+24
		$y:=wox_min($y; $vL_yb)-30
		OBJECT SET COORDINATES:C1248($vP_ruler->; $vL_svg_xr+4; $y; $vL_xr-10; $y+$vL_h)
	Else 
		//$vL_svg_xl:=($width-$vL_h)/2
		//$vL_svg_xr:=$vL_svg_xl+$vL_h
		$vL_svg_xr:=$vL_width-4
	End if 
	OBJECT SET COORDINATES:C1248($vP_canvas->; $vL_svg_xl; $vL_yt; $vL_svg_xr; $vL_yb)
	// *
	// *****
	
	
Function _redraw()
	var $vP_ruler : Pointer
	var $vL_value : Integer
	var $is_editing; $is_ruler : Boolean
	$is_editing:=This:C1470.is_editing
	$vL_value:=This:C1470._ext_read_l()
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "zoom_Rlr")
	$is_ruler:=OBJECT Get visible:C1075($vP_ruler->)
	If ($is_ruler)
		$vP_ruler->:=$vL_value
		OBJECT SET ENABLED:C1123($vP_ruler->; $is_editing)
	End if 
	This:C1470._zoom_svg($vL_value)
	// *
	// *****
	
	
	// *****
	// *
Function _ruler_events($vP__ruler : Pointer)
	var $is_editing : Boolean
	var $vL_event_code; $vL_value : Integer
	var $vT_tip_name : Text
	$vT_tip_name:="tip"
	$vL_event_code:=Form event code:C388
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		If (Right click:C712)
			If ($vL_event_code=On Clicked:K2:4)
				This:C1470._zoom_menu()
			End if 
		Else 
			$vL_value:=Self:C308->
			This:C1470._ext_write_l($vL_value)
			Case of 
				: ($vL_event_code=On Data Change:K2:15)
					CALL SUBFORM CONTAINER:C1086(k_OnDataMove)  // Move
					This:C1470._redraw()
					
				: ($vL_event_code=On Clicked:K2:4)
					CALL SUBFORM CONTAINER:C1086(k_OnDataChange)  // Click
					This:C1470._redraw()
			End case 
		End if 
	Else 
		wox_sounds_play_edit()
	End if 
	
Function _zoom_menu()
	var $isOk : Boolean
	var $vC_al_zooms : Collection
	var $vL_zoom; $vL_value : Integer
	var $vT_MenuRef; $vT_zoom; $vT_answerMenu : Text
	$vC_al_zooms:=New collection:C1472()
	$vC_al_zooms.push(50; 75; 100; 125; 150; 200; 300)
	$vT_MenuRef:=Create menu:C408
	For each ($vL_zoom; $vC_al_zooms)
		$vT_zoom:=String:C10($vL_zoom)
		APPEND MENU ITEM:C411($vT_MenuRef; $vT_zoom+"%")
		SET MENU ITEM PARAMETER:C1004($vT_MenuRef; -1; $vT_zoom)
	End for each 
	
	$vT_answerMenu:=Dynamic pop up menu:C1006($vT_MenuRef)
	RELEASE MENU:C978($vT_MenuRef)
	$isOk:=($vT_answerMenu#"")
	If ($isOk)
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
			This:C1470._zoom_menu()
		Else 
			$vJ_params:=New object:C1471
			$vJ_params.t_label:="Zoom"
			$vJ_params.l_min:=50
			$vJ_params.l_max:=300
			$vJ_params.l_unit:=50
			$vJ_params.l_step:=1
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
	
	
	
Function _zoom_svg($vL_value : Integer)
	var $is_small : Boolean
	var $vL_width; $vL_height; $vL_svg_scale; $vL_colors; $vL_type; $vL_cx; $vL_cy; $vL_d; $vL_rxy; $vL_r1; $vL_size : Integer
	var $vL_z_max; $vL_d1; $vL_cyr : Integer
	var $vJ_prefs : Object
	var $vP_canvas : Pointer
	var $vR_dx; $vR_dy; $vR_rx; $vR_ry; $vR_coef : Real
	var $vR_r; $vR_rd2 : Real
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
	$vL_z_max:=300
	
	$vL_cx:=$vL_width/2
	$vL_cy:=$vL_height/2
	
	// Text in Black or White
	woc_sp_colors_to_svg($vL_colors; ->$vT_stroke; ->$vT_fill)
	//$vT_colourRGB_svg:=woc_sp_colourToColourRGB($vT_colour_svg)
	//$vL_rgb:=woc_sp_colourToColorRGB($vT_colourRGB_svg)
	////$vT_colour_text:=Choose(woc_colorRGB_isWhiteFor($vL_rgb); "white"; "black")
	//$vT_colour_text:=woc_sp_color_to_svg(woc_sp_color_s_for_f($vL_rgb))
	
	$vT_svg_group:=SVG_New_group($vT_svg_ref)
	Case of 
		: ($vL_type=0)
			If ($is_small)
				$vR_dx:=$vL_width*$vR_coef
				$vR_dy:=$vL_height*$vR_coef
				$vL_d:=$vR_dx  // For text size
				$vR_r:=0
				
				$vL_rxy:=0
				$vR_rx:=$vR_dx/2
				$vR_ry:=$vR_dy/2
				$vT_svg_rect:=SVG_New_rect($vT_svg_group; $vL_cx-$vR_rx; $vL_cy-$vR_ry; $vR_dx; $vR_dy; $vL_rxy; $vL_rxy; k_none; $vT_fill)
				
			Else 
				$vL_d:=wox_min($vL_width; $vL_height)*$vR_coef
				$vL_rxy:=0
				$vR_r:=$vL_d/2
				$vT_svg_rect:=SVG_New_rect($vT_svg_group; $vL_cx-$vR_r; $vL_cy-$vR_r; $vL_d; $vL_d; $vL_rxy; $vL_rxy; k_none; $vT_fill)
				
				$vR_rd2:=$vR_r/2
				$vL_cyr:=$vL_cy-$vR_rd2
				$vR_dy:=$vR_rd2
				$vR_ry:=$vR_dy/2
				
				$vR_dx:=$vL_d*100/$vL_z_max
				$vR_rx:=$vR_dx/2
				$vT_svg_rect:=SVG_New_rect($vT_svg_group; $vL_cx-$vR_rx; $vL_cyr-$vR_ry; $vR_dx; $vR_dy; $vL_rxy; $vL_rxy; $vT_stroke; k_none)
				
				$vR_dy:=$vR_ry/2
				$vR_ry:=$vR_dy/2
				$vR_dx:=$vL_d*$vL_value/$vL_z_max
				$vR_rx:=$vR_dx/2
				//$vT_svg_rect:=SVG_New_rect ($vT_svg_g;$cx-$rx;$cy-$ry;$dx;$dy;$vL_rxy;$vL_rxy;k_none;$vT_colour_svg)
				$vT_svg_rect:=SVG_New_rect($vT_svg_group; $vL_cx-$vR_rx; $vL_cyr-$vR_ry-1; $vR_dx; $vR_dy+2; $vL_rxy; $vL_rxy; $vT_stroke; $vT_stroke)
			End if 
			
			
		: ($vL_type=1)
			$vL_d:=wox_min($vL_width; $vL_height)*$vR_coef
			$vL_d1:=$vL_d*$vL_value/$vL_z_max
			$vL_r1:=$vL_d1/2
			$vT_svg_circle:=SVG_New_circle($vT_svg_group; $vL_cx; $vL_cy; $vL_r1; k_none; $vT_fill)
			
			$vL_d1:=$vL_d*100/$vL_z_max
			$vL_r1:=$vL_d1/2
			$vT_svg_circle:=SVG_New_circle($vT_svg_group; $vL_cx; $vL_cy; $vL_r1; $vT_stroke; k_none)
			
	End case 
	
	$vT_text:=String:C10($vL_value)
	$vT_font_face:=wox_font_face_default()
	$vL_size:=$vL_d*0.3*$vL_svg_scale
	$vT_svg_txt:=SVG_New_text($vT_svg_ref; $vT_text; $vL_cx; $vL_cy-($vL_size*wos__storage_prefs.r_fontOffset_coef)+($vR_r/2); $vT_font_face; $vL_size; Bold:K14:2; 3; $vT_stroke)
	SVG_SET_TEXT_RENDERING($vT_svg_txt; "geometricPrecision")
	
	$vP_canvas->:=SVG_Export_to_picture($vT_svg_ref; 0)
	SVG_CLEAR($vT_svg_ref)
	