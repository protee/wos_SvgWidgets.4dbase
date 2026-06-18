// *****
// *
// Class: _wos_tools
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
	Super:C1705("j_edits")
	This:C1470.t_value:=0
	This:C1470._init()
	//This.at_events:=New collection()
	
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_tight_height; $vL_width; $vL_height : Integer
	$vL_tight_height:=88
	Case of 
		: ($vT_layout="tight")
			$vL_width:=104
			$vL_height:=$vL_tight_height
		Else 
			$vL_width:=200
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
			If ($vT_objectName="@_btn")
				This:C1470._btn_clicked($vT_objectName)
			End if 
	End case 
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _init()
	var $vC_at_keys : Collection
	$vC_at_keys:=New collection:C1472()
	$vC_at_keys.push("undo"; "redo"; "cut"; "copy"; "paste"; "clear")
	This:C1470._at_keys:=$vC_at_keys
	
	
Function _resize()
	var $vL_width; $vL_height; $vL_yt; $vL_yb; $vL_gap; $xl : Integer
	var $vL_mask : Integer
	var $vC_at_names; $vC_at_keys : Collection
	var $vT_key : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vC_at_keys:=This:C1470._at_keys
	$vC_at_names:=New collection:C1472()
	For each ($vT_key; $vC_at_keys)
		$vC_at_names.push($vT_key+"_btn")
	End for each 
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$vL_gap:=2
	$xl:=4+$vL_gap
	$vL_mask:=Form:C1466.l_mask
	w_resize_btns($vL_width; $xl; $vL_yt; $vL_gap; $vC_at_names; $vL_mask)
	// *
	// *****
	
	
Function _redraw()
	var $idx; $vL_enablers : Integer
	var $is_editing; $is_countOne; $is_countTwo; $is_enabled : Boolean
	var $vC_at_keys : Collection
	var $vT_key; $vT_btn : Text
	var $vJ_enablers : Object
	$is_editing:=This:C1470.is_editing
	$vL_enablers:=This:C1470.l_enablers
	$is_countOne:=($vL_enablers>=1) & $is_editing
	$is_countTwo:=($vL_enablers>=2) & $is_editing
	//$vT_value:=This._ext_read_t()
	$vC_at_keys:=This:C1470._at_keys
	$vJ_enablers:=This:C1470.j_enablers
	$idx:=0
	For each ($vT_key; $vC_at_keys)
		$vT_btn:=$vT_key+"_btn"
		$is_enabled:=$vJ_enablers["is_"+$vT_key] & $is_editing
		OBJECT SET ENABLED:C1123(*; $vT_btn; $is_enabled)
		$idx+=1
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _btn_clicked($vT_objectName : Text)
	var $is_editing : Boolean
	var $vT_value : Text
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		$vT_value:=Replace string:C233($vT_ObjectName; "_btn"; "")
		This:C1470._ext_write_t($vT_value)
		CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	Else 
		wox_sounds_play_edit()
	End if 
	This:C1470._redraw()
	// *
	// *****
	
	