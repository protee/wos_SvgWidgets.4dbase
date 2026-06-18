//%attributes = {"invisible":true,"lang":"en"}
// Project Method: _svgEditor_get_svg
//
// Parameter Type Description
// $0 <T> <- Get back the svg in text
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.

#DECLARE()->$vT_svg : Text
var $vT_xml_null; $vT_domRef; $vT_dom_svg; $vT_idx_currentObjects; $vT_rect; $vT_reserved_name_p; $vT_reserved_name_m; $vT_reservedObject; $vT_defs; $vT_idx_objectIDs; $vT_objectType; $vT_markerStartId; $vT_markerStart; $vT_markerEndId; $vT_markerEnd; $vT_path; $vT_object; $vT_attributeName; $vT_attributeValue; $vT_fillColor; $vT_append; $vT_nodeName; $vT_tbreak : Text
var $vX_svgData : Blob
var $tt; $i; $vL_h; $vL_width; $vL_height; $vL_countAttributes; $j; $vL_t; $tt_nodes; $vL_nodes; $vL_nodeType : Integer
var $vJ_stuff : Object
var $vO_picture : Picture
var $vP_T_currentObjects : Pointer
$vT_svg:=""

$vJ_stuff:=wos__storage_stuff()
$vT_xml_null:=$vJ_stuff.t_xml_null


$vT_domRef:=Form:C1466.t_domRef
If (Length:C16($vT_domRef)#0)
	DOM EXPORT TO VAR:C863($vT_domRef; $vX_svgData)
	$vT_dom_svg:=DOM Parse XML variable:C720($vX_svgData)
	//SVG EXPORT TO PICTURE($vT_dom_svg;$vO_picture)
	
	$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
	$tt:=Size of array:C274($vP_T_currentObjects->)
	For ($i; 1; $tt)
		$vT_idx_currentObjects:=$vP_T_currentObjects->{$i}
		$vT_rect:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".select")
		If ($vT_rect#$vT_xml_null)
			DOM REMOVE XML ELEMENT:C869($vT_rect)
		End if 
		ARRAY TEXT:C222($aT_handles; 8)
		$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".tl")
		$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".tm")
		$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".tr")
		$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".ml")
		$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".mr")
		$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".bl")
		$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".bm")
		$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_idx_currentObjects+".br")
		For ($vL_h; 1; 8)
			If ($aT_handles{$vL_h}#$vT_xml_null)
				DOM REMOVE XML ELEMENT:C869($aT_handles{$vL_h})
			End if 
		End for 
	End for 
	
	$vT_reserved_name_p:=$vJ_stuff.t_reserved_p
	$vT_reserved_name_m:=$vJ_stuff.t_reserved_m
	
	$vT_reservedObject:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_reserved_name_p)
	If ($vT_reservedObject#$vT_xml_null)
		DOM REMOVE XML ELEMENT:C869($vT_reservedObject)
	End if 
	$vT_reservedObject:=DOM Find XML element by ID:C1010($vT_dom_svg; $vT_reserved_name_m)
	If ($vT_reservedObject#$vT_xml_null)
		DOM REMOVE XML ELEMENT:C869($vT_reservedObject)
	End if 
	
	SVG EXPORT TO PICTURE:C1017($vT_dom_svg; $vO_picture)
	PICTURE PROPERTIES:C457($vO_picture; $vL_width; $vL_height)
	
	ARRAY TEXT:C222($aT_objectIDs; 0)
	If (SVG Find element IDs by rect:C1109($vO_picture; 0; 0; $vL_width; $vL_height; $aT_objectIDs))
		DOM CLOSE XML:C722($vT_dom_svg)
		//$svg:=SVG_New ($width;$height)
		$vT_dom_svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
		DOM SET XML ATTRIBUTE:C866($vT_dom_svg; "width"; $vL_width; "height"; $vL_height)
		$vT_defs:=DOM Create XML element:C865($vT_dom_svg; "defs"; "id"; "4D")  //place holder
		
		$tt:=Size of array:C274($aT_objectIDs)
		For ($i; 1; $tt)
			$vT_idx_objectIDs:=$aT_objectIDs{$i}
			DOM GET XML ELEMENT NAME:C730($vT_idx_objectIDs; $vT_objectType)
			
			Case of 
				: ($vT_objectType="line") | ($vT_objectType="polyline")
					$vT_markerStartId:=$vT_idx_objectIDs+".marker.start"
					$vT_markerStart:=DOM Find XML element by ID:C1010($vT_idx_objectIDs; $vT_markerStartId)
					$vT_markerEndId:=$vT_idx_objectIDs+".marker.end"
					$vT_markerEnd:=DOM Find XML element by ID:C1010($vT_idx_objectIDs; $vT_markerEndId)
					If ($vT_markerStart#$vT_xml_null)
						$vT_markerStart:=SVG_Define_marker($vT_dom_svg; $vT_markerStartId; 5; 3; 6; 6)
						$vT_path:=SVG_New_polygon($vT_markerStart; "5,1 1,3 5,5")
					End if 
					If ($vT_markerEnd#$vT_xml_null)
						$vT_markerEnd:=SVG_Define_marker($vT_dom_svg; $vT_markerEndId; 1; 3; 6; 6)
						$vT_path:=SVG_New_polygon($vT_markerEnd; "1,1 1,5 5,3")
					End if 
			End case 
			
			$vT_object:=DOM Create XML element:C865($vT_dom_svg; $vT_objectType)
			$vL_countAttributes:=DOM Count XML attributes:C727($vT_idx_objectIDs)
			ARRAY TEXT:C222($aT_attributeNames; 0)
			ARRAY TEXT:C222($aT_attributeValues; 0)
			For ($j; 1; $vL_countAttributes)
				DOM GET XML ATTRIBUTE BY INDEX:C729($vT_idx_objectIDs; $j; $vT_attributeName; $vT_attributeValue)
				If ($vT_attributeName#"id")
					APPEND TO ARRAY:C911($aT_attributeNames; $vT_attributeName)
					APPEND TO ARRAY:C911($aT_attributeValues; $vT_attributeValue)
					DOM SET XML ATTRIBUTE:C866($vT_object; $vT_attributeName; $vT_attributeValue)
				End if 
			End for 
			
			Case of 
				: ($vT_objectType="line") | ($vT_objectType="polyline")
					If (Find in array:C230($aT_attributeNames; "stroke")#-1)
						DOM GET XML ATTRIBUTE BY NAME:C728($vT_idx_objectIDs; "stroke"; $vT_fillColor)
						If ($vT_markerStart#$vT_xml_null)
							$vT_markerStartId:=$vT_object+".marker.start"
							DOM SET XML ATTRIBUTE:C866($vT_markerStart; "orient"; "auto"; "fill"; $vT_fillColor; "id"; $vT_markerStartId)
							DOM SET XML ATTRIBUTE:C866($vT_object; "marker-start"; "url(#"+$vT_markerStartId+")")
						End if 
						If ($vT_markerEnd#$vT_xml_null)
							$vT_markerEndId:=$vT_object+".marker.end"
							DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "orient"; "auto"; "fill"; $vT_fillColor; "id"; $vT_markerEndId)
							DOM SET XML ATTRIBUTE:C866($vT_object; "marker-end"; "url(#"+$vT_markerEndId+")")
						End if 
					End if 
					
				: ($vT_objectType="textArea")
					ARRAY LONGINT:C221($aL_nodeType; 0)
					ARRAY TEXT:C222($aT_nodeData; 0)
					DOM GET XML CHILD NODES:C1081($vT_idx_objectIDs; $aL_nodeType; $aT_nodeData)
					$vL_t:=0
					$tt_nodes:=Size of array:C274($aL_nodeType)
					For ($vL_nodes; 1; $tt_nodes)
						$vL_nodeType:=$aL_nodeType{$vL_nodes}
						Case of 
							: ($vL_nodeType=XML DATA:K45:12)
								If ($vL_t=0)
									DOM SET XML ELEMENT VALUE:C868($vT_object; $aT_nodeData{$vL_nodes})
									$vL_t:=1
								Else 
									$vT_append:=DOM Append XML child node:C1080($vT_object; XML DATA:K45:12; $aT_nodeData{$vL_nodes})
								End if 
							: ($vL_nodeType=XML ELEMENT:K45:20)
								DOM GET XML ELEMENT NAME:C730($aT_nodeData{$vL_nodes}; $vT_nodeName)
								If ($vT_nodeName="tbreak")
									$vT_tbreak:=DOM Create XML element:C865($vT_object; "tbreak")
								End if 
						End case 
					End for 
			End case 
		End for 
		//SVG EXPORT TO PICTURE($vT_dom_svg;$vO_picture) // Non relevant ?
	End if 
	DOM EXPORT TO VAR:C863($vT_dom_svg; $vT_svg)
	DOM CLOSE XML:C722($vT_dom_svg)
End if 
