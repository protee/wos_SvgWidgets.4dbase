//%attributes = {"invisible":true,"lang":"en"}

var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

var $vJ_canvas; $vJ_polyline; $vJ_history : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline; ->$vJ_history)
var $vT_currentPolylineObject : Text
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject
var $vL_historyIndex : Integer
$vL_historyIndex:=$vJ_history.l_index


var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")


var $vP_aO_historyData; $vP_aO_historySelection : Pointer
$vP_aO_historyData:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyData")  // Array pictures
$vP_aO_historySelection:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historySelection")

var $vP_aO_historyPolylineHandle; $vP_aO_historyPolylinePointX; $vP_aO_historyPolylinePointY; $vP_aT_historyPolyline : Pointer
$vP_aO_historyPolylineHandle:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylineHandle")
$vP_aO_historyPolylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylinePointX")
$vP_aO_historyPolylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylinePointY")
$vP_aT_historyPolyline:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolyline")


var $vP_T_polylineHandles; $vP_T_polylinePointX; $vP_T_polylinePointY : Pointer
$vP_T_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")
$vP_T_polylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointX")
$vP_T_polylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointY")

//$ptr_historyIndex:=OBJECT Get pointer(Object named;"HistoryIndex")

//If ($historyIndex#0)
//resize the history arrays
var $tt : Integer
$tt:=$vL_historyIndex
ARRAY PICTURE:C279($vP_aO_historyData->; $tt)
ARRAY PICTURE:C279($vP_aO_historySelection->; $tt)
ARRAY PICTURE:C279($vP_aO_historyPolylineHandle->; $tt)
ARRAY PICTURE:C279($vP_aO_historyPolylinePointX->; $tt)
ARRAY PICTURE:C279($vP_aO_historyPolylinePointY->; $tt)
ARRAY TEXT:C222($vP_aT_historyPolyline->; $tt)

APPEND TO ARRAY:C911($vP_aO_historyData->; $vP_canvas->)
var $vX_currentSelection : Blob
var $vO_currentSelectionData : Picture
VARIABLE TO BLOB:C532($vP_T_currentObjects->; $vX_currentSelection)
BLOB TO PICTURE:C682($vX_currentSelection; $vO_currentSelectionData; "private.4d.array.blob")
APPEND TO ARRAY:C911($vP_aO_historySelection->; $vO_currentSelectionData)

var $vX_CanvasPolylineHandle; $vX_CanvasPolylinePointXX; $vX_CanvasPolylinePointYY : Blob
var $vO_CanvasPolylineHandleData; $vO_CanvasPolylinePointXData; $vO_CanvasPolylinePointYData : Picture
VARIABLE TO BLOB:C532($vP_T_polylineHandles->; $vX_CanvasPolylineHandle)
BLOB TO PICTURE:C682($vX_CanvasPolylineHandle; $vO_CanvasPolylineHandleData; "private.4d.array.blob")
VARIABLE TO BLOB:C532($vP_T_polylinePointX->; $vX_CanvasPolylinePointXX)
BLOB TO PICTURE:C682($vX_CanvasPolylinePointXX; $vO_CanvasPolylinePointXData; "private.4d.array.blob")
VARIABLE TO BLOB:C532($vP_T_polylinePointY->; $vX_CanvasPolylinePointYY)
BLOB TO PICTURE:C682($vX_CanvasPolylinePointYY; $vO_CanvasPolylinePointYData; "private.4d.array.blob")
APPEND TO ARRAY:C911($vP_aO_historyPolylineHandle->; $vO_CanvasPolylineHandleData)
APPEND TO ARRAY:C911($vP_aO_historyPolylinePointX->; $vO_CanvasPolylinePointXData)
APPEND TO ARRAY:C911($vP_aO_historyPolylinePointY->; $vO_CanvasPolylinePointYData)

APPEND TO ARRAY:C911($vP_aT_historyPolyline->; $vT_currentPolylineObject)

$vL_historyIndex:=$vL_historyIndex+1
$vJ_history.l_index:=$vL_historyIndex
Form:C1466.is_modified:=($vL_historyIndex>1)

svgE_EDIT_shortcuts_update

//HISTORY_Update_list
//End if

