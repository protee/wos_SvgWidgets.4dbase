//%attributes = {"invisible":true,"lang":"en"}

var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)

var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

If (OB Is defined:C1231($vJ_canvas; "picture"))
	SET CURSOR:C469(9016)  // Add cursor...
Else 
	var $vT_objectUnderCursor : Text
	$vT_objectUnderCursor:=SVG Find element ID by coordinates:C1054($vP_canvas->; MouseX; MouseY)
	If ($vT_objectUnderCursor#"")
		Case of 
			: ($vT_objectUnderCursor="@.point.@")
				SET CURSOR:C469(9002)
			: ($vT_objectUnderCursor="@.tl")
				SET CURSOR:C469(9005)
			: ($vT_objectUnderCursor="@.tm")
				SET CURSOR:C469(9004)
			: ($vT_objectUnderCursor="@.tr")
				SET CURSOR:C469(9006)
			: ($vT_objectUnderCursor="@.bl")
				SET CURSOR:C469(9006)
			: ($vT_objectUnderCursor="@.bm")
				SET CURSOR:C469(9004)
			: ($vT_objectUnderCursor="@.br")
				SET CURSOR:C469(9005)
			: ($vT_objectUnderCursor="@.ml")
				SET CURSOR:C469(9003)
			: ($vT_objectUnderCursor="@.mr")
				SET CURSOR:C469(9003)
			: ($vT_objectUnderCursor="@.select")
				SET CURSOR:C469(9002)
			Else 
				
				var $vT_CanvasCurrentPolylineObject : Text
				$vT_CanvasCurrentPolylineObject:=$vJ_polyline.t_currentObject
				If (Length:C16($vT_CanvasCurrentPolylineObject)#0) & ($vT_objectUnderCursor=$vT_CanvasCurrentPolylineObject)
					SET CURSOR:C469(9002)
				Else 
					SET CURSOR:C469(0)
				End if 
				
		End case 
	Else 
		SET CURSOR:C469(0)
	End if 
End if 

