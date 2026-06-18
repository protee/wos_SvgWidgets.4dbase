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
	Super:C1705("j_actions")
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
			$vL_width:=168
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
	$vC_at_keys.push("2_align"; "2_distribute"; "1_move"; "2_group")
	$vC_at_keys.push("file"; "1_clear"; "clearAll")
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
	var $idx; $vL_count : Integer
	var $is_editing; $is_countOne; $is_countTwo; $is_enabled : Boolean
	var $vC_at_keys : Collection
	var $vT_key; $vT_btn; $vT_type : Text
	$is_editing:=This:C1470.is_editing
	$vL_count:=This:C1470.l_count
	$is_countOne:=($vL_count>=1) & $is_editing
	$is_countTwo:=($vL_count>=2) & $is_editing
	//$vT_value:=This._ext_read_t()
	$vC_at_keys:=This:C1470._at_keys
	$idx:=0
	For each ($vT_key; $vC_at_keys)
		$vT_btn:=$vT_key+"_btn"
		$vT_type:=$vT_key[[1]]
		Case of 
			: $vT_type="1"
				$is_enabled:=$is_countOne
			: $vT_type="2"
				$is_enabled:=$is_countTwo
			Else 
				$is_enabled:=$is_editing
		End case 
		OBJECT SET ENABLED:C1123(*; $vT_btn; $is_enabled)
		$idx+=1
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _btn_clicked($vT_objectName : Text)
	var $is_editing : Boolean
	var $k : Integer
	var $vT_value; $vT_action; $vT_MenuRef; $vT_menuAnswer; $vT_path_icons; $vT_refMenu_dev : Text
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		
		$vT_action:=Replace string:C233($vT_ObjectName; "_btn"; "")
		$k:=Position:C15("_"; $vT_action)
		$vT_action:=$k=2 ? Substring:C12($vT_action; 3) : $vT_action
		
		Case of 
			: ($vT_action="align")
				$vT_MenuRef:=svgE_MENU_align()
				$vT_menuAnswer:=Dynamic pop up menu:C1006($vT_MenuRef)
				RELEASE MENU:C978($vT_MenuRef)
				If ($vT_menuAnswer#"")
					$vT_value:=$vT_menuAnswer
				End if 
				
				
			: ($vT_action="distribute")
				$vT_MenuRef:=svgE_MENU_distribute()
				$vT_menuAnswer:=Dynamic pop up menu:C1006($vT_MenuRef)
				RELEASE MENU:C978($vT_MenuRef)
				If ($vT_menuAnswer#"")
					$vT_value:=$vT_menuAnswer
				End if 
				
				
			: ($vT_action="move")
				$vT_MenuRef:=svgE_MENU_layers()
				$vT_menuAnswer:=Dynamic pop up menu:C1006($vT_MenuRef)
				RELEASE MENU:C978($vT_MenuRef)
				If ($vT_menuAnswer#"")
					$vT_value:=$vT_menuAnswer
				End if 
				
				
			: ($vT_action="group")
				$vT_path_icons:="path:/RESOURCES/images/svg_actions/group"
				$vT_MenuRef:=Create menu:C408
				APPEND MENU ITEM:C411($vT_MenuRef; "Group")
				SET MENU ITEM ICON:C984($vT_MenuRef; -1; $vT_path_icons+"Group.png")
				SET MENU ITEM PARAMETER:C1004($vT_MenuRef; -1; "group-group")
				
				APPEND MENU ITEM:C411($vT_MenuRef; "Ungroup")
				SET MENU ITEM ICON:C984($vT_MenuRef; -1; $vT_path_icons+"Ungroup.png")
				SET MENU ITEM PARAMETER:C1004($vT_MenuRef; -1; "group-ungroup")
				
				$vT_menuAnswer:=Dynamic pop up menu:C1006($vT_MenuRef)
				RELEASE MENU:C978($vT_MenuRef)
				If ($vT_menuAnswer#"")
					$vT_value:=$vT_menuAnswer
				End if 
				
				
			: ($vT_action="file")
				$vT_path_icons:="path:/RESOURCES/images/svg_actions/file"
				$vT_MenuRef:=Create menu:C408
				//APPEND MENU ITEM($vT_MenuRef;"New image")
				//SET MENU ITEM ICON($vT_MenuRef;-1;$vT_path_icons+"New.png")
				//SET MENU ITEM PARAMETER($vT_MenuRef;-1;"file-new")
				
				APPEND MENU ITEM:C411($vT_MenuRef; "Import svg from disk...")
				SET MENU ITEM ICON:C984($vT_MenuRef; -1; $vT_path_icons+"Load.png")
				SET MENU ITEM PARAMETER:C1004($vT_MenuRef; -1; "file-load")
				
				APPEND MENU ITEM:C411($vT_MenuRef; "Export svg to disk...")
				SET MENU ITEM ICON:C984($vT_MenuRef; -1; $vT_path_icons+"Save.png")
				SET MENU ITEM PARAMETER:C1004($vT_MenuRef; -1; "file-save")
				
				
				If (Macintosh command down:C546)
					APPEND MENU ITEM:C411($vT_MenuRef; "-")
					
					If (Not:C34(Is compiled mode:C492))
						APPEND MENU ITEM:C411($vT_MenuRef; "-")
						$vT_refMenu_dev:=Create menu:C408
						APPEND MENU ITEM:C411($vT_refMenu_dev; "Raw dom to desktop...")
						SET MENU ITEM ICON:C984($vT_refMenu_dev; -1; $vT_path_icons+"Save.png")
						SET MENU ITEM PARAMETER:C1004($vT_refMenu_dev; -1; "file-rawDom")
						
						APPEND MENU ITEM:C411($vT_refMenu_dev; "Raw canvas to desktop...")
						SET MENU ITEM ICON:C984($vT_refMenu_dev; -1; $vT_path_icons+"Save.png")
						SET MENU ITEM PARAMETER:C1004($vT_refMenu_dev; -1; "file-rawCanvas")
						
						APPEND MENU ITEM:C411($vT_refMenu_dev; "Raw test...")
						SET MENU ITEM ICON:C984($vT_refMenu_dev; -1; $vT_path_icons+"Save.png")
						SET MENU ITEM PARAMETER:C1004($vT_refMenu_dev; -1; "file-rawTest")
						
						APPEND MENU ITEM:C411($vT_MenuRef; "Developper"; $vT_refMenu_dev)
						RELEASE MENU:C978($vT_refMenu_dev)
					End if 
				End if 
				$vT_menuAnswer:=Dynamic pop up menu:C1006($vT_MenuRef)
				RELEASE MENU:C978($vT_MenuRef)
				If ($vT_menuAnswer#"")
					$vT_value:=$vT_menuAnswer
				End if 
				
			: ($vT_action="clear")
				$vT_value:=$vT_action
				
			: ($vT_action="clearAll")
				$vT_value:=$vT_action
				
		End case 
		If ($vT_value#"")
			This:C1470._ext_write_t($vT_value)
			CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
		End if 
	Else 
		wox_sounds_play_edit()
	End if 
	This:C1470._redraw()
	// *
	// *****
	
	