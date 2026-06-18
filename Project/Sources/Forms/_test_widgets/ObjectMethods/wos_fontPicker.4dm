

var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_face:="Alba"
		$vJ_widget.l_style:=2
		$vJ_widget.l_align:=1
		$vJ_widget.is_editing:=False:C215
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=On Data Change:K2:15)
		$vJ_widget:=Self:C308->
		BEEP:C151
		
End case 

