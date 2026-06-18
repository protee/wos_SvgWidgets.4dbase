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
	Super:C1705("j_stroke")
	
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_tight_height; $vL_width; $vL_height : Integer
	var $is_cmj : Boolean
	var $vJ_widget : Object
	$vL_tight_height:=88
	$vJ_widget:=This:C1470
	Case of 
		: ($vT_layout="tight")
			$is_cmj:=($vJ_widget.is_cap & $vJ_widget.is_marker & $vJ_widget.is_join)
			$vL_width:=Choose:C955($is_cmj; 145; 130)
			$vL_height:=$vL_tight_height
		Else 
			$vL_width:=265
			//$height:=138
			$is_cmj:=($vJ_widget.is_cap | $vJ_widget.is_marker | $vJ_widget.is_join)
			$vL_height:=Choose:C955($is_cmj; 138; 110)
			
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
	var $xl; $y3; $y2; $x1; $y0; $vL_left_x; $vL_right_x; $x : Integer
	var $y5; $y4; $vL_w; $vL_w1; $vL_h1; $vL_left_w; $vL_top_w; $vL_right_w; $vL_bottom_w; $x3; $x2; $x5 : Integer
	var $y1 : Integer
	var $is_displayText; $is_cap; $is_marker; $is_join : Boolean
	var $vJ_woc_colour; $vJ_widget : Object
	var $vT_woc_colour; $vT_ot_opacity; $vT_ot_colour : Text
	var $vT_wos_width; $vT_wos_marker; $vT_wos_dash; $vT_wos_join; $vT_wos_cap; $vT_ot_cap; $vT_ot_marker; $vT_ot_join; $vT_ot_width; $vT_ot_dash : Text
	var $vP_ruler : Pointer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vT_woc_colour:="woc_colour"
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "opacity_rlr")
	
	$vT_wos_width:="wos_width"
	$vT_wos_marker:="wos_marker"
	$vT_wos_dash:="wos_dash"
	$vT_wos_join:="wos_join"
	$vT_wos_cap:="wos_cap"
	
	
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$xl:=2
	$vL_xr:=$vL_width-2
	
	$is_cap:=This:C1470.is_cap
	$is_marker:=This:C1470.is_marker
	$is_join:=This:C1470.is_join
	$vT_ot_cap:="ot_cap"
	$vT_ot_marker:="ot_marker"
	$vT_ot_join:="ot_join"
	$vT_ot_width:="ot_width"
	$vT_ot_dash:="ot_dash"
	$vT_ot_opacity:="ot_opacity"
	$vT_ot_colour:="ot_colour"
	
	If ($vL_width<200)
		$xl:=$xl+4
		$vL_xr:=$vL_xr-4
		$y5:=$vL_yb+8
		$y4:=$y5-14
		// Cap and Marker and Join
		
		OBJECT SET VISIBLE:C603(*; $vT_ot_cap; False:C215)
		OBJECT SET VISIBLE:C603(*; $vT_ot_marker; False:C215)
		OBJECT SET VISIBLE:C603(*; $vT_ot_join; False:C215)
		OBJECT GET COORDINATES:C663(*; $vT_ot_cap; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_cap; $vL_left; $y4; $vL_right; $y5)
		OBJECT GET COORDINATES:C663(*; $vT_ot_join; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_join; $vL_left; $y4; $vL_right; $y5)
		OBJECT GET COORDINATES:C663(*; $vT_ot_marker; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_marker; $vL_left; $y4; $vL_right; $y5)
		OBJECT SET VISIBLE:C603(*; $vT_wos_cap; $is_cap)
		OBJECT SET VISIBLE:C603(*; $vT_wos_marker; $is_marker)
		OBJECT SET VISIBLE:C603(*; $vT_wos_join; $is_join)
		
		$x1:=$xl
		OBJECT GET COORDINATES:C663(*; $vT_wos_width; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		$vL_h:=$vL_bottom-$vL_top
		$vL_w1:=20
		$vL_h1:=20
		
		$y4:=$y5-$vL_h
		// Width
		OBJECT GET COORDINATES:C663(*; $vT_ot_width; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_width; $vL_left; $y4; $vL_right; $y5)
		OBJECT SET VISIBLE:C603(*; $vT_ot_width; False:C215)
		OBJECT SET COORDINATES:C1248(*; $vT_wos_width; $x1; $y4; $x1+$vL_w; $y5)
		$vJ_widget:=OBJECT Get value:C1743($vT_wos_width)
		$vJ_widget.resize()
		$x1:=$x1+$vL_w+2
		
		// Dash
		OBJECT GET COORDINATES:C663(*; $vT_ot_dash; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_dash; $vL_left; $y4; $vL_right; $y5)
		OBJECT SET VISIBLE:C603(*; $vT_ot_dash; False:C215)
		OBJECT SET COORDINATES:C1248(*; $vT_wos_dash; $x1; $y4; $x1+$vL_w; $y5)
		$vJ_widget:=OBJECT Get value:C1743($vT_wos_dash)
		$vJ_widget.resize()
		$x1:=$x1+$vL_w+2
		
		OBJECT SET COORDINATES:C1248(*; $vT_wos_cap; $x1; $y4; $x1+$vL_w; $y5)
		If ($is_cap)
			$vJ_widget:=OBJECT Get value:C1743($vT_wos_cap)
			$vJ_widget.resize()
			$x1:=$x1+$vL_w+2
		End if 
		
		OBJECT SET COORDINATES:C1248(*; $vT_wos_join; $x1; $y5-$vL_h1; $x1+$vL_w1; $y5)  // Special size
		If ($is_join)
			$vJ_widget:=OBJECT Get value:C1743($vT_wos_join)
			$vJ_widget.resize()
			$x1:=$x1+$vL_w1+2
		End if 
		
		OBJECT SET COORDINATES:C1248(*; $vT_wos_marker; $x1; $y4; $x1+$vL_w; $y5)
		If ($is_marker)
			$vJ_widget:=OBJECT Get value:C1743($vT_wos_marker)
			$vJ_widget.resize()
		End if 
		
		
		// Opacity
		$y3:=$y4-12
		$y2:=$y3-10
		OBJECT GET COORDINATES:C663(*; $vT_ot_opacity; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_opacity; $vL_left; $y2-4; $vL_right; $y3)
		OBJECT SET VISIBLE:C603(*; $vT_ot_opacity; False:C215)
		OBJECT SET COORDINATES:C1248($vP_ruler->; $xl; $y2; $vL_xr; $y3)
		
		// Colour
		$y0:=$vL_yt
		$y1:=$y2-6
		OBJECT GET COORDINATES:C663(*; $vT_ot_colour; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_ot_colour; $vL_left; $y0; $vL_right; $y1)
		OBJECT SET VISIBLE:C603(*; $vT_ot_colour; False:C215)
		OBJECT SET COORDINATES:C1248(*; $vT_woc_colour; $xl; $y0; $vL_xr; $y1)
		$vJ_woc_colour:=OBJECT Get value:C1743($vT_woc_colour)
		$vJ_woc_colour.resize($vT_woc_colour)
		$vJ_woc_colour.redraw()
		OBJECT SET VISIBLE:C603(*; $vT_woc_colour; True:C214)
		
	Else 
		
		$y5:=$vL_yb-2
		
		// Cap and Marker and Join
		OBJECT GET COORDINATES:C663(*; $vT_wos_cap; $vL_left_w; $vL_top_w; $vL_right_w; $vL_bottom_w)
		
		OBJECT SET VISIBLE:C603(*; $vT_wos_cap; $is_cap)
		OBJECT SET VISIBLE:C603(*; $vT_ot_cap; $is_cap)
		OBJECT SET VISIBLE:C603(*; $vT_wos_marker; $is_marker)
		OBJECT SET VISIBLE:C603(*; $vT_ot_marker; $is_marker)
		OBJECT SET VISIBLE:C603(*; $vT_wos_join; $is_join)
		OBJECT SET VISIBLE:C603(*; $vT_ot_join; $is_join)
		If ($is_cap | $is_marker | $is_join)
			$vL_h:=$vL_bottom_w-$vL_top_w
			$y4:=$y5-$vL_h
			$y:=$y4+$y5/2-8
			
			If ($is_cap)
				OBJECT GET COORDINATES:C663(*; $vT_ot_cap; $vL_left; $vL_top; $vL_right; $vL_bottom)
				$vL_h1:=$vL_bottom-$vL_top
				OBJECT SET COORDINATES:C1248(*; $vT_ot_cap; $vL_left; $y; $vL_right; $y+$vL_h1)
				OBJECT SET COORDINATES:C1248(*; $vT_wos_cap; $vL_right; $y4; $vL_right+$vL_h; $y5)
				$vJ_widget:=OBJECT Get value:C1743($vT_wos_cap)
				$vJ_widget.resize()
			End if 
			
			$x3:=$vL_xr
			$x2:=$vL_xr-$vL_h
			$x1:=$x3
			If ($is_join)
				OBJECT GET COORDINATES:C663(*; $vT_ot_join; $vL_left; $vL_top; $vL_right; $vL_bottom)
				$vL_w:=$vL_right-$vL_left
				OBJECT SET COORDINATES:C1248(*; $vT_ot_join; $x2-$vL_w; $y; $x2; $y+$vL_h)
				OBJECT SET COORDINATES:C1248(*; $vT_wos_join; $x2; $y4; $x3; $y5)
				$vJ_widget:=OBJECT Get value:C1743($vT_wos_join)
				$vJ_widget.resize()
				$x1:=$x2-$vL_w
			End if 
			
			$x3:=$x1
			$x2:=$x1-$vL_h
			If ($is_marker)
				OBJECT GET COORDINATES:C663(*; $vT_ot_marker; $vL_left; $vL_top; $vL_right; $vL_bottom)
				$vL_w:=$vL_right-$vL_left
				OBJECT SET COORDINATES:C1248(*; $vT_ot_marker; $x2-$vL_w; $y; $x2; $y+$vL_h)
				OBJECT SET COORDINATES:C1248(*; $vT_wos_marker; $x2; $y4; $x3; $y5)
				$vJ_widget:=OBJECT Get value:C1743($vT_wos_marker)
				$vJ_widget.resize()
			End if 
			$y5:=$y4
		End if 
		
		// Width
		OBJECT GET COORDINATES:C663(*; $vT_wos_width; $vL_left_w; $vL_top_w; $vL_right_w; $vL_bottom_w)
		$vL_h:=$vL_bottom_w-$vL_top_w
		$y4:=$y5-$vL_h
		
		OBJECT GET COORDINATES:C663(*; $vT_ot_width; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h1:=$vL_bottom-$vL_top
		$y:=$y4+$y5/2-8
		OBJECT SET COORDINATES:C1248(*; $vT_ot_width; $vL_left; $y; $vL_right; $y+$vL_h1)
		OBJECT SET VISIBLE:C603(*; $vT_ot_width; True:C214)
		
		OBJECT SET COORDINATES:C1248(*; $vT_wos_width; $vL_right; $y4; $vL_right+$vL_h; $y5)
		$vJ_widget:=OBJECT Get value:C1743($vT_wos_width)
		$vJ_widget.resize()
		
		// Dash
		OBJECT GET COORDINATES:C663(*; $vT_wos_dash; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		$x5:=$vL_xr-$vL_w
		OBJECT SET COORDINATES:C1248(*; $vT_wos_dash; $x5; $y4; $vL_xr; $y5)
		$vJ_widget:=OBJECT Get value:C1743($vT_wos_dash)
		$vJ_widget.resize()
		OBJECT GET COORDINATES:C663(*; $vT_ot_dash; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		OBJECT SET COORDINATES:C1248(*; $vT_ot_dash; $x5-$vL_w; $y; $x5; $y+$vL_h)
		OBJECT SET VISIBLE:C603(*; $vT_ot_dash; True:C214)
		
		
		// Opacity
		$y3:=$y4-20
		$y2:=$y3-10
		$x1:=$vL_xr-4
		OBJECT GET COORDINATES:C663(*; $vT_ot_opacity; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h:=$vL_bottom-$vL_top
		$y:=$y2-4
		OBJECT SET COORDINATES:C1248(*; $vT_ot_opacity; $vL_left; $y; $vL_right; $y+$vL_h)
		OBJECT SET VISIBLE:C603(*; $vT_ot_opacity; True:C214)
		
		OBJECT GET COORDINATES:C663($vP_ruler->; $vL_left; $vL_top; $vL_right_x; $vL_bottom)
		OBJECT SET COORDINATES:C1248($vP_ruler->; $vL_right; $y2; $x1; $y3)
		
		// Colour
		$y0:=$vL_yt
		$y1:=$y2-6
		OBJECT GET COORDINATES:C663(*; $vT_ot_colour; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_h:=$vL_bottom-$vL_top
		$y:=($y1-$y0)/2-8+$y0
		OBJECT SET COORDINATES:C1248(*; $vT_ot_colour; $vL_left; $y; $vL_right; $y+$vL_h)
		OBJECT SET VISIBLE:C603(*; $vT_ot_colour; True:C214)
		$is_displayText:=This:C1470.is_displayText
		OBJECT GET COORDINATES:C663(*; $vT_woc_colour; $vL_left_x; $vL_top; $vL_right_x; $vL_bottom)
		$x:=Choose:C955($is_displayText; $x1; $vL_right+$y1-$y0)
		OBJECT SET COORDINATES:C1248(*; $vT_woc_colour; $vL_right; $y0; $x; $y1)
		$vJ_woc_colour:=OBJECT Get value:C1743($vT_woc_colour)
		$vJ_woc_colour.resize($vT_woc_colour)
		//$vJ_woc_colour.redraw()
	End if 
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
	
	This:C1470.wos_widget_set("wos_width"; This:C1470.l_width)
	This:C1470.wos_widget_set("wos_marker"; This:C1470.l_marker)
	This:C1470.wos_widget_set("wos_dash"; This:C1470.l_dash)
	This:C1470.wos_widget_set("wos_join"; This:C1470.l_join)
	This:C1470.wos_widget_set("wos_cap"; This:C1470.l_cap)
	
	
Function wos_widget_set($vT_widget : Text; $vL_value : Integer)
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.l_value:=$vL_value
	$vJ_widget.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _colour_chge($vJ_widget : Object)
	This:C1470.t_colour:=$vJ_widget.t_colour
	This:C1470._send_onDataChange()
	
Function _send_onDataChange()
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
	
	