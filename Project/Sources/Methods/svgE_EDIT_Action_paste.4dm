//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vT_currentObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
var $vL_moveOffset : Integer
$vL_moveOffset:=$vJ_canvas.moveOffset
var $vL_zoom : Integer
$vL_zoom:=$vJ_canvas.l_zoom
var $vT_defaultFontName : Text
var $vL_defaultFontSize : Integer
$vT_defaultFontName:=$vJ_canvas.defaultFontName
$vL_defaultFontSize:=$vJ_canvas.defaultFontSize
var $vL_pasteOffsetX; $vL_pasteOffsetY : Integer
$vL_pasteOffsetX:=$vJ_canvas.pasteOffsetX
$vL_pasteOffsetY:=$vJ_canvas.pasteOffsetY

var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")


var $vR_scale : Real
$vR_scale:=$vL_zoom/100

var $vJ_fill : Object
$vJ_fill:=wos_getWidget("wos_fill")
var $vT_fill_colour : Text
$vT_fill_colour:=$vJ_fill.t_colour

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

var $isOk : Boolean
$isOk:=False:C215

ARRAY TEXT:C222($aT_signatures; 0)
ARRAY TEXT:C222($aT_types; 0)
ARRAY TEXT:C222($aT_formats; 0)
GET PASTEBOARD DATA TYPE:C958($aT_signatures; $aT_types; $aT_formats)

