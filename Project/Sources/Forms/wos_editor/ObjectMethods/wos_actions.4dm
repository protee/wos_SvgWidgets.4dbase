
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.resize()
		$vJ_widget.l_count:=0
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		w_svgEditor_actions($vJ_widget.t_value)
		
End case 

