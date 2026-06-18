//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_ACTION_copy
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
$isOk:=$is_editable
If ($isOk)
	var $vJ_canvas : Object
	svgE_getStuff_vJ(->$vJ_canvas)
	var $vT_tool : Text
	$vT_tool:=$vJ_canvas.t_tool
	If ($vT_tool="SELECT")
		svgE_EDIT_Action_copy
		svgE_EDIT_shortcuts_update
	End if 
End if 

