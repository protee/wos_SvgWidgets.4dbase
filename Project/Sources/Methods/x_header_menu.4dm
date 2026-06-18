//%attributes = {"lang":"en"}

#DECLARE($vT_refMenu : Text; $vT_label : Text; $vT_path_menu : Text)

If ($vT_label#"")
	APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
	DISABLE MENU ITEM:C150($vT_refMenu; -1)
	If ($vT_path_menu#"none")
		//If ($vT_path_menu="")
		//$vT_path_menu:="path:/RESOURCES/icons/icn_infos"
		//End if 
		//SET MENU ITEM ICON($vT_refMenu; -1; $vT_path_menu+k_png_ext)
		If ($vT_path_menu#"")
			SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+k_png_ext)
		End if 
	End if 
	//APPEND MENU ITEM($vT_refMenu; "-")
End if 
