//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)
var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentObject; $vT_currentSelectArea : Text
$vT_currentSelectArea:=$vJ_canvas.t_currentSelectArea
$vT_currentObject:=$vJ_canvas.t_currentObject

var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool


var $vP_canvas; $vP_focusObject; $vP_T_currentObjects : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$vP_focusObject:=OBJECT Get pointer:C1124(Object with focus:K67:3)


var $vR_scale : Real
$vR_scale:=$vL_zoom/100

ARRAY TEXT:C222($aT_currentObjects_temp; 0)
var $isOk : Boolean
var $x; $y : Integer
$isOk:=False:C215
If ($vP_focusObject=$vP_canvas)
	var $vL_w; $vL_h : Integer
	PICTURE PROPERTIES:C457($vP_canvas->; $vL_w; $vL_h)
	$x:=0
	$y:=0
	$vJ_canvas.pasteOffsetX:=0
	$vJ_canvas.pasteOffsetY:=0
	
	COPY ARRAY:C226($vP_T_currentObjects->; $aT_currentObjects_temp)
	
	$isOk:=svgE_SELECT_OBJ_none
	ARRAY TEXT:C222($aT_objectsInRect; 0)
	
	var $i : Integer
	
	If (SVG Find element IDs by rect:C1109($vP_canvas->; $x; $y; $vL_w; $vL_h; $aT_objectsInRect))
		//remove the selection rect itself
		If (Length:C16($vT_currentSelectArea)#0)
			$i:=Find in array:C230($aT_objectsInRect; $vT_currentSelectArea)
			If ($i#-1)
				DELETE FROM ARRAY:C228($aT_objectsInRect; $i)
			End if 
		End if 
		
		var $tt : Integer
		var $vT_objectInRect : Text
		$tt:=Size of array:C274($aT_objectsInRect)
		var $vT_reserved_name : Text
		$vT_reserved_name:=wos__storage_stuff.t_reserved
		For ($i; 1; $tt)
			$vT_objectInRect:=$aT_objectsInRect{$i}
			If ($vT_objectInRect#($vT_reserved_name+"@"))
				
				Case of 
					: ($vT_objectInRect="@.point.@")
						$aT_objectsInRect{$i}:=Substring:C12($vT_objectInRect; 1; Position:C15(".point."; $vT_objectInRect)-1)
						
					: ($vT_objectInRect="@.tl")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".tl"; "")
						
					: ($vT_objectInRect="@.tm")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".tm"; "")
						
					: ($vT_objectInRect="@.tr")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".tr"; "")
						
					: ($vT_objectInRect="@.bl")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".bl"; "")
						
					: ($vT_objectInRect="@.bm")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".bm"; "")
						
					: ($vT_objectInRect="@.br")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".br"; "")
						
					: ($vT_objectInRect="@.ml")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".ml"; "")
						
					: ($vT_objectInRect="@.mr")
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".mr"; "")
						
					: ($vT_objectInRect="@.select")  //already highlighted
						$aT_objectsInRect{$i}:=Replace string:C233($vT_objectInRect; ".select"; "")
						
				End case 
				
				$vT_objectInRect:=$aT_objectsInRect{$i}
				If (Find in array:C230($vP_T_currentObjects->; $vT_objectInRect)=-1)
					$vT_currentObject:=$vT_objectInRect
					APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
					$vJ_canvas.t_currentObject:=$vT_currentObject
					$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
					$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
				End if 
			End if 
		End for 
	End if 
End if 

If (Length:C16($vT_currentSelectArea)#0)
	DOM REMOVE XML ELEMENT:C869($vT_currentSelectArea)
	$vT_currentSelectArea:=""
	$vJ_canvas.t_currentSelectArea:=$vT_currentSelectArea
	$isOk:=True:C214
	
Else 
	$isOk:=False:C215
	var $vL_size_1; $vL_size_2 : Integer
	$vL_size_1:=Size of array:C274($vP_T_currentObjects->)
	$vL_size_2:=Size of array:C274($aT_currentObjects_temp)
	
	If ($vL_size_1=$vL_size_2)
		SORT ARRAY:C229($vP_T_currentObjects->)
		SORT ARRAY:C229($aT_currentObjects_temp)
		$isOk:=False:C215
		For ($i; 1; $vL_size_1)
			If ($vP_T_currentObjects->{$i}#$aT_currentObjects_temp{$i})
				$isOk:=True:C214
				$i:=$vL_size_1
			End if 
		End for 
	Else 
		$isOk:=True:C214
	End if 
End if 
$0:=$isOk

