
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_border:=Border Dotted:K42:29
		$vJ_widget.is_displayText:=True:C214
		$vJ_widget.t_colour:="none"
		$vJ_widget.l_opacity:=40
		$vJ_widget.t_label:=""
		$vJ_widget.is_editing:=False:C215
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		// From inside
		$vJ_widget:=Self:C308->
		// or: $ob:=gsw_getWidget
		
		// From outside
		// $colour:=gsw_getWidget("gsw_svg_colourWidget")
		
		// then do what you want with it!
		var $vT_colour : Text
		var $vL_opacity : Integer
		var $is_displayText : Boolean
		var $vT_label : Text
		var $vJ_widget : Object
		$vT_colour:=$vJ_widget.t_colour
		$vL_opacity:=$vJ_widget.l_opacity
		$is_displayText:=$vJ_widget.is_displayText
		$vT_label:=$vJ_widget.t_label
		
		BEEP:C151
		
End case 

