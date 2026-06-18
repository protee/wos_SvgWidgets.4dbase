//%attributes = {"invisible":true,"lang":"en"}


var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas; $vJ_polyline; $vJ_history : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline; ->$vJ_history)
var $vT_currentPolylineObject : Text
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject
var $vL_historyIndex : Integer
$vL_historyIndex:=$vJ_history.l_index


var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

var $vP_T_currentObjects; $vP_T_historyData; $vP_T_historySelection : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$vP_T_historyData:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyData")
$vP_T_historySelection:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historySelection")

var $vP_T_historyPolyline; $vP_T_historyPolylineHandle; $vP_T_historyPolylinePointX; $vP_T_historyPolylinePointY : Pointer
$vP_T_historyPolylineHandle:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylineHandle")
$vP_T_historyPolylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylinePointX")
$vP_T_historyPolylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolylinePointY")
$vP_T_historyPolyline:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historyPolyline")

var $vP_T_polylineHandles; $vP_T_polylinePointX; $vP_T_polylinePointY : Pointer
$vP_T_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")
$vP_T_polylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointX")
$vP_T_polylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointY")

//$Width:=OBJECT Get pointer(Object named;"Width")
//$Height:=OBJECT Get pointer(Object named;"Height")



//remove polyline handles

var $i : Integer

For ($i; 1; Size of array:C274($vP_T_polylineHandles->))
	DOM REMOVE XML ELEMENT:C869($vP_T_polylineHandles->{$i})
End for 
ARRAY TEXT:C222($vP_T_polylineHandles->; 0)

var $vX_pictureData : Blob
var $vX_currentSelection : Blob

//restore picture
PICTURE TO BLOB:C692($vP_T_historyData->{$vL_historyIndex}; $vX_pictureData; ".svg")
w_AREA_On_Unload()

$vT_domRef:=DOM Parse XML variable:C720($vX_pictureData)
Form:C1466.t_domRef:=$vT_domRef
SVG EXPORT TO PICTURE:C1017($vT_domRef; $vP_canvas->)

//restore selection

PICTURE TO BLOB:C692($vP_T_historySelection->{$vL_historyIndex}; $vX_currentSelection; "private.4d.array.blob")
BLOB TO VARIABLE:C533($vX_currentSelection; $vP_T_currentObjects->)

//restore polyline points
$vT_currentPolylineObject:=$vP_T_historyPolyline->{$vL_historyIndex}
$vJ_polyline.t_currentObject:=$vT_currentPolylineObject
var $vX_CanvasPolylineHandle : Blob
PICTURE TO BLOB:C692($vP_T_historyPolylineHandle->{$vL_historyIndex}; $vX_CanvasPolylineHandle; "private.4d.array.blob")
BLOB TO VARIABLE:C533($vX_CanvasPolylineHandle; $vP_T_polylineHandles->)

var $vX_CanvasPolylinePointXX : Blob
PICTURE TO BLOB:C692($vP_T_historyPolylinePointX->{$vL_historyIndex}; $vX_CanvasPolylinePointXX; "private.4d.array.blob")
BLOB TO VARIABLE:C533($vX_CanvasPolylinePointXX; $vP_T_polylinePointX->)

var $vX_CanvasPolylinePointYY : Blob
PICTURE TO BLOB:C692($vP_T_historyPolylinePointY->{$vL_historyIndex}; $vX_CanvasPolylinePointYY; "private.4d.array.blob")
BLOB TO VARIABLE:C533($vX_CanvasPolylinePointYY; $vP_T_polylinePointY->)

var $vL_w; $vL_h; $vL_f : Integer
PICTURE PROPERTIES:C457($vP_canvas->; $vL_w; $vL_h)
ARRAY TEXT:C222($aT_objectsInRect; 0)

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

