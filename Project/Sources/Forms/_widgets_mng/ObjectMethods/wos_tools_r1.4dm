
var $vL_event_code : Integer
var $vJ_widget : Object
var $vP : Pointer
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_value:="SELECT"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$vP:=OBJECT Get pointer:C1124(Object named:K67:5; "ot_tool")
		$vP->:=$vJ_widget.t_value
		
End case 

