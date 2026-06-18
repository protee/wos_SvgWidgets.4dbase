
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		wox_prefs_windows_load()
		
	: ($vL_event_code=On Close Box:K2:21)
		//wox_prefs_windows_save()
		CANCEL:C270
		
End case 


