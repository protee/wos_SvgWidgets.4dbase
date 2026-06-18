
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_label:=""
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=100
		$vJ_widget.l_unit:=20
		$vJ_widget.l_step:=1
		$vJ_widget.t_tip:="Opacity"
		$vJ_widget.set_widget_name()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._opacity_chge($vJ_widget; $vL_event_code)
		
	: ($vL_event_code=k_OnDataMove)
		$vJ_widget:=Self:C308->
		Form:C1466._opacity_chge($vJ_widget; $vL_event_code)
		
End case 

