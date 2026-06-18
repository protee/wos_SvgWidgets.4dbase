//%attributes = {"invisible":true,"lang":"en"}

var $vT_action : Text
$vT_action:=$1


var $is_redraw : Boolean
$is_redraw:=False:C215

var $vP__T_currentObjects : Pointer
var $tt : Integer
$tt:=svgE_EDIT_SEL_Get_count(->$vP__T_currentObjects)

// Remove selections
For ($i; 1; $tt)
	var $vT_currentObject : Text
	$vT_currentObject:=$vP__T_currentObjects->{$i}
	svgE_SELECT_Clear_selection($vT_currentObject)
End for 

//C_REAL($left;$leftMost;$right;$rightMost)
var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
var $vR_x; $vR_y; $vR_w; $vR_h : Real

var $i : Integer

Case of 
	: ($vT_action="right")  // Right
		//get the rightmost
		var $vL_txr; $vL_txr_most : Integer
		$vL_txr_most:=0
		For ($i; 1; $tt)
			//get current
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			var $vT_objectType : Text
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vL_txr:=$vR_tx+($vR_w/2)
			$is_redraw:=($i#1) & ($vL_txr#$vL_txr_most)
			If ($i=1) | ($vL_txr>$vL_txr_most)
				$vL_txr_most:=$vL_txr
			End if 
		End for 
		//align
		If ($is_redraw)
			For ($i; 1; $tt)
				$vT_currentObject:=$vP__T_currentObjects->{$i}
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				$vL_txr:=$vR_tx+($vR_w/2)
				var $vL_moveOffset_x; $vL_txc_most : Integer
				$vL_moveOffset_x:=$vL_txr_most-$vL_txr
				$vR_tx:=$vR_tx+$vL_moveOffset_x
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			End for 
		End if 
		
	: ($vT_action="centerH")  // Center Horizontal
		//get the center
		$vL_txc_most:=0
		For ($i; 1; $tt)
			//get current
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			var $vL_txc : Integer
			$vL_txc:=$vR_tx  // center
			$is_redraw:=($i#1) & ($vL_txc#$vL_txc_most)
			If ($i=1)
				$vL_txc_most:=$vL_txc
			Else 
				If ($vL_txc#$vL_txc_most)
					$vL_txc_most:=$vL_txc_most+$vL_txc/2
				End if 
			End if 
		End for 
		//align
		If ($is_redraw)
			For ($i; 1; $tt)
				$vT_currentObject:=$vP__T_currentObjects->{$i}
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				$vL_txc:=$vR_tx  // center
				$vL_moveOffset_x:=$vL_txc_most-$vL_txc
				$vR_tx:=$vR_tx+$vL_moveOffset_x
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			End for 
		End if 
		
		
	: ($vT_action="left")  // Left
		//get the leftmost
		var $vL_txl; $vL_txl_most : Integer
		$vL_txl_most:=0
		For ($i; 1; $tt)
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			//get current
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vL_txl:=$vR_tx-($vR_w/2)
			$is_redraw:=($i#1) & ($vL_txl#$vL_txl_most)
			If ($i=1) | ($vL_txl<$vL_txl_most)
				$vL_txl_most:=$vL_txl
			End if 
		End for 
		//align
		If ($is_redraw)
			For ($i; 1; $tt)
				$vT_currentObject:=$vP__T_currentObjects->{$i}
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				$vL_txl:=$vR_tx-($vR_w/2)
				$vL_moveOffset_x:=$vL_txl_most-$vL_txl
				$vR_tx:=$vR_tx+$vL_moveOffset_x
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			End for 
		End if 
		
		
	: ($vT_action="top")  // Top
		//get the leftmost
		var $vL_tyt; $vL_tyt_most : Integer
		$vL_tyt_most:=0
		For ($i; 1; $tt)
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			//get current
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vL_tyt:=$vR_ty-($vR_h/2)
			$is_redraw:=($i#1) & ($vL_tyt#$vL_tyt_most)
			If ($i=1) | ($vL_tyt<$vL_tyt_most)
				$vL_tyt_most:=$vL_tyt
			End if 
		End for 
		//align
		If ($is_redraw)
			For ($i; 1; $tt)
				$vT_currentObject:=$vP__T_currentObjects->{$i}
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				$vL_tyt:=$vR_ty-($vR_h/2)
				var $vL_moveOffset_y; $vL_tyc_most : Integer
				$vL_moveOffset_y:=$vL_tyt_most-$vL_tyt
				$vR_ty:=$vR_ty+$vL_moveOffset_y
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			End for 
		End if 
		
	: ($vT_action="centerV")  // Center Vertical
		//get the center
		$vL_tyc_most:=0
		For ($i; 1; $tt)
			//get current
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			var $vL_tyc : Integer
			$vL_tyc:=$vR_ty  // center
			$is_redraw:=($i#1) & ($vL_tyc#$vL_tyc_most)
			If ($i=1)
				$vL_tyc_most:=$vL_tyc
			Else 
				If ($vL_tyc#$vL_tyc_most)
					$vL_tyc_most:=$vL_tyc_most+$vL_tyc/2
				End if 
			End if 
		End for 
		//align
		If ($is_redraw)
			For ($i; 1; $tt)
				$vT_currentObject:=$vP__T_currentObjects->{$i}
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				$vL_tyc:=$vR_ty  // center
				$vL_moveOffset_y:=$vL_tyc_most-$vL_tyc
				$vR_ty:=$vR_ty+$vL_moveOffset_y
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			End for 
		End if 
		
	: ($vT_action="bottom")  // Bottom
		//get the bottommost
		var $vL_tyb; $vL_tyb_most : Integer
		$vL_tyb_most:=0
		For ($i; 1; $tt)
			//get current
			$vT_currentObject:=$vP__T_currentObjects->{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vL_tyb:=$vR_ty+($vR_h/2)
			$is_redraw:=($i#1) & ($vL_tyb#$vL_tyb_most)
			If ($i=1) | ($vL_tyb>$vL_tyb_most)
				$vL_tyb_most:=$vL_tyb
			End if 
		End for 
		//align
		If ($is_redraw)
			For ($i; 1; $tt)
				$vT_currentObject:=$vP__T_currentObjects->{$i}
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				$vL_tyb:=$vR_ty+($vR_h/2)
				$vL_moveOffset_y:=$vL_tyb_most-$vL_tyb
				$vR_ty:=$vR_ty+$vL_moveOffset_y
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			End for 
		End if 
		
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

