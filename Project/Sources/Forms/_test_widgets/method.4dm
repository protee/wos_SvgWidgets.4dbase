
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		
	: ($vL_event_code=On Resize:K2:27)
		SET TIMER:C645(-1)
		
	: ($vL_event_code=On Timer:K2:25)
		SET TIMER:C645(0)
		
		
End case 


