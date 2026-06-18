//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vT_value : Text; $vJ_canvas : Object)
var $vJ_widget : Object

$vJ_canvas.t_tool:=$vT_value
$vJ_widget:=wos_getWidget("wos_tools")
$vJ_widget.t_value:=$vT_value
$vJ_widget.redraw()

