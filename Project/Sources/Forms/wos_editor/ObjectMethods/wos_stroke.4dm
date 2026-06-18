
var $is_toUpdate; $is_history : Boolean
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_colour:="black"
		$vJ_widget.is_displayText:=True:C214
		$vJ_widget.l_opacity:=100
		$vJ_widget.l_width:=2
		$vJ_widget.l_marker:=0
		$vJ_widget.l_dash:=0
		$vJ_widget.l_join:=0
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataMove)
		$is_toUpdate:=svgE_OBJECT_set_stroke()
		$is_history:=False:C215
		
	: ($vL_event_code=k_OnDataChange)
		$is_toUpdate:=svgE_OBJECT_set_stroke()
		$is_history:=True:C214
		
End case 

If ($is_toUpdate)
	svgE_FORM_canvas_redraw
	If ($is_history)
		svgE_HISTORY_Append
	End if 
End if 

