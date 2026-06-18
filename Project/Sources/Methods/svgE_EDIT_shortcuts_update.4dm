//%attributes = {"invisible":true,"lang":"en"}


#DECLARE($is_update : Boolean)  // {#1} optionals
var $is_historyIndex; $is_selected; $is_edit; $is_undo; $is_redo; $is_cut; $is_copy; $is_paste; $is_clear : Boolean
var $vL_historyIndex; $tt_history; $tt_selected : Integer
var $vJ_canvas; $vJ_history; $vJ_wos_edits; $vJ_wos_enablers : Object
var $vP_canvas; $vP_FocusObject; $vP_null; $vP_T_historyList; $vP_T_currentObjects : Pointer
var $vT_currentObject; $vT_editTextObject; $vT_wos_edits : Text
If (Count parameters:C259<1)
	$is_update:=True:C214
End if 

If ($is_update)
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
	$vP_FocusObject:=OBJECT Get pointer:C1124(Object with focus:K67:3)
	//If ($vP_FocusObject=$vP_canvas)
	
	svgE_getStuff_vJ(->$vJ_canvas; $vP_null; ->$vJ_history)
	$vL_historyIndex:=$vJ_history.l_index
	$vT_currentObject:=$vJ_canvas.t_currentObject
	$vT_editTextObject:=$vJ_canvas.t_editTextObject
	
	$vP_T_historyList:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_historyList")
	$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
	$tt_history:=Size of array:C274($vP_T_historyList->)
	$tt_selected:=Size of array:C274($vP_T_currentObjects->)
	
	$is_historyIndex:=($vL_historyIndex#0)
	$is_selected:=($tt_selected#0)
	$is_edit:=($vT_editTextObject#"") & ($vT_editTextObject=$vT_currentObject)
	
	
	// UNDO & REDO
	$is_undo:=($vL_historyIndex>1)
	$is_redo:=($is_historyIndex) & ($vL_historyIndex<$tt_history)
	
	// COPY & CUT
	$is_cut:=$is_historyIndex & $is_selected
	$is_copy:=$is_cut
	
	// PASTE
	$is_paste:=$is_historyIndex
	If ($is_paste)
		ARRAY TEXT:C222($aT_signatures; 0)
		ARRAY TEXT:C222($aT_types; 0)
		ARRAY TEXT:C222($aT_formats; 0)
		GET PASTEBOARD DATA TYPE:C958($aT_signatures; $aT_types; $aT_formats)
		$is_paste:=True:C214
		Case of 
			: (Find in array:C230($aT_types; "private.4d.svg.data")#-1)
			: (Find in array:C230($aT_formats; "private.4d.svg.data")#-1)
			: (Find in array:C230($aT_signatures; "com.4d.private.text.@")#-1)
			: (Find in array:C230($aT_signatures; "com.4d.private.picture.@")#-1)
			Else 
				$is_paste:=False:C215
		End case 
	End if 
	
	// DELETE
	$is_clear:=$is_historyIndex & $is_selected & Not:C34($is_edit)
	
	
Else 
	$is_undo:=False:C215
	$is_redo:=False:C215
	$is_cut:=False:C215
	$is_copy:=False:C215
	$is_paste:=False:C215
	$is_clear:=False:C215
	
	$is_historyIndex:=False:C215
	
End if 

$vT_wos_edits:="wos_edits"
$vJ_wos_edits:=wos_getWidget($vT_wos_edits)
$vJ_wos_enablers:=$vJ_wos_edits.j_enablers
$vJ_wos_enablers.is_undo:=$is_undo
$vJ_wos_enablers.is_redo:=$is_redo
$vJ_wos_enablers.is_cut:=$is_cut
$vJ_wos_enablers.is_copy:=$is_copy
$vJ_wos_enablers.is_paste:=$is_paste
$vJ_wos_enablers.is_clear:=$is_clear
$vJ_wos_edits.redraw()

// For shortcuts ## Those in the "wos_svgEdits" do not work ##
// So put button back too only for shortcuts.
OBJECT SET ENABLED:C1123(*; "undo_btn"; $is_undo)
OBJECT SET ENABLED:C1123(*; "redo_btn"; $is_redo)
OBJECT SET ENABLED:C1123(*; "cut_btn"; $is_cut)
OBJECT SET ENABLED:C1123(*; "copy_btn"; $is_copy)
OBJECT SET ENABLED:C1123(*; "paste_btn"; $is_paste)
OBJECT SET ENABLED:C1123(*; "delete_btn"; $is_clear)
OBJECT SET ENABLED:C1123(*; "back_btn"; $is_clear)


// BASED ON $is_historyIndex
OBJECT SET ENABLED:C1123(*; "selectAll_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveUp_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveUpStep_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveDown_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveDownStep_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveLeft_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveLeftStep_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveRight_btn"; $is_historyIndex)
OBJECT SET ENABLED:C1123(*; "moveRightStep_btn"; $is_historyIndex)

//End if

