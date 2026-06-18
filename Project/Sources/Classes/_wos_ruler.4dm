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
	Super:C1705("j_ruler")
	This:C1470.l_value:=0
	
	//This.at_events:=New collection()
	
	
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
	var $vL_width; $vL_height : Integer
	var $vL_yt; $vL_yb; $xl; $vL_xr; $y3; $y2; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_option : Integer
	var $vT_ruler; $vT_format; $vT_label; $vT_tip : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vT_ruler:="ruler_Rlr"
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$xl:=10
	$vL_xr:=$vL_width-2
	$vL_xr:=$vL_xr-10
	$y3:=$vL_yb-20
	$y2:=$y3-10
	$y2:=$vL_yt
	$y3:=$y2+10
	OBJECT GET COORDINATES:C663(*; $vT_ruler; $vL_left; $vL_top; $vL_right; $vL_bottom)
	OBJECT SET COORDINATES:C1248(*; $vT_ruler; $xl; $y2; $vL_xr; $y3)
	$vL_option:=0x0020
	// +10 ruler ; +15 graduation ; +25 labels
	If ($y3<=($vL_yb-5))
		$vL_option:=$vL_option ?+ 4  // Graduation
	End if 
	If ($y3<=($vL_yb-12))
		$vL_option:=$vL_option ?+ 1  // Labels
	End if 
	$vT_format:=String:C10(Form:C1466.l_min)+";"+String:C10(Form:C1466.l_max)+";"+String:C10(Form:C1466.l_unit)+";"+String:C10(Form:C1466.l_step)+";"\
		+String:C10($vL_option)+";##0"
	OBJECT SET FORMAT:C236(*; $vT_ruler; $vT_format)
	$vT_label:=Form:C1466.t_label
	$vT_tip:=Form:C1466.t_tip
	$vT_tip:=$vT_tip#"" ? $vT_tip : $vT_label
	OBJECT SET HELP TIP:C1181(*; $vT_ruler; $vT_tip)
	// *
	// *****
	
	
Function _redraw()
	var $vP_ruler : Pointer
	var $vL_value : Integer
	var $is_editing : Boolean
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "ruler_Rlr")
	$is_editing:=This:C1470.is_editing
	OBJECT SET ENABLED:C1123($vP_ruler->; $is_editing)
	$vL_value:=This:C1470._ext_read_l()
	$vP_ruler->:=$vL_value
	// *
	// *****
	
	
	// *****
	// *
Function _ruler_events($vP__ruler : Pointer)
	$vT_tip_name:="tip"
	$vL_event_code:=Form event code:C388
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		$is_tip_update:=False:C215
		$vL_value:=$vP__ruler->
		Case of 
			: ($vL_event_code=On Mouse Enter:K2:33)
				$is_tip_update:=True:C214
				
			: ($vL_event_code=On Mouse Leave:K2:34)
				OBJECT SET VISIBLE:C603(*; $vT_tip_name; False:C215)
				//OBJECT SET HELP TIP($ptr_ruler->;"")
				
			: ($vL_event_code=On Data Change:K2:15)
				$is_tip_update:=True:C214
				This:C1470._ext_write_l($vL_value)
				CALL SUBFORM CONTAINER:C1086(k_OnDataMove)  // Move
				//x_send_onDataChange(-On Data Change)
				This:C1470._redraw()
				
			: ($vL_event_code=On Clicked:K2:4)
				$is_tip_update:=True:C214
				This:C1470._ext_write_l($vL_value)
				CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
				This:C1470._redraw()
				
			: ($vL_event_code=On Double Clicked:K2:5)
				$is_tip_update:=True:C214
				This:C1470._ext_write_l($vL_value)
				CALL SUBFORM CONTAINER:C1086(k_OnDoubleClicked)
				This:C1470._redraw()
				
		End case 
		
		If ($is_tip_update)
			var $vL_event_code; $vL_value; $vL_min; $vL_max; $vL_left; $vL_top; $vL_right; $vL_bottom; $x; $vL_tip_left; $vL_tip_top; $vL_tip_right; $vL_tip_bottom; $vL_width; $vL_height : Integer
			var $is_editing; $is_tip_update : Boolean
			var $vR_coef : Real
			var $vT_tip_name : Text
			$vL_min:=Form:C1466.l_min
			$vL_max:=Form:C1466.l_max
			$vR_coef:=($vL_value-$vL_min)/($vL_max-$vL_min)  // Coef 0-1
			
			OBJECT GET COORDINATES:C663($vP__ruler->; $vL_left; $vL_top; $vL_right; $vL_bottom)
			$x:=$vL_left+(($vL_right-$vL_left)*$vR_coef)  // Main shift based on value
			
			OBJECT GET COORDINATES:C663(*; $vT_tip_name; $vL_tip_left; $vL_tip_top; $vL_tip_right; $vL_tip_bottom)
			$vL_width:=($vL_tip_right-$vL_tip_left)
			$vL_height:=($vL_tip_bottom-$vL_tip_top)
			If ($vL_tip_bottom<=$vL_top)
				$vL_tip_left:=$x-($vL_width*$vR_coef)  // Little Shift based on tip width
				$vL_tip_right:=$vL_tip_left+$vL_width
			Else 
				If ($vR_coef<0.5)  // Left tip on right, right tip on left
					$vL_tip_left:=$x+10
				Else 
					$vL_tip_left:=$x-$vL_width-10
				End if 
				$vL_tip_right:=$vL_tip_left+$vL_width
				// Calcul selon place
				$vL_tip_top:=$vL_top
				$vL_tip_bottom:=$vL_tip_top+$vL_height
			End if 
			OBJECT MOVE:C664(*; $vT_tip_name; $vL_tip_left; $vL_tip_top; $vL_tip_right; $vL_tip_bottom; *)
			OBJECT SET VISIBLE:C603(*; $vT_tip_name; True:C214)
			OBJECT SET TITLE:C194(*; $vT_tip_name; String:C10($vL_value))
		End if 
		
	Else 
		wox_sounds_play_edit()
	End if 
	// *
	// *****
	
	