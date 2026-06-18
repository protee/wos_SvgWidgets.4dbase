//%attributes = {"invisible":true,"lang":"en"}


#DECLARE()->$isOk : Boolean
var $is_line; $is_rect; $is_circle; $is_ellipse; $is_polyline; $is_all; $is_lines; $is_width; $is_stroke; $is_opacity; $is_dash; $is_join; $is_cap : Boolean
var $vL_stroke_opacity; $vL_stroke_width; $vL_stroke_marker; $vL_stroke_dash; $vL_stroke_join; $vL_stroke_cap; $i; $vL_countAttributes; $j; $vL_strokeWidth; $vL_stroke_marker_old; $vL_strokeOpacity; $vL_strokeDash : Integer
var $vJ_stroke : Object
var $vP_canvas; $vP__T_currentObjects : Pointer
var $vT_domRef; $vT_stroke_colour; $vT_xml_null; $vT_currentObject; $vT_objectType; $vT_attribute_name; $vT_strokeColour; $vT_markerStartId; $vT_markerStart; $vT_markerEndId; $vT_markerEnd; $vT_path; $vT_mano; $vT_strokeJoin; $vT_strokeCap : Text
$isOk:=False:C215

$vT_domRef:=Form:C1466.t_domRef

$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP__T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

$vJ_stroke:=wos_getWidget("wos_stroke")
$vT_stroke_colour:=$vJ_stroke.t_colour
$vL_stroke_opacity:=$vJ_stroke.l_opacity
$vL_stroke_width:=$vJ_stroke.l_width
$vL_stroke_marker:=$vJ_stroke.l_marker
$vL_stroke_dash:=$vJ_stroke.l_dash
$vL_stroke_join:=$vJ_stroke.l_join
$vL_stroke_cap:=$vJ_stroke.l_cap

//C_OBJECT($ob_fill)
//$ob_fill:=wos_getWidget ("wos_fill")
//$fill_opacity:=$ob_fill.opacity


$vT_xml_null:=wos__storage_stuff.t_xml_null

