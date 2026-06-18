//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_ACTION_redo
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

var $is_editable : Boolean
$is_editable:=Form:C1466.is_editing
If ($is_editable)
	svgE_HISTORY_Forward
	svgE_SELECT_widgets_update
	svgE_EDIT_ACTIONS_enabler
End if 

