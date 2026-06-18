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
	Super:C1705("j_fill")
	
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_tight_height; $vL_width; $vL_height : Integer
	$vL_tight_height:=88
	Case of 
		: ($vT_layout="tight")
			$vL_width:=130
			$vL_height:=$vL_tight_height
		Else 
			$vL_width:=265
			$vL_height:=78
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
			
			//: ($vL_event_code=On Clicked)
			//If ($vT_objectName="canvas")
			//This._canvas_clicked()
			//End if 
	End case 
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height; $vL_h; $y : Integer
	var $vL_yt; $vL_yb; $vL_xr; $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	var $xl; $x0; $y3; $y2; $x1; $y0; $vL_left_x; $vL_right_x; $x : Integer
	var $y1 : Integer
	var $is_displayText : Boolean
	var $vJ_woc_colour : Object
	var $vT_woc_colour; $vT_ot_opacity; $vT_ot_colour : Text
	var $vP_ruler : Pointer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vT_woc_colour:="woc_colour"
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "opacity_Rlr")
	
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$xl:=2
	$vL_xr:=$vL_width-2
	
	$vT_ot_opacity:="ot_opacity"
	$vT_ot_colour:="ot_colour"
	If ($vL_width<200)
		$xl:=$xl+4
		$vL_xr:=$vL_xr-4
		
		$x0:=6
		$y3:=$vL_yb-20
		$y2:=$y3-10
		$x1:=$vL_xr-6
		OBJECT GET COORDINATES:C663($vP_ruler->; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248($vP_ruler->; $xl; $y2; $vL_xr; $y3)
		OBJECT SET VISIBLE:C603(*; $vT_ot_opacity; False:C215)
		
		$y0:=$vL_yt
		$y1:=$y2-6
		$is_displayText:=This:C1470.is_displayText
		OBJECT GET COORDINATES:C663(*; $vT_woc_colour; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_woc_colour; $xl; $y0; $vL_xr; $y1)
		OBJECT SET VISIBLE:C603(*; $vT_ot_colour; False:C215)
		
	Else 
		// Opacity
		$y3:=$vL_yb-20
		$y2:=$y3-10
		$x1:=$vL_xr-4
		OBJECT SET VISIBLE:C603(*; $vT_ot_opacity; True:C214)
		OBJECT GET COORDINATES:C663(*; $vT_ot_opacity; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h:=$vL_bottom-$vL_top
		$y:=$y2-4
		OBJECT SET COORDINATES:C1248(*; $vT_ot_opacity; $vL_left; $y; $vL_right; $y+$vL_h)
		
		OBJECT GET COORDINATES:C663($vP_ruler->; $vL_left_x; $vL_top; $vL_right_x; $vL_bottom)
		OBJECT SET COORDINATES:C1248($vP_ruler->; $vL_right; $y2; $x1; $y3)
		
		// Colour
		$y0:=$vL_yt
		$y1:=$y2-6
		OBJECT SET VISIBLE:C603(*; $vT_ot_colour; True:C214)
		OBJECT GET COORDINATES:C663(*; $vT_ot_colour; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h:=$vL_bottom-$vL_top
		$y:=($y1-$y0)/2-8+$y0
		OBJECT SET COORDINATES:C1248(*; $vT_ot_colour; $vL_left; $y; $vL_right; $y+$vL_h)
		
		$is_displayText:=This:C1470.is_displayText
		OBJECT GET COORDINATES:C663(*; $vT_woc_colour; $vL_left_x; $vL_top; $vL_right_x; $vL_bottom)
		$x:=Choose:C955($is_displayText; $x1; $vL_left+$y1-$y0)
		OBJECT SET COORDINATES:C1248(*; $vT_woc_colour; $vL_right; $y0; $x; $y1)
	End if 
	$vJ_woc_colour:=OBJECT Get value:C1743($vT_woc_colour)
	$vJ_woc_colour.resize($vT_woc_colour)
	// *
	// *****
	
	
Function _redraw()
	var $is_editing : Boolean
	var $vJ_woc_colour : Object
	var $vP_ruler : Pointer
	$is_editing:=This:C1470.is_editing
	$vJ_woc_colour:=OBJECT Get value:C1743("woc_colour")
	$vJ_woc_colour.is_editing:=$is_editing
	$vJ_woc_colour.t_colour:=This:C1470.t_colour
	$vJ_woc_colour.is_displayText:=This:C1470.is_displayText
	$vJ_woc_colour.redraw()
	
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "opacity_Rlr")
	$vP_ruler->:=This:C1470.l_opacity
	OBJECT SET ENABLED:C1123($vP_ruler->; $is_editing)
	// *
	// *****
	
	
	// *****
	// *
Function _colour_chge($vJ_widget : Object)
	This:C1470.t_colour:=$vJ_widget.t_colour
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)  // Move
	
	
Function _opacity_rlr($vP_object : Pointer)
	var $is_editing : Boolean
	var $vL_event_code : Integer
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		$vL_event_code:=Form event code:C388
		This:C1470.l_opacity:=$vP_object->
		Case of 
			: ($vL_event_code=On Data Change:K2:15)
				CALL SUBFORM CONTAINER:C1086(k_OnDataMove)  // Move
				
			: ($vL_event_code=On Clicked:K2:4)
				CALL SUBFORM CONTAINER:C1086(k_OnDataChange)  // Move
		End case 
		//This._redraw()
	Else 
		wox_sounds_play_edit()
	End if 
	// *
	// *****
	
	