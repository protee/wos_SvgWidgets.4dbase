
var $isOk; $is_editable : Boolean
$is_editable:=Form:C1466.is_editing
If ($is_editable)
	$isOk:=svgE_OBJECT_Move(-1; 0)
	If ($isOk)
		svgE_FORM_canvas_redraw
		svgE_HISTORY_Append
	End if 
End if 