//set new ids for all objects in rect
If (SVG Find element IDs by rect:C1109($vP_canvas->; 0; 0; $vL_w; $vL_h; $aT_objectsInRect))
	var $vT_pointNewId; $vT_polylineNewId; $vT_polylineOldId : Text
	$vT_polylineOldId:=$vT_currentPolylineObject
	$vT_polylineNewId:=DOM Find XML element by ID:C1010($vT_domRef; $vT_polylineOldId)
	For ($i; 1; Size of array:C274($vP_T_polylineHandles->))
		$vT_pointNewId:=DOM Find XML element by ID:C1010($vT_domRef; $vT_polylineOldId+".point."+String:C10($i))
		If ($vT_pointNewId#$vT_xml_null)
			$vP_T_polylineHandles->{$i}:=$vT_pointNewId
			DOM SET XML ATTRIBUTE:C866($vT_pointNewId; "id"; $vT_polylineNewId+".point."+String:C10($i))
		End if 
	End for 
	$vT_currentPolylineObject:=$vT_polylineNewId
	$vJ_polyline.t_currentObject:=$vT_currentPolylineObject
	For ($i; 1; Size of array:C274($aT_objectsInRect))
		var $vT_objectNewId; $vT_objectNewRef; $vT_objectOldId; $vT_objectType : Text
		$vT_objectOldId:=$aT_objectsInRect{$i}
		$vT_objectNewRef:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId)
		If ($vT_objectNewRef#$vT_xml_null)
			If (Length:C16($vT_objectOldId)=32)
				$vT_objectNewId:=$vT_objectNewRef
			Else 
				$vT_objectNewId:=$vT_objectOldId
			End if 
			$vT_objectType:=""
			DOM GET XML ELEMENT NAME:C730($vT_objectNewRef; $vT_objectType)
			If ($vT_objectType="line") | ($vT_objectType="polyline")
				var $vT_markerEnd; $vT_markerEndId; $vT_markerStart; $vT_markerStartId : Text
				$vT_markerStart:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".marker.start")
				$vT_markerEnd:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".marker.end")
				If ($vT_markerStart#$vT_xml_null)
					$vT_markerStartId:=$vT_objectNewId+".marker.start"
					DOM SET XML ATTRIBUTE:C866($vT_markerStart; "id"; $vT_markerStartId)
					DOM SET XML ATTRIBUTE:C866($vT_objectNewRef; "marker-start"; "url(#"+$vT_markerStartId+")")
				End if 
				If ($vT_markerEnd#$vT_xml_null)
					$vT_markerEndId:=$vT_objectNewId+".marker.end"
					DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "id"; $vT_markerEndId)
					DOM SET XML ATTRIBUTE:C866($vT_objectNewRef; "marker-end"; "url(#"+$vT_markerEndId+")")
				End if 
			End if 
			
			DOM SET XML ATTRIBUTE:C866($vT_objectNewRef; "id"; $vT_objectNewId)
			
			$vL_f:=Find in array:C230($vP_T_currentObjects->; $vT_objectOldId)
			If ($vL_f#-1)
				var $vT_handle1; $vT_handle2; $vT_handle3; $vT_handle4; $vT_handle5; $vT_handle6; $vT_handle7; $vT_handle8; $vT_select0 : Text
				$vT_handle1:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".tl")
				$vT_handle2:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".tm")
				$vT_handle3:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".tr")
				$vT_handle4:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".ml")
				$vT_handle5:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".mr")
				$vT_handle6:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".bl")
				$vT_handle7:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".bm")
				$vT_handle8:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".br")
				$vT_select0:=DOM Find XML element by ID:C1010($vT_domRef; $vT_objectOldId+".select")
				If ($vT_select0#$vT_xml_null)
					DOM SET XML ATTRIBUTE:C866($vT_handle1; "id"; $vT_objectNewId+".tl")
					DOM SET XML ATTRIBUTE:C866($vT_handle2; "id"; $vT_objectNewId+".tm")
					DOM SET XML ATTRIBUTE:C866($vT_handle3; "id"; $vT_objectNewId+".tr")
					DOM SET XML ATTRIBUTE:C866($vT_handle4; "id"; $vT_objectNewId+".ml")
					DOM SET XML ATTRIBUTE:C866($vT_handle5; "id"; $vT_objectNewId+".mr")
					DOM SET XML ATTRIBUTE:C866($vT_handle6; "id"; $vT_objectNewId+".bl")
					DOM SET XML ATTRIBUTE:C866($vT_handle7; "id"; $vT_objectNewId+".bm")
					DOM SET XML ATTRIBUTE:C866($vT_handle8; "id"; $vT_objectNewId+".br")
					DOM SET XML ATTRIBUTE:C866($vT_select0; "id"; $vT_objectNewId+".select")
				End if 
				$vP_T_currentObjects->{$vL_f}:=$vT_objectNewRef
			End if 
		End if 
	End for 
End if 

//$Width->:=$w
//$Height->:=$h

svgE_FORM_canvas_redraw
svgE_FORM_Size_validate
svgE_SELECT_Clear
svgE_SELECT_Clear_context
svgE_EDIT_shortcuts_update
svgE_HISTORY_Update_list

