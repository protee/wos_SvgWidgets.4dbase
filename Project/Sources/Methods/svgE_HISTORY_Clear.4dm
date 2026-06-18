//%attributes = {"invisible":true,"lang":"en"}

var $vJ_history : Object
var $vP_null : Pointer
svgE_getStuff_vJ($vP_null; $vP_null; ->$vJ_history)

var $vP_aB_historyList : Pointer
$vP_aB_historyList:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_historyList")

var $vP_aO_historyData; $vP_aO_historyPolyline; $vP_aO_historyPolylineHandle; $vP_aO_historyPolylinePointX; $vP_aO_historyPolylinePointY; $vP_aO_historySelection : Pointer
$vP_aO_historyData:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyData")
$vP_aO_historySelection:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historySelection")
$vP_aO_historyPolylineHandle:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylineHandle")
$vP_aO_historyPolylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylinePointX")
$vP_aO_historyPolylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylinePointY")
$vP_aO_historyPolyline:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolyline")

$vJ_history.l_index:=0
Form:C1466.is_modified:=False:C215

ARRAY BOOLEAN:C223($vP_aB_historyList->; 0)

ARRAY PICTURE:C279($vP_aO_historyData->; 0)
ARRAY PICTURE:C279($vP_aO_historySelection->; 0)
ARRAY PICTURE:C279($vP_aO_historyPolylineHandle->; 0)
ARRAY PICTURE:C279($vP_aO_historyPolylinePointX->; 0)
ARRAY PICTURE:C279($vP_aO_historyPolylinePointY->; 0)
ARRAY TEXT:C222($vP_aO_historyPolyline->; 0)

