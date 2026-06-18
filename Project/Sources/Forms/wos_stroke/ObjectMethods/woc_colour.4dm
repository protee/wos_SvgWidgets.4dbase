
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.set_widget_name()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.t_colour:=$vJ_widget.t_colour
		Form:C1466._send_onDataChange()
		
End case 

