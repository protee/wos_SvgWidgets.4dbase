//%attributes = {"invisible":true,"lang":"en"}
// Project Method: _svgEditor_actions
//
// Parameter Type Description
// $1 <T> -> action
//
// Description:
// actionsPicker menus manager
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.


#DECLARE($vT_action : Text)->$isOk : Boolean

// AFTER MENU ACTIONS

$isOk:=True:C214
Case of 
	: ($vT_action="clear")
		svgE_ACTION_delete()
		
	: ($vT_action="clearAll")
		wox_io_confirm_popup("Clear all, this can't be undone?")
		$isOk:=(OK=1)
		If ($isOk)
			svgE_AREA_Init()
			svgE_OBJECT_reserved_update()
			svgE_FORM_canvas_redraw()
			svgE_HISTORY_Append()
		End if 
		
	: ($vT_action="file-@")
		svgE_EDIT_Action_files(Substring:C12($vT_action; 6))
		
	: ($vT_action="align-@")
		svgE_EDIT_Action_align(Substring:C12($vT_action; 7))
		
	: ($vT_action="distribute-@")
		svgE_EDIT_Action_distribute(Substring:C12($vT_action; 12))
		
	: ($vT_action="level-@")
		svgE_EDIT_Action_move(Substring:C12($vT_action; 7))
		
	: ($vT_action="group-@")
		svgE_EDIT_Action_group(Substring:C12($vT_action; 7))
		
	Else 
		wox_io_alert_popup("Error not implemented "+$vT_action)
		$isOk:=False:C215
		
End case 

