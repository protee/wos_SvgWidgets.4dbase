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
	Super:C1705("j_tools")
	This:C1470.t_value:=0
	
	//This.at_events:=New collection()
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_tight_height; $vL_width; $vL_height : Integer
	$vL_tight_height:=88
	Case of 
		: ($vT_layout="tight")
			$vL_width:=136
			$vL_height:=$vL_tight_height
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
			If ($vT_objectName="@_RB")
				This:C1470._btn_clicked($vT_objectName)
			End if 
	End case 
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height; $vL_yt; $vL_yb; $vL_gap; $xl : Integer
	var $vC_at_lbl; $vC_at_names : Collection
	var $vT_lbl : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vC_at_lbl:=wos__storage_stuff.at_tools_labels
	$vC_at_names:=New collection:C1472()
	For each ($vT_lbl; $vC_at_lbl)
		$vC_at_names.push($vT_lbl+"_RB")
	End for each 
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$vL_gap:=2
	$xl:=4+$vL_gap
	w_resize_btns($vL_width; $xl; $vL_yt; $vL_gap; $vC_at_names)
	// *
	// *****
	
	
Function _redraw()
	var $vP_btn : Pointer
	var $idx : Integer
	var $is_editing; $is_on; $isOk : Boolean
	var $vC_at_lbl : Collection
	var $vT_value; $vT_lbl : Text
	$is_editing:=This:C1470.is_editing
	$vT_value:=This:C1470._ext_read_t()
	$vC_at_lbl:=wos__storage_stuff.at_tools_labels
	$is_on:=True:C214
	$idx:=0
	For each ($vT_lbl; $vC_at_lbl)
		$vP_btn:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_lbl+"_RB")
		$isOk:=($vT_value=($vT_lbl+"@")) && $is_on
		$is_on:=Not:C34($isOk && $is_on)
		$vP_btn->:=Num:C11($isOk)
		OBJECT SET ENABLED:C1123($vP_btn->; $is_editing)
		$idx+=1
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _btn_clicked($vT_objectName : Text)
	var $is_editing; $is_Sticky; $is_rightClick; $is_do_sticky; $is_stickable; $is_sticked : Boolean
	var $k : Integer
	var $vT_value : Text
	$is_editing:=This:C1470.is_editing
	$is_Sticky:=This:C1470.is_sticky
	$is_rightClick:=Right click:C712
	$is_do_sticky:=($is_Sticky || $is_rightClick) && Not:C34($is_Sticky && $is_rightClick)
	If ($is_editing)
		//$vP_btn:=OBJECT Get pointer(Object with focus)
		//$vT_objectName:=OBJECT Get name(Object current)
		$k:=Position:C15("_"; $vT_objectName)
		If ($k>0)
			$vT_objectName:=Substring:C12($vT_objectName; 1; $k-1)
		End if 
		$is_stickable:=($vT_objectName#"SELECT") && ($vT_objectName#"TEXT") && ($vT_objectName#"IMG")
		$is_sticked:=$is_do_sticky && $is_stickable
		This:C1470.is_sticked:=$is_sticked
		$vT_value:=$vT_objectName+($is_sticked ? "#STICKY" : "")
		This:C1470._ext_write_t($vT_value)
		CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	Else 
		wox_sounds_play_edit()
	End if 
	This:C1470._redraw()
	// *
	// *****
	
	