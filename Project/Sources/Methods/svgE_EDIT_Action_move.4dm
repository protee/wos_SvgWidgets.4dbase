//%attributes = {"invisible":true,"lang":"en"}


#DECLARE($vT_action : Text)
var $is_redraw; $is_history : Boolean
var $tt; $tt_obj; $i; $vL_idx_obj; $vL_level : Integer
var $vP_aT_currentObjects : Pointer
var $vT_currentObject : Text

$is_redraw:=False:C215

$tt:=svgE_EDIT_SEL_Get_count(->$vP_aT_currentObjects)
ARRAY TEXT:C222($aT_item_refs; 0)
ARRAY TEXT:C222($aT_item_names; 0)
ARRAY TEXT:C222($aT_item_ids; 0)
$tt_obj:=svgE_EDIT_get_objects(->$aT_item_refs; ->$aT_item_names; ->$aT_item_ids; True:C214; $vP_aT_currentObjects)

// Remove selections
For ($i; 1; $tt)
	$vT_currentObject:=$vP_aT_currentObjects->{$i}
	svgE_SELECT_Clear_selection($vT_currentObject)
End for 


Case of 
	: ($vT_action="back")
		$vL_idx_obj:=1
		For ($i; 1; $tt)
			$vT_currentObject:=$vP_aT_currentObjects->{$i}
			$vL_level:=svgE_EDIT_OB_Get_level($vT_currentObject; ->$aT_item_ids)
			If ($vL_level>$vL_idx_obj)
				$vT_currentObject:=svgE_DOM_ELEMENT_MOVE($vT_currentObject; $vL_level; $vL_idx_obj; $tt_obj)
				$vP_aT_currentObjects->{$i}:=$vT_currentObject
				$is_redraw:=True:C214
			End if 
			$vL_idx_obj:=$vL_idx_obj+1
		End for 
		
		
	: ($vT_action="front")
		$vL_idx_obj:=$tt_obj
		For ($i; $tt; 1; -1)
			$vT_currentObject:=$vP_aT_currentObjects->{$i}
			$vL_level:=svgE_EDIT_OB_Get_level($vT_currentObject; ->$aT_item_ids)
			If ($vL_level<$vL_idx_obj)
				$vT_currentObject:=svgE_DOM_ELEMENT_MOVE($vT_currentObject; $vL_level; $vL_idx_obj; $tt_obj)
				$vP_aT_currentObjects->{$i}:=$vT_currentObject
				$is_redraw:=True:C214
			End if 
			$vL_idx_obj:=$vL_idx_obj-1
		End for 
		
		
	: ($vT_action="down")
		$vL_idx_obj:=1
		For ($i; 1; $tt)
			$vT_currentObject:=$vP_aT_currentObjects->{$i}
			$vL_level:=svgE_EDIT_OB_Get_level($vT_currentObject; ->$aT_item_ids)
			If ($vL_level>$vL_idx_obj)
				$vT_currentObject:=svgE_DOM_ELEMENT_MOVE($vT_currentObject; $vL_level; $vL_level-1; $tt_obj)
				$vP_aT_currentObjects->{$i}:=$vT_currentObject
				$is_redraw:=True:C214
			Else 
				$vL_idx_obj:=$vL_idx_obj+1
			End if 
		End for 
		
		
	: ($vT_action="up")
		$vL_idx_obj:=$tt_obj
		For ($i; $tt; 1; -1)
			$vT_currentObject:=$vP_aT_currentObjects->{$i}
			$vL_level:=svgE_EDIT_OB_Get_level($vT_currentObject; ->$aT_item_ids)
			If ($vL_level<$vL_idx_obj)
				$vT_currentObject:=svgE_DOM_ELEMENT_MOVE($vT_currentObject; $vL_level; $vL_level+1; $tt_obj)
				$vP_aT_currentObjects->{$i}:=$vT_currentObject
				$is_redraw:=True:C214
			Else 
				$vL_idx_obj:=$vL_idx_obj-1
			End if 
		End for 
		
	Else 
		wox_io_alert_popup($vT_action)
		
End case 

// Put back selection
For ($i; 1; $tt)
	$vT_currentObject:=$vP_aT_currentObjects->{$i}
	$is_redraw:=$is_redraw | svgE_SELECT_OBJ_by_reference($vT_currentObject)
	$is_redraw:=$is_redraw | svgE_SELECT_Display_handles($vT_currentObject)
End for 

If ($is_redraw)
	svgE_FORM_canvas_redraw()
	$is_history:=True:C214
End if 
If ($is_history)
	svgE_HISTORY_Append()
End if 

