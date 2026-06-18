//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_polyline : Object
var $vP_null : Pointer
svgE_getStuff_vJ($vP_null; ->$vJ_polyline)

var $vT_currentPolylineObject : Text
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject

var $vP_T_polylineHandles : Pointer
$vP_T_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")

var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentPolylineObject)#0)
	
	$isOk:=svgE_OBJECT_polyine_validate
	
	//the user will click again anyway to manipulate the same point
	$vP_T_polylineHandles->:=0
	
	$isOk:=True:C214
	
	//continue to edit
	SET TIMER:C645(0)
	
End if 

$0:=$isOk

