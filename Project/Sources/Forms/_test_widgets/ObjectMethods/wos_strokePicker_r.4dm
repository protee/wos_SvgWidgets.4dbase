

var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_colour:="lightcoral"
		$vJ_widget.is_displayText:=True:C214
		$vJ_widget.l_opacity:=80
		$vJ_widget.l_width:=2
		$vJ_widget.l_marker:=2
		$vJ_widget.l_dash:=2
		$vJ_widget.l_join:=1
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		BEEP:C151
		
End case 

