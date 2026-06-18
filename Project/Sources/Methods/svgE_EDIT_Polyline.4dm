//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

// =>
var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)

var $vT_currentHandle; $vT_currentObject; $vT_currentPolylineObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_currentHandle:=$vJ_canvas.currentHandle
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vT_line_handle_fill; $vT_line_handle_stroke : Text
$vT_line_handle_stroke:=$vJ_ui.line_handle_stroke
$vT_line_handle_fill:=$vJ_ui.line_handle_fill

var $vR_handle_fill_opacity; $vR_handle_stroke_opacity; $vR_handle_stroke_width : Real
$vR_handle_fill_opacity:=$vJ_ui.handle_fill_opacity
$vR_handle_stroke_opacity:=$vJ_ui.handle_stroke_opacity
$vR_handle_stroke_width:=$vJ_ui.handle_stroke_width

var $vL_handle_radius; $vL_handles_diameter : Integer
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2

//
var $vP_aR_polylinePointX; $vP_aR_polylinePointY; $vP_aT_canvasCurrentObjects; $vP_aT_polylineHandles : Pointer
$vP_aT_canvasCurrentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$vP_aT_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")
$vP_aR_polylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointX")
$vP_aR_polylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointY")

If (Length:C16($vT_currentObject)#0)
	If (Length:C16($vT_currentHandle)=0)
		If ($vT_currentObject#$vT_currentPolylineObject)
			
			var $vT_objectType : Text
			DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
			
			If ($vT_objectType="polyline")
				//C_TEXT($object)  //cancel selection durint polyline edit
				//$object:=$vT_currentObject
				svgE_SELECT_OBJ_none
				$vJ_canvas.t_currentObject:=$vT_currentObject  //remember the current object=polyline
				
				ARRAY TEXT:C222($vP_aT_polylineHandles->; 0)
				ARRAY REAL:C219($vP_aR_polylinePointX->; 0)
				ARRAY REAL:C219($vP_aR_polylinePointY->; 0)
				
				var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
				var $vR_x; $vR_y; $vR_w; $vR_h; $vR_s : Real
				
				svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h; ->$vR_s; $vP_aR_polylinePointX; $vP_aR_polylinePointY)
				$vJ_polyline.scaleX:=$vR_sx
				$vJ_polyline.scaleY:=$vR_sy
				
				var $i; $tt : Integer
				var $vT_polylinePointHandle : Text
				$tt:=Size of array:C274($vP_aR_polylinePointX->)
				For ($i; 1; $tt)
					$vT_polylinePointHandle:=SVG_New_rect($vT_domRef; ($vP_aR_polylinePointX->{$i}*$vR_sx)-$vL_handle_radius; ($vP_aR_polylinePointY->{$i}*$vR_sy)-$vL_handle_radius; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_line_handle_stroke; $vT_line_handle_fill; $vR_handle_stroke_width)
					DOM SET XML ATTRIBUTE:C866($vT_polylinePointHandle; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".point."+String:C10($i))
					svgE_OBJECT_set_transform($vT_polylinePointHandle; $vR_tx; $vR_ty; 1; 1; $vR_r; $vR_cx; $vR_cy)
					APPEND TO ARRAY:C911($vP_aT_polylineHandles->; $vT_polylinePointHandle)
				End for 
				
				APPEND TO ARRAY:C911($vP_aT_canvasCurrentObjects->; $vT_currentObject)
				$vJ_polyline.t_currentObject:=$vT_currentObject
				
				//no point is selected by default
				$vP_aT_polylineHandles->:=0
				//SET CURSOR(0)//retain the move cursor
				SET TIMER:C645(0)
				$0:=True:C214
			End if 
			
		Else 
			//already in edit mode
		End if 
	End if 
End if 

