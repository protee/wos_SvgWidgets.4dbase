//%attributes = {"invisible":true,"lang":"en"}


#DECLARE()->$isOk : Boolean
var $vL_fill_opacity; $i; $vL_countAttributes; $j : Integer
var $vJ_canvas; $vJ_fill : Object
var $vP_canvas; $vP__T_currentObjects : Pointer
var $vT_domRef; $vT_editTextObject; $vT_fill_colour; $vT_currentObject; $vT_objectType; $vT_attributeName; $vT_fillColour : Text
$isOk:=False:C215

$vT_domRef:=Form:C1466.t_domRef

svgE_getStuff_vJ(->$vJ_canvas)
$vT_editTextObject:=$vJ_canvas.t_editTextObject

$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP__T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

$vJ_fill:=wos_getWidget("wos_fill")
$vT_fill_colour:=$vJ_fill.t_colour
$vL_fill_opacity:=$vJ_fill.l_opacity


For ($i; 1; Size of array:C274($vP__T_currentObjects->))
	$vT_currentObject:=$vP__T_currentObjects->{$i}
	$vT_objectType:=""
	DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
	
	Case of 
		: ($vT_objectType="line") | ($vT_objectType="polyline") | ($vT_objectType="rect") | ($vT_objectType="circle") | ($vT_objectType="ellipse")
			$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject)
			ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
			ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
			
			For ($j; 1; $vL_countAttributes)
				DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject; $j; $aT_attributeNames{$j}; $aT_attributeValues{$j})
			End for 
			
			$vT_attributeName:="fill"
			$vT_fillColour:=""
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_fillColour)
			End if 
			If ($vT_fillColour#$vT_fill_colour)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_fill_colour)
				$isOk:=True:C214
			End if 
			
	End case 
	
	// Opacity
	Case of 
		: ($vT_objectType="image")
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "opacity"; $vL_fill_opacity/100)
			$isOk:=True:C214
			
		: ($vT_objectType="polyline") | ($vT_objectType="circle") | ($vT_objectType="ellipse") | ($vT_objectType="rect")
			If ($vT_currentObject#$vT_editTextObject)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "fill-opacity"; $vL_fill_opacity/100)
				$isOk:=True:C214
			End if 
			
			//: ($vT_objectType="line")
			//var $vT_xml_null : Text
			//$vT_xml_null:=wos__storage_stuff.t_xml_null
			//SVG_SET_OPACITY ($vT_currentObject;0;$fill_opacity)
			
			//$markerStartId:=$vT_currentObject+".marker.start"
			//$markerStart:=DOM Find XML element by ID($vT_currentObject;$markerStartId)
			//$markerEndId:=$vT_currentObject+".marker.end"
			//$markerEnd:=DOM Find XML element by ID($vT_currentObject;$markerEndId)
			//If ($markerStart#$vT_xml_null)
			//SVG_SET_OPACITY ($markerStart;$fill_opacity;0)
			//End if
			//If ($markerEnd#$vT_xml_null)
			//SVG_SET_OPACITY ($markerEnd;$fill_opacity;0)
			//End if
			//$isOk:=True
	End case 
	
End for 

