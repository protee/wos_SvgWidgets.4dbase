//%attributes = {"invisible":true,"lang":"en"}


#DECLARE()->$isOk : Boolean
var $vL_mouseX; $vL_mouseY : Integer
var $vJ_canvas : Object
$isOk:=False:C215
svgE_getStuff_vJ(->$vJ_canvas)

$isOk:=(MouseX#-1) | (MouseY#-1)

If ($isOk)
	$vL_mouseX:=MouseX
	$vL_mouseY:=MouseY
	$vJ_canvas.l_clickX:=$vL_mouseX
	$vJ_canvas.l_clickY:=$vL_mouseY
	$vJ_canvas.l_oldX:=$vL_mouseX
	$vJ_canvas.l_oldY:=$vL_mouseY
	$vJ_canvas.t_currentObject_old:=$vJ_canvas.t_currentObject
	$vJ_canvas.pasteOffsetX:=0
	$vJ_canvas.pasteOffsetY:=0
Else 
	svgE_MOUSE_Force_update
End if 

