//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_ACTION_paste
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 02/03/2021   OG   Initial version.

var $isOk; $is_editable : Boolean
$is_editable:=Form:C1466.is_editing
If ($is_editable)
	var $vJ_canvas : Object
	svgE_getStuff_vJ(->$vJ_canvas)
	var $vT_tool : Text
	$vT_tool:=$vJ_canvas.t_tool
	If ($vT_tool="SELECT")
		$isOk:=svgE_SELECT_OBJ_none
		$isOk:=$isOk | svgE_EDIT_Action_paste
	End if 
	If ($isOk)
		svgE_SELECT_widgets_update
		svgE_FORM_canvas_redraw
		svgE_HISTORY_Append
		SET CURSOR:C469(0)
	End if 
End if 

