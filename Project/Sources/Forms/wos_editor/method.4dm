
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		If (vJ_picker_class(cs:C1710._wos_editor.new()))
			Form:C1466._load()
		End if 
	Else 
		Form:C1466._widget_events()
End case 


