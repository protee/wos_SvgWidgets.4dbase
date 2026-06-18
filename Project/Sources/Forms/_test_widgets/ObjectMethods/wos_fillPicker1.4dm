

var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.is_displayText:=True:C214
		$vJ_widget.t_colour:="none"
		$vJ_widget.l_opacity:=40
		$vJ_widget.t_label:="My label as I want..."
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=On Data Change:K2:15)
		$vJ_widget:=Self:C308->
		$vJ_widget:=OBJECT Get pointer:C1124(Object current:K67:2)->
		$vJ_widget:=wos_getWidget()
		BEEP:C151
		
End case 

