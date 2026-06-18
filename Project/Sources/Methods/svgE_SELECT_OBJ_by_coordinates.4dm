//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_clickX; $vL_clickY : Integer
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentObject; $vT_currentSelectArea : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_currentSelectArea:=$vJ_canvas.t_currentSelectArea

var $vP_canvas; $vP_T_currentObjects : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $isOk : Boolean
$isOk:=False:C215

If ($vT_currentSelectArea#"")
	var $x; $y; $vL_b; $vL_w; $vL_h; $i : Integer
	$vL_w:=Abs:C99(MouseX-$vL_clickX)
	$vL_h:=Abs:C99(MouseY-$vL_clickY)
	GET MOUSE:C468($x; $y; $vL_b)
	If (($vL_w*$vL_h)>100)
		If (MouseX>$vL_clickX)
			$x:=$vL_clickX
		Else 
			$x:=MouseX
		End if 
		If (MouseY>$vL_clickY)
			$y:=$vL_clickY
		Else 
			$y:=MouseY
		End if 
		
		$isOk:=svgE_SELECT_OBJ_none
		
		ARRAY TEXT:C222($aT_objectsInRect; 0)
		
		If (SVG Find element IDs by rect:C1109($vP_canvas->; $x; $y; $vL_w; $vL_h; $aT_objectsInRect))
			
			//remove the selection rect itself
			If (Length:C16($vT_currentSelectArea)#0)
				$i:=Find in array:C230($aT_objectsInRect; $vT_currentSelectArea)
				If ($i#-1)
					DELETE FROM ARRAY:C228($aT_objectsInRect; $i)
				End if 
			End if 
			
			var $tt : Integer
			var $vT_idx_object : Text
			$tt:=Size of array:C274($aT_objectsInRect)
			var $vT_reserved_name : Text
			$vT_reserved_name:=wos__storage_stuff.t_reserved
			For ($i; 1; $tt)
				$vT_idx_object:=$aT_objectsInRect{$i}
				If ($vT_idx_object#($vT_reserved_name+"@"))
					Case of 
						: ($vT_idx_object="@.point.@")
							$aT_objectsInRect{$i}:=Substring:C12($vT_idx_object; 1; Position:C15(".point."; $vT_idx_object)-1)
							
						: ($vT_idx_object="@.tl")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".tl"; "")
							
						: ($vT_idx_object="@.tm")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".tm"; "")
							
						: ($vT_idx_object="@.tr")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".tr"; "")
							
						: ($vT_idx_object="@.bl")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".bl"; "")
							
						: ($vT_idx_object="@.bm")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".bm"; "")
							
						: ($vT_idx_object="@.br")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".br"; "")
							
						: ($vT_idx_object="@.ml")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".ml"; "")
							
						: ($vT_idx_object="@.mr")
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".mr"; "")
							
						: ($vT_idx_object="@.select")  //already highlighted
							$aT_objectsInRect{$i}:=Replace string:C233($vT_idx_object; ".select"; "")
							
					End case 
					
					If (Find in array:C230($vP_T_currentObjects->; $aT_objectsInRect{$i})=-1)
						$vT_currentObject:=$aT_objectsInRect{$i}
						$vJ_canvas.t_currentObject:=$vT_currentObject
						APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
						$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
						$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
						svgE_EDIT_ACTIONS_enabler
						svgE_SELECT_widgets_update
					End if 
				End if 
			End for 
			
		End if 
		
	End if 
	
	DOM REMOVE XML ELEMENT:C869($vT_currentSelectArea)
	$vJ_canvas.t_currentSelectArea:=""
	$isOk:=True:C214
	
End if 

$0:=$isOk

