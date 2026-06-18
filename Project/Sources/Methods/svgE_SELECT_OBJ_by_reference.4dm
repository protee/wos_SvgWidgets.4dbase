//%attributes = {"invisible":true,"lang":"en"}

var $vT_currentObject : Text
$vT_currentObject:=$1

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
//$currentObject:=$ob_canvas.t_currentObject

var $vT_objectType; $vT_rect : Text
var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentObject)#0)
	DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
	
	var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
	var $vR_x; $vR_y; $vR_w; $vR_h; $vR_s : Real
	
	Case of 
		: ($vT_objectType="rect") | ($vT_objectType="image") | ($vT_objectType="textArea") | ($vT_objectType="circle") | ($vT_objectType="line") | ($vT_objectType="ellipse") | ($vT_objectType="polyline")
			var $vJ_ui : Object
			$vJ_ui:=wos__storage_prefs_ui
			var $vT_selection_fill; $vT_selection_stroke : Text
			$vT_selection_fill:=$vJ_ui.selection_fill
			$vT_selection_stroke:=$vJ_ui.selection_stroke
			var $vR_selection_fill_opacity; $vR_selection_stroke_opacity; $vR_selection_stroke_width : Real
			$vR_selection_fill_opacity:=$vJ_ui.selection_fill_opacity
			$vR_selection_stroke_opacity:=$vJ_ui.selection_stroke_opacity
			$vR_selection_stroke_width:=$vJ_ui.selection_stroke_width
			
			$vT_rect:=SVG_New_rect($vT_domRef; 0; 0; 0; 0; 0; 0; $vT_selection_stroke; $vT_selection_fill; $vR_selection_stroke_width)
			DOM SET XML ATTRIBUTE:C866($vT_rect; "fill-opacity"; $vR_selection_fill_opacity; "stroke-opacity"; $vR_selection_stroke_opacity; "id"; $vT_currentObject+".select")
			svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h; ->$vR_s)
			//If ($objectType#"rect")
			//$s:=1
			//End if
			$vR_s:=1
			
			Case of 
				: ($vT_objectType="line")  //need to have position width and height for ID search by to work
					If ($vR_w<0)
						$vR_w:=Abs:C99($vR_w)
						$vR_x:=-($vR_w/2)
					End if 
					If ($vR_h<0)
						$vR_h:=Abs:C99($vR_h)
						$vR_y:=-($vR_h/2)
					End if 
					
				: ($vT_objectType="polyline")
					$vR_w:=$vR_w*$vR_sx
					$vR_h:=$vR_h*$vR_sy
					$vR_x:=-($vR_w/2)
					$vR_y:=-($vR_h/2)
					$vR_sx:=1
					$vR_sy:=1
					
			End case 
			
			svgE_OBJECT_set_transform($vT_rect; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
			DOM SET XML ATTRIBUTE:C866($vT_rect; "x"; $vR_x; "y"; $vR_y; "width"; $vR_w; "height"; $vR_h; "stroke-width"; $vR_s)
			
			If ($vT_objectType="textArea")
				var $vT_textGuideObject : Text
				$vT_textGuideObject:=$vJ_canvas.textGuideObject
				If (Length:C16($vT_textGuideObject)#0)
					DOM REMOVE XML ELEMENT:C869($vT_textGuideObject)
					$vJ_canvas.textGuideObject:=""
				End if 
			End if 
			$isOk:=True:C214
			
		Else   //other object types
	End case 
	
End if 

$0:=$isOk

