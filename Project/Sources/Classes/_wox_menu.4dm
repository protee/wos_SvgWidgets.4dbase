
Class constructor
	
Function getMenu($vT_prefix : Text; $vT_refMenu : Text; $is_inline : Boolean)->$vT_refMenu_answer : Text
	var $is_toAttach : Boolean
	var $vC_at_menu_keys : Collection
	var $idx : Integer
	var $vT_label; $vT_path_menu; $vT_item; $vT_icon; $vT_translated : Text
	var $vT_subPath_icon; $vT_app : Text
	var $vJ_prefs : Object
	
	$is_toAttach:=($vT_refMenu#"")
	$vJ_prefs:=wos__storage_prefs()
	$vT_app:=$vJ_prefs.t_app+"_"
	//$vT_label:=$vJ_prefs.t_name+"© "+x_get_localized(k_rsct_menu; $vT_app+"actions")
	$vT_label:=x_get_localized(k_rsct_menu; $vT_app+"actions")
	$vT_refMenu_answer:=$is_toAttach && $is_inline ? $vT_refMenu : Create menu:C408()
	x_header_menu($vT_refMenu_answer; $vT_label)
	
	$vT_subPath_icon:="main/icn_"
	$vT_path_menu:="path:/RESOURCES/"+$vT_subPath_icon
	//$vT_prefix:=$vT_prefix#"" ? $vT_prefix+"." : ""
	
	$vC_at_menu_keys:=New collection:C1472()
	$vC_at_menu_keys.push("widgets_mng"; "editor_demo")  // "Create from Tables/Fields/Properties"
	
	$idx:=0
	For each ($vT_item; $vC_at_menu_keys)
		If ($vT_item="")
			APPEND MENU ITEM:C411($vT_refMenu_answer; "-")
		Else 
			$vT_icon:=$vT_item
			$vT_translated:=x_get_localized(k_rsct_menu; $vT_app+$vT_item)
			APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_translated; *)
			SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_prefix+$vT_item)
			SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_icon+k_png_ext)
			$idx+=1
		End if 
	End for each 
	
	If ($is_toAttach) && (Not:C34($is_inline))
		APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_answer; *)
		RELEASE MENU:C978($vT_refMenu_answer)
		$vT_path_menu:="path:/RESOURCES/pictures/icn_product"
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+k_png_ext)
	End if 
	
	
Function doMenu($vT_answer : Text; $vV_params : Variant)->$isOk : Boolean
	Case of 
		: ($vT_answer="widgets_mng")
			This:C1470.doWidgets()
		: ($vT_answer="editor_demo")
			This:C1470.doClock()
	End case 
	
	
Function doWidgets()
	wox_process_new_fu(Formula:C1597(wos_widgets_mng))
	
Function doClock()
	wox_process_new_fu(Formula:C1597(wos_editor_demo))
	