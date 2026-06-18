

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_value:="SELECT"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		var $vP : Pointer
		var $vJ_widget : Object
		$vP:=OBJECT Get pointer:C1124(Object named:K67:5; "tool_txt")
		$vP->:=$vJ_widget.t_value
		
End case 

