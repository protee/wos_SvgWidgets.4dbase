

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

var $is_toUpdate; $is_history : Boolean
var $vJ_widget : Object
$is_toUpdate:=False:C215

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataMove)
		$is_toUpdate:=svgE_OBJECT_set_rotation
		$is_history:=False:C215
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$is_toUpdate:=svgE_OBJECT_set_rotation
		$is_history:=True:C214
End case 

If ($is_toUpdate)
	svgE_FORM_canvas_redraw
	If ($is_history)
		svgE_HISTORY_Append
	End if 
End if 

