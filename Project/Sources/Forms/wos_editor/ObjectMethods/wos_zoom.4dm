
var $vL_event_code : Integer
var $vJ_widget; $vJ_canvas : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_value:=100
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange) || ($vL_event_code=k_OnDataMove)
		$vJ_widget:=Self:C308->
		svgE_getStuff_vJ(->$vJ_canvas)
		$vJ_canvas.l_zoom:=$vJ_widget.l_value
		svgE_SELECT_zoom_update()
		
End case 