Case of 
	: (Find in array:C230($aT_types; "private.4d.svg.data")#-1) | (Find in array:C230($aT_formats; "private.4d.svg.data")#-1)
		
		var $vX_svgData : Blob
		GET PASTEBOARD DATA:C401("private.4d.svg.data"; $vX_svgData)
		
		var $vT_object; $vT_objectType; $vT_svg : Text
		$vT_svg:=DOM Parse XML variable:C720($vX_svgData)
		
		var $i; $j; $vL_t : Integer
		
		var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
		var $vR_x; $vR_y; $vR_w; $vR_h : Real
		
		
		$vT_objectType:=""
		$vT_object:=DOM Get first child XML element:C723($vT_svg; $vT_objectType)
		
		If ($vT_object#$vT_xml_null)
			$i:=1
			var $vT_lastObject : Text
			$vT_lastObject:=DOM Get last child XML element:C925($vT_svg)
			Repeat 
				
				If ($i#1)
					$vT_object:=DOM Get next sibling XML element:C724($vT_object; $vT_objectType)
				End if 
				
				If ($vT_objectType="textArea") | ($vT_objectType="circle") | ($vT_objectType="ellipse") | ($vT_objectType="rect") | ($vT_objectType="line") | ($vT_objectType="polyline") | ($vT_objectType="image")
					
					If (Not:C34($isOk))
						$vL_pasteOffsetX:=$vL_pasteOffsetX+$vL_moveOffset
						$vL_pasteOffsetY:=$vL_pasteOffsetY+$vL_moveOffset
						$vJ_canvas.pasteOffsetX:=$vL_pasteOffsetX
						$vJ_canvas.pasteOffsetY:=$vL_pasteOffsetY
						$isOk:=True:C214
					End if 
					
					$vT_objectType:=svgE_OBJECT_Get_transform($vT_object; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
					
					$vR_tx:=$vR_tx+$vL_pasteOffsetX
					$vR_ty:=$vR_ty+$vL_pasteOffsetY
					
					$vT_currentObject:=DOM Create XML element:C865($vT_domRef; $vT_objectType)
					$vJ_canvas.t_currentObject:=$vT_currentObject
					var $vL_countAttributes : Integer
					$vL_countAttributes:=DOM Count XML attributes:C727($vT_object)
					ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
					ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
					
					For ($j; 1; $vL_countAttributes)
						DOM GET XML ATTRIBUTE BY INDEX:C729($vT_object; $j; $aT_attributeNames{$j}; $aT_attributeValues{$j})
						Case of 
							: ($aT_attributeNames{$j}="transform")  //use dedicated method for this attribute
							: ($aT_attributeNames{$j}="id")  //will set this later
							Else 
								DOM SET XML ATTRIBUTE:C866($vT_currentObject; $aT_attributeNames{$j}; $aT_attributeValues{$j})
						End case 
						
					End for 
					
					svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
					
					DOM SET XML ATTRIBUTE:C866($vT_currentObject; "id"; $vT_currentObject)
					
					APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
					Case of 
						: ($vT_objectType="textArea")
							ARRAY LONGINT:C221($aL_nodeType; 0)
							ARRAY TEXT:C222($aT_nodeData; 0)
							DOM GET XML CHILD NODES:C1081($vT_object; $aL_nodeType; $aT_nodeData)
							
							var $vL_nodes : Integer
							var $vT_append; $vT_nodeName : Text
							$vT_nodeName:=""
							$vL_t:=0
							For ($vL_nodes; 1; Size of array:C274($aL_nodeType))
								Case of 
									: ($aL_nodeType{$vL_nodes}=XML DATA:K45:12)
										If ($vL_t=0)
											DOM SET XML ELEMENT VALUE:C868($vT_currentObject; $aT_nodeData{$vL_nodes})
											$vL_t:=1
										Else 
											$vT_append:=DOM Append XML child node:C1080($vT_currentObject; XML DATA:K45:12; $aT_nodeData{$vL_nodes})
										End if 
									: ($aL_nodeType{$vL_nodes}=XML ELEMENT:K45:20)
										DOM GET XML ELEMENT NAME:C730($aT_nodeData{$vL_nodes}; $vT_nodeName)
										If ($vT_nodeName="tbreak")
											var $vT_tbreak : Text
											$vT_tbreak:=DOM Create XML element:C865($vT_currentObject; "tbreak")
										End if 
								End case 
							End for 
							
						: ($vT_objectType="line") | ($vT_objectType="polyline")
							svgE_OBJECT_set_marker($vT_currentObject)
							
						: ($vT_objectType="circle")
						: ($vT_objectType="ellipse")
						: ($vT_objectType="rect")
						: ($vT_objectType="image")
					End case 
					
					$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
					$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
					
				End if 
				
				$i:=$i+1
			Until ($vT_object=$vT_lastObject)
		End if 
		
		DOM CLOSE XML:C722($vT_svg)
		
	: (Find in array:C230($aT_signatures; "com.4d.private.picture.@")#-1)
		
		If (Not:C34($isOk))
			$vL_pasteOffsetX:=$vL_pasteOffsetX+$vL_moveOffset
			$vL_pasteOffsetY:=$vL_pasteOffsetY+$vL_moveOffset
			$isOk:=True:C214
		End if 
		
		var $vO_copyImage : Picture
		GET PICTURE FROM PASTEBOARD:C522($vO_copyImage)
		
		var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
		OBJECT GET COORDINATES:C663(*; "Canvas"; $vL_left; $vL_top; $vL_right; $vL_bottom)
		
		var $vR_imgWidth; $vR_imgHeight : Real
		$vR_imgWidth:=($vL_right-$vL_left)/$vR_scale
		$vR_imgHeight:=($vL_bottom-$vL_top)/$vR_scale
		
		PICTURE PROPERTIES:C457($vO_copyImage; $vR_w; $vR_h)
		
		var $vL_scrH; $vL_scrV : Integer
		OBJECT GET SCROLL POSITION:C1114(*; "Canvas"; $vL_scrV; $vL_scrH)
		
		$vR_tx:=$vL_pasteOffsetX+$vL_scrH+($vR_w/2)
		$vR_ty:=$vL_pasteOffsetY+$vL_scrV+($vR_h/2)
		
		$vR_sx:=1
		$vR_sy:=1
		
		$vR_x:=-($vR_w/2)
		$vR_y:=-($vR_h/2)
		
		$vT_currentObject:=SVG_New_embedded_image($vT_domRef; $vO_copyImage)
		$vJ_canvas.t_currentObject:=$vT_currentObject
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y; "id"; $vT_currentObject)
		svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
		
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
		$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
		
	: (Find in array:C230($aT_signatures; "com.4d.private.text.@")#-1)
		
		If (Not:C34($isOk))
			$vL_pasteOffsetX:=$vL_pasteOffsetX+$vL_moveOffset
			$vL_pasteOffsetY:=$vL_pasteOffsetY+$vL_moveOffset
			$isOk:=True:C214
		End if 
		
		var $vT_copyText; $vT_text : Text
		$vT_copyText:=Get text from pasteboard:C524
		
		var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
		OBJECT GET COORDINATES:C663(*; "Canvas"; $vL_left; $vL_top; $vL_right; $vL_bottom)
		
		var $vR_imgWidth; $vR_imgHeight : Real
		$vR_imgWidth:=($vL_right-$vL_left)/$vR_scale
		$vR_imgHeight:=($vL_bottom-$vL_top)/$vR_scale
		
		$vT_svg:=SVG_New
		$vT_text:=SVG_New_textArea($vT_svg; $vT_copyText)
		DOM SET XML ATTRIBUTE:C866($vT_text; "font-size"; $vL_defaultFontSize; "font-family"; $vT_defaultFontName)
		var $vO_image : Picture
		SVG EXPORT TO PICTURE:C1017($vT_svg; $vO_image)
		PICTURE PROPERTIES:C457($vO_image; $vR_w; $vR_h)
		DOM CLOSE XML:C722($vT_svg)
		
		var $vL_scrH; $vL_scrV : Integer
		OBJECT GET SCROLL POSITION:C1114(*; "Canvas"; $vL_scrV; $vL_scrH)
		
		$vR_tx:=$vL_pasteOffsetX+$vL_scrH+($vR_w/2)
		$vR_ty:=$vL_pasteOffsetY+$vL_scrV+($vR_h/2)
		
		$vR_sx:=1
		$vR_sy:=1
		
		$vR_x:=-($vR_w/2)
		$vR_y:=-($vR_h/2)
		
		$vT_currentObject:=SVG_New_textArea($vT_domRef; $vT_copyText)
		$vJ_canvas.t_currentObject:=$vT_currentObject
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y; "id"; $vT_currentObject; "font-size"; $vL_defaultFontSize; "font-family"; $vT_defaultFontName; "fill"; $vT_fill_colour)
		svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
		
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		
		$isOk:=$isOk | svgE_SELECT_OBJ_by_reference
		$isOk:=$isOk | svgE_SELECT_Display_handles
		
End case 

$0:=$isOk

