// *****
// *
// Class: _wos_marker
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
	Super:C1705("j_marker")
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
	var $vP_canvas : Pointer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	OBJECT SET COORDINATES:C1248($vP_canvas->; 0; 0; $vL_width; $vL_height)
	// *
	// *****
	
	
Function _redraw()
	var $vP_canvas : Pointer
	var $c4Fi_path : 4D:C1709.File
	var $vL_value : Integer
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	$vL_value:=This:C1470._ext_read_l()
	$c4Fi_path:=Folder:C1567(fk resources folder:K87:11).file("images/marker/marker"+String:C10($vL_value)+".svg")
	READ PICTURE FILE:C678($c4Fi_path.platformPath; $vP_canvas->)
	// *
	// *****
	
	
	// *****
	// *
Function _canvas_clicked()
	var $is_editing; $isOk : Boolean
	var $vC_at_lbl : Collection
	var $vL_value; $idx : Integer
	var $vJ_menu : Object
	var $vP_canvas : Pointer
	var $vT_path_menu; $vT_MenuRef; $vT_label; $vT_answerMenu : Text
	$is_editing:=Form:C1466.is_editing
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	If ($is_editing)
		$vJ_menu:=wos__storage_stuff().j_menu_stroke_marker
		$vC_at_lbl:=$vJ_menu.at_lbl
		$vT_path_menu:="path:/RESOURCES/"+$vJ_menu.t_icn  //images/marker/marker"
		$vL_value:=This:C1470._ext_read_l()
		$vT_MenuRef:=Create menu:C408
		$idx:=0
		For each ($vT_label; $vC_at_lbl)
			APPEND MENU ITEM:C411($vT_MenuRef; $vC_at_lbl[$idx])
			SET MENU ITEM PARAMETER:C1004($vT_MenuRef; -1; String:C10($idx))
			SET MENU ITEM ICON:C984($vT_MenuRef; -1; $vT_path_menu+String:C10($idx)+".svg")
			If ($vL_value=$idx)
				SET MENU ITEM MARK:C208($vT_MenuRef; -1; Char:C90(18))
			End if 
			$idx+=1
		End for each 
		$vT_answerMenu:=Dynamic pop up menu:C1006($vT_MenuRef)
		RELEASE MENU:C978($vT_MenuRef)
		$isOk:=($vT_answerMenu#"")
		If ($isOk)
			$vL_value:=Num:C11($vT_answerMenu)
			This:C1470._ext_write_l($vL_value)
			CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
			This:C1470._redraw()
		End if 
	Else 
		wox_sounds_play_edit()
	End if 
	// *
	// *****
	
	