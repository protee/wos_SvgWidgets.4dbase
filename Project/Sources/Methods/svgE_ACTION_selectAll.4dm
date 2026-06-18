//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_ACTION_selectAll
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

var $is_editable; $isOk : Boolean
var $vJ_canvas : Object
var $vT_tool : Text
$is_editable:=Form:C1466.is_editing
If ($is_editable)
	svgE_getStuff_vJ(->$vJ_canvas)
	$isOk:=svgE_SELECT_Object_all
	$vT_tool:="SELECT"
	x_maj_wos_tools($vT_tool; $vJ_canvas)
	svgE_SELECT_widgets_update
	svgE_EDIT_widgets_enabler($vT_tool)
	svgE_EDIT_ACTIONS_enabler
	If ($isOk)
		svgE_FORM_canvas_redraw
		svgE_HISTORY_Append
	End if 
End if 

