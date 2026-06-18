//%attributes = {"invisible":true,"lang":"en"}

#DECLARE()->$vL_OK : Integer
var $vL_event : Integer
var $isOk; $is_history; $is_editable : Boolean

$vL_event:=Form event code:C388

$isOk:=False:C215
$is_history:=False:C215

$is_editable:=x__get_editable()

Case of 
	: ($vL_event=On Getting Focus:K2:7)
		svgE_EDIT_shortcuts_update()
		
	: ($vL_event=On Losing Focus:K2:8)
		svgE_EDIT_shortcuts_update(False:C215)
		
	: ($vL_event=On Double Clicked:K2:5)
		If ($is_editable)
			$isOk:=svgE_SELECT_OBJ_for_dbleClick()
		End if 
		
	: ($vL_event=On Clicked:K2:4)
		If (Contextual click:C713)
			$isOk:=svgE_MENU_contextual_click()
		Else 
			If ($is_editable)
				$isOk:=svgE_SELECT_OBJ_for_click()
			End if 
		End if 
		
	: ($vL_event=On Mouse Move:K2:35)
		If ($is_editable)
			$isOk:=svgE_SELECT_OBJ_for_mouseMove()
		End if 
		
	: ($vL_event=On Drop:K2:12)
		If ($is_editable)
			$isOk:=svgE_SELECT_OBJ_none()
			$isOk:=$isOk || svgE_SELECT_OBJ_for_drop()
			$is_history:=$isOk
			$vL_OK:=0  //to reset the cursor
		End if 
		
	: ($vL_event=On Mouse Enter:K2:33)
		svgE_SELECT_OBJ_for_mouseEnter()
		
	: ($vL_event=On Mouse Leave:K2:34)
		svgE_SELECT_OBJ_for_mouseLeave()
		
End case 

If ($isOk)
	svgE_EDIT_widgets_enabler()  //($tool)
	svgE_EDIT_shortcuts_update()
	svgE_EDIT_ACTIONS_enabler()
	svgE_FORM_canvas_redraw
End if 
If ($is_history)
	svgE_HISTORY_Append()
End if 