For ($i; 1; Size of array:C274($vP__T_currentObjects->))
	$vT_currentObject:=$vP__T_currentObjects->{$i}
	
	$vT_objectType:=""
	DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
	
	$is_line:=($vT_objectType="line")
	$is_rect:=($vT_objectType="rect")
	$is_circle:=($vT_objectType="circle")
	$is_ellipse:=($vT_objectType="ellipse")
	$is_polyline:=($vT_objectType="polyline")
	$is_all:=$is_line | $is_rect | $is_circle | $is_ellipse | $is_polyline
	$is_lines:=$is_line | $is_polyline
	
	$is_width:=$is_all
	$is_stroke:=$is_all
	$is_opacity:=$is_all
	$is_dash:=$is_all
	$is_join:=$is_rect | $is_polyline
	$is_cap:=$is_line | $is_polyline | $is_circle | $is_ellipse | $is_rect
	
	
	
	Case of 
		: ($is_all)
			$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject)
			ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
			ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
			For ($j; 1; $vL_countAttributes)
				DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject; $j; $aT_attributeNames{$j}; $aT_attributeValues{$j})
			End for 
			
			// Stroke
			$vT_attribute_name:="stroke"
			$vT_strokeColour:=""
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_strokeColour)
			End if 
			If ($vT_strokeColour#$vT_stroke_colour)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attribute_name; $vT_stroke_colour)
				$vT_markerStartId:=$vT_currentObject+".marker.start"
				$vT_markerStart:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_markerStartId)
				$vT_markerEndId:=$vT_currentObject+".marker.end"
				$vT_markerEnd:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_markerEndId)
				If ($vT_markerStart#$vT_xml_null)
					DOM SET XML ATTRIBUTE:C866($vT_markerStart; "fill"; $vT_stroke_colour)
				End if 
				If ($vT_markerEnd#$vT_xml_null)
					DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "fill"; $vT_stroke_colour)
				End if 
				$isOk:=True:C214
			End if 
			
			// Width
			$vT_attribute_name:="stroke-width"
			$vL_strokeWidth:=-1
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vL_strokeWidth)
			End if 
			If ($vL_strokeWidth#$vL_stroke_width)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attribute_name; $vL_stroke_width)
				$isOk:=True:C214
			End if 
			//If ($vT_objectType="rect")
			//$rect:=DOM Find XML element by ID($vT_currentObject;$vT_currentObject+".select")
			//If ($rect#$vT_xml_null)
			//DOM SET XML ATTRIBUTE($rect;$vT_attribute_name;$stroke_width)
			//End if
			//End if
			
			// Marker
			$vT_markerStartId:=$vT_currentObject+".marker.start"
			$vT_markerStart:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_markerStartId)
			$vT_markerEndId:=$vT_currentObject+".marker.end"
			$vT_markerEnd:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_markerEndId)
			
			$vL_stroke_marker_old:=0
			If ($vT_markerStart#$vT_xml_null)
				DOM REMOVE XML ELEMENT:C869($vT_markerStart)
				DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "marker-start")
				$vL_stroke_marker_old:=$vL_stroke_marker_old ?+ 0
			End if 
			
			If ($vT_markerEnd#$vT_xml_null)
				DOM REMOVE XML ELEMENT:C869($vT_markerEnd)
				DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "marker-end")
				$vL_stroke_marker_old:=$vL_stroke_marker_old ?+ 1
			End if 
			$isOk:=$isOk | ($vL_stroke_marker#$vL_stroke_marker_old)
			
			If ($vL_stroke_marker ?? 0)
				$vT_markerStart:=SVG_Define_marker($vT_domRef; $vT_markerStartId; 5; 3; 6; 6)
				DOM SET XML ATTRIBUTE:C866($vT_markerStart; "orient"; "auto")
				$vT_path:=SVG_New_polygon($vT_markerStart; "5,1 1,3 5,5")
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-start"; "url(#"+$vT_markerStartId+")")
				If ($is_lines)
					DOM SET XML ATTRIBUTE:C866($vT_markerStart; "fill"; $vT_stroke_colour; "fill-opacity"; $vL_stroke_opacity/100; "stroke-opacity"; 0)
				End if 
				//$isOk:=True
			End if 
			
			If ($vL_stroke_marker ?? 1)
				$vT_markerEnd:=SVG_Define_marker($vT_domRef; $vT_markerEndId; 1; 3; 6; 6)
				DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "orient"; "auto")
				$vT_path:=SVG_New_polygon($vT_markerEnd; "1,1 1,5 5,3")
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-end"; "url(#"+$vT_markerEndId+")")
				If ($is_lines)
					DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "fill"; $vT_stroke_colour; "fill-opacity"; $vL_stroke_opacity/100; "stroke-opacity"; 0)
				End if 
				//$isOk:=True
			End if 
			
			
			// Opacity
			$vT_attribute_name:="stroke-opacity"
			$vL_strokeOpacity:=-1
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vL_strokeOpacity)
			End if 
			$vL_strokeOpacity:=$vL_strokeOpacity*100
			If ($vL_strokeOpacity#$vL_stroke_opacity)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attribute_name; $vL_stroke_opacity/100)
				$isOk:=True:C214
			End if 
			
			// dasharray
			$vT_attribute_name:="stroke-dasharray"
			$vL_strokeDash:=-1
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				$vT_mano:=""
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_mano)
				$vL_strokeDash:=Num:C11(Substring:C12($vT_mano; 1; 2))
			End if 
			If ($vL_strokeDash#$vL_stroke_dash)
				$vT_mano:=String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attribute_name; $vT_mano)
				$isOk:=True:C214
			End if 
			
			// stroke-linejoin
			If ($is_join)
				$vT_attribute_name:="stroke-linejoin"
				$vT_mano:=""
				If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_mano)
				End if 
				$vT_strokeJoin:=wos__storage_stuff.at_stroke_linejoin[$vL_stroke_join]
				If ($vT_mano#$vT_strokeJoin)
					DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attribute_name; $vT_strokeJoin)
					$isOk:=True:C214
				End if 
			End if 
			
			If ($is_cap)
				$vT_attribute_name:="stroke-linecap"
				$vT_mano:=""
				If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_mano)
				End if 
				$vT_strokeCap:=wos__storage_stuff.at_stroke_linecap[$vL_stroke_cap]
				If ($vT_mano#$vT_strokeCap)
					DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attribute_name; $vT_strokeCap)
					$isOk:=True:C214
				End if 
			End if 
			
			//if ($vT_objectType="line")
			//$vT_markerStartId:=$ptr_T_currentObjects->{$i}+".marker.start"
			//$vT_markerStart:=DOM Find XML element by ID($ptr_T_currentObjects->{$i};$vT_markerStartId)
			//$vT_markerEndId:=$ptr_T_currentObjects->{$i}+".marker.end"
			//$vT_markerEnd:=DOM Find XML element by ID($ptr_T_currentObjects->{$i};$vT_markerEndId)
			//If ($vT_markerStart#$vT_xml_null)
			//SVG_SET_OPACITY ($vT_markerStart;$stroke_opacity;0)
			//DOM SET XML ATTRIBUTE($vT_markerStart;"fill";$stroke_colour)
			//End if
			//If ($vT_markerEnd#$vT_xml_null)
			//SVG_SET_OPACITY ($vT_markerEnd;$stroke_opacity;0)
			//DOM SET XML ATTRIBUTE($vT_markerEnd;"fill";$stroke_colour)
			//End if
			//$isOk:=True
			//end if
			
			
	End case 
	
End for 

