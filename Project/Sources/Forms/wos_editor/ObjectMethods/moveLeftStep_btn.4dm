

var $isOk; $is_editable : Boolean
$is_editable:=Form:C1466.is_editing
If ($is_editable)
	var $vJ_canvas : Object
	svgE_getStuff_vJ(->$vJ_canvas)
	var $vL_moveOffset : Integer
	$vL_moveOffset:=$vJ_canvas.moveOffset
	$isOk:=svgE_OBJECT_Move(-$vL_moveOffset; 0)
	If ($isOk)
		svgE_FORM_canvas_redraw
		svgE_HISTORY_Append
	End if 
End if 




