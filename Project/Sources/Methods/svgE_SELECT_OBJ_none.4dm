//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)

var $vP_aT_currentObjects; $vP_aT_polylineHandles : Pointer
$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$vP_aT_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")

var $isOk : Boolean
$isOk:=False:C215

//clear selection and handles

var $i; $vL_tt : Integer
$vL_tt:=Size of array:C274($vP_aT_currentObjects->)
For ($i; 1; $vL_tt)
	var $vT_currentObject : Text
	$vT_currentObject:=$vP_aT_currentObjects->{$i}
	$vJ_canvas.t_currentObject:=$vT_currentObject
	$isOk:=$isOk | svgE_SELECT_Clear_selection($vT_currentObject)
End for 

ARRAY TEXT:C222($vP_aT_currentObjects->; 0)

//clear polyline handles
For ($i; 1; Size of array:C274($vP_aT_polylineHandles->))
	DOM REMOVE XML ELEMENT:C869($vP_aT_polylineHandles->{$i})
	$isOk:=True:C214
End for 

ARRAY TEXT:C222($vP_aT_polylineHandles->; 0)
svgE_SELECT_Clear


$0:=$isOk

