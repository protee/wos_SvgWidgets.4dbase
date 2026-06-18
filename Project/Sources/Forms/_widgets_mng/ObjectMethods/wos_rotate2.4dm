
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_border:=Border Dotted:K42:29
		$vJ_widget.t_label:=""
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=360
		$vJ_widget.l_unit:=90
		$vJ_widget.l_step:=1
		$vJ_widget.l_value:=75
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		
		
End case 


