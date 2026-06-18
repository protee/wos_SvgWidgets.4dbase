//%attributes = {"invisible":true,"lang":"en"}

var $vT_action : Text
$vT_action:=$1


var $is_redraw : Boolean
$is_redraw:=False:C215

var $vP__T_currentObjects : Pointer
var $tt : Integer
$tt:=svgE_EDIT_SEL_Get_count(->$vP__T_currentObjects)

// Remove selections
var $i : Integer
var $vT_currentObject : Text
For ($i; 1; $tt)
	$vT_currentObject:=$vP__T_currentObjects->{$i}
	svgE_SELECT_Clear_selection($vT_currentObject)
End for 

var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
var $vR_x; $vR_y; $vR_w; $vR_h : Real

Case of 
	: ($vT_action="H")  // Horizontal
		ARRAY REAL:C219($aR_center; $tt)
		For ($i; 1; $tt)
			//get the positions and middles
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			var $vL_center; $vL_gap; $vL_leftMost; $vL_rightMost : Integer
			var $vT_objectType : Text
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$aR_center{$i}:=$vR_tx
		End for 
		SORT ARRAY:C229($aR_center; $vP__T_currentObjects->)
		
		//determine the leftmost and rightmost
		$vL_leftMost:=$aR_center{1}
		$vL_rightMost:=$aR_center{$tt}
		//calculate the gap
		$vL_gap:=($vL_rightMost-$vL_leftMost)/($tt-1)
		$vL_center:=$vL_leftMost
		
		//move objects - from the second object until the before last
		For ($i; 2; $tt-1)
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vL_center:=$vL_center+$vL_gap
			If ($vL_center#$aR_center{$i})
				$vR_tx:=$vL_center
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
				$is_redraw:=True:C214
			End if 
		End for 
		
		
	: ($vT_action="V")  // Vertical
		ARRAY REAL:C219($aR_center; $tt)
		For ($i; 1; $tt)
			//get the positions and middles
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$aR_center{$i}:=$vR_ty
		End for 
		SORT ARRAY:C229($aR_center; $vP__T_currentObjects->)
		
		//determine the leftmost and rightmost
		var $vL_bottomMost; $vL_topMost : Integer
		$vL_topMost:=$aR_center{1}
		$vL_bottomMost:=$aR_center{$tt}
		//calculate the gap
		$vL_gap:=($vL_bottomMost-$vL_topMost)/($tt-1)
		$vL_center:=$vL_topMost
		
		//move objects - from the second object until the before last
		For ($i; 2; $tt-1)
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vL_center:=$vL_center+$vL_gap
			If ($vL_center#$aR_center{$i})
				$vR_ty:=$vL_center
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
				$is_redraw:=True:C214
			End if 
		End for 
		
	Else 
		ALERT:C41($vT_action)
		
End case 


// Put back selection
For ($i; 1; $tt)
	$vT_currentObject:=$vP__T_currentObjects->{$i}
	$is_redraw:=$is_redraw | svgE_SELECT_OBJ_by_reference($vT_currentObject)
	$is_redraw:=$is_redraw | svgE_SELECT_Display_handles($vT_currentObject)
End for 

If ($is_redraw)
	svgE_FORM_canvas_redraw
	var $is_history : Boolean
	$is_history:=True:C214
End if 
If ($is_history)
	svgE_HISTORY_Append
End if 

