//%attributes = {}

wok_init()
wox_initRegister()

//Run ogPop
//This code is available even if the component is not present like in the final application.
If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222($aT_components; 0)
	COMPONENT LIST:C1001($aT_components)
	//If (Find in array($aT_components; "4DPop")>0)
	//EXECUTE METHOD("4DPop_launch")
	//End if 
	
	If (Find in array:C230($aT_components; "wod_DevTools")>0)
		var $isOk : Boolean  // For ever
		EXECUTE METHOD:C1007("wod_initRegister"; $isOk)
		var $vJ_prefs : Object
		EXECUTE METHOD:C1007("wod__storage_prefs"; $vJ_prefs)
		Use ($vJ_prefs)
			$vJ_prefs.fu_FORM_EDIT:=Formula:C1597(_wod_FORM_EDIT)
		End use 
		EXECUTE METHOD:C1007("wod_palette")
	End if 
	
	
	wos_initRegister()
	If (Find in array:C230($aT_components; "wom_Make")>0)
		EXECUTE METHOD:C1007("wom_initRegister"; $isOk)
		EXECUTE METHOD:C1007("wom_configurate_vJ"; *; wos__storage_prefs())
	End if 
	
End if 

SET DATABASE LOCALIZATION:C1104("en")
