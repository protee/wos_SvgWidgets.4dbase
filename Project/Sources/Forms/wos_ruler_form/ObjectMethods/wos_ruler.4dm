
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		wox_vJ_overload(Form:C1466; $vJ_widget; "l_value"; "is_editing"; "t_label"; "l_min"; "l_max"; "l_unit"; "l_step")
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=-On Double Clicked:K2:5)
		$vJ_widget:=Self:C308->
		Form:C1466.l_value:=$vJ_widget.l_value
		ACCEPT:C269
		
		//: ($evt=-On Data Change)
		//C_OBJECT($ob_widget)
		//$ob_widget:=Self->
		//wos_setProperties ($ob_widget;Form;"ruler")
		//ACCEPT
		
End case 

