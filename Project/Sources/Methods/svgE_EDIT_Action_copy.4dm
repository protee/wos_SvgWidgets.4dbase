//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vP_canvas; $vP_aT_currentObjects : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $isOk : Boolean
$isOk:=False:C215

var $tt : Integer
$tt:=Size of array:C274($vP_aT_currentObjects->)
If ($tt#0)
	//OBJECT SET ENABLED(*;"paste_btn";True)
	//$vT_edits:="wos_edits"
	//C_OBJECT($ob_gws_edits;$ob_gws_edits_enablers)
	//$ob_gws_edits:=OBJECT Get pointer(Object named;$vT_edits)->
	//$ob_gws_edits_enablers:=$ob_gws_edits.enablers
	//$ob_gws_edits_enablers.is_paste:=True
	//wos_redraw ($vT_edits)
	
	
	var $i; $j; $vL_t : Integer
	var $vL_height; $vL_width : Integer
	var $vT_idx_currentObjects; $vT_defs; $vT_svg : Text
	PICTURE PROPERTIES:C457($vP_canvas->; $vL_width; $vL_height)
	//$vT_svg:=SVG_New ($vL_width;$vL_height)
	$vT_svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
	DOM SET XML ATTRIBUTE:C866($vT_svg; "width"; $vL_width; "height"; $vL_height)
	$vT_defs:=DOM Create XML element:C865($vT_svg; "defs"; "id"; "4D")  //place holder
	var $vT_objectType : Text
	
	var $vT_xml_null : Text
	$vT_xml_null:=wos__storage_stuff.t_xml_null
	
	For ($i; 1; $tt)
		$vT_idx_currentObjects:=$vP_aT_currentObjects->{$i}
		DOM GET XML ELEMENT NAME:C730($vT_idx_currentObjects; $vT_objectType)
		var $vL_countAttributes : Integer
		var $vT_object : Text
		$vL_countAttributes:=DOM Count XML attributes:C727($vT_idx_currentObjects)
		ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
		ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
		$vT_object:=DOM Create XML element:C865($vT_svg; $vT_objectType)
		
		For ($j; 1; $vL_countAttributes)
			DOM GET XML ATTRIBUTE BY INDEX:C729($vT_idx_currentObjects; $j; $aT_attributeNames{$j}; $aT_attributeValues{$j})
			DOM SET XML ATTRIBUTE:C866($vT_object; $aT_attributeNames{$j}; $aT_attributeValues{$j})
		End for 
		
		Case of 
			: ($vT_objectType="line") | ($vT_objectType="polyline")
				var $vT_markerEnd; $vT_markerEndId; $vT_markerStart; $vT_markerStartId : Text
				$vT_markerStartId:=$vT_idx_currentObjects+".marker.start"
				$vT_markerStart:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_markerStartId)
				
				$vT_markerEndId:=$vT_idx_currentObjects+".marker.end"
				$vT_markerEnd:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_markerEndId)
				
				var $vT_fillColor; $vT_fillOpacity : Text
				
				If (Find in array:C230($aT_attributeNames; "stroke-opacity")#-1)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_idx_currentObjects; "stroke-opacity"; $vT_fillOpacity)
				End if 
				
				If (Find in array:C230($aT_attributeNames; "stroke")#-1)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_idx_currentObjects; "stroke"; $vT_fillColor)
					If ($vT_markerStart#$vT_xml_null)
						$vT_markerStartId:=$vT_object+".marker.start"
						$vT_markerStart:=SVG_Define_marker($vT_svg; $vT_markerStartId; 5; 3; 6; 6)
						DOM SET XML ATTRIBUTE:C866($vT_markerStart; "orient"; "auto"; "fill"; $vT_fillColor; "id"; $vT_markerStartId)
						var $vT_path : Text
						$vT_path:=SVG_New_polygon($vT_markerStart; "5,1 1,3 5,5")
						DOM SET XML ATTRIBUTE:C866($vT_object; "marker-start"; "url(#"+$vT_markerStartId+")")
						
						If (Length:C16($vT_fillOpacity)#0)
							DOM SET XML ATTRIBUTE:C866($vT_markerStart; "fill-opacity"; $vT_fillOpacity)
						End if 
						
					End if 
					If ($vT_markerEnd#$vT_xml_null)
						$vT_markerEndId:=$vT_object+".marker.end"
						$vT_markerEnd:=SVG_Define_marker($vT_svg; $vT_markerEndId; 1; 3; 6; 6)
						DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "orient"; "auto"; "fill"; $vT_fillColor; "id"; $vT_markerEndId)
						$vT_path:=SVG_New_polygon($vT_markerEnd; "1,1 1,5 5,3")
						DOM SET XML ATTRIBUTE:C866($vT_object; "marker-end"; "url(#"+$vT_markerEndId+")")
						
						If (Length:C16($vT_fillOpacity)#0)
							DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "fill-opacity"; $vT_fillOpacity)
						End if 
						
					End if 
				End if 
				
			: ($vT_objectType="textArea")
				ARRAY LONGINT:C221($aL_nodeType; 0)
				ARRAY TEXT:C222($aT_nodeData; 0)
				DOM GET XML CHILD NODES:C1081($vT_idx_currentObjects; $aL_nodeType; $aT_nodeData)
				
				var $vL_nodes : Integer
				var $vT_nodeName : Text
				
				$vL_t:=0
				
				For ($vL_nodes; 1; Size of array:C274($aL_nodeType))
					Case of 
						: ($aL_nodeType{$vL_nodes}=XML DATA:K45:12)
							If ($vL_t=0)
								DOM SET XML ELEMENT VALUE:C868($vT_object; $aT_nodeData{$vL_nodes})
								$vL_t:=1
							Else 
								var $vT_append; $vT_tbreak : Text
								$vT_append:=DOM Append XML child node:C1080($vT_object; XML DATA:K45:12; $aT_nodeData{$vL_nodes})
							End if 
						: ($aL_nodeType{$vL_nodes}=XML ELEMENT:K45:20)
							DOM GET XML ELEMENT NAME:C730($aT_nodeData{$vL_nodes}; $vT_nodeName)
							If ($vT_nodeName="tbreak")
								$vT_tbreak:=DOM Create XML element:C865($vT_object; "tbreak")
							End if 
					End case 
				End for 
		End case 
	End for 
	
	var $vX_svgData : Blob
	var $vO_svgImage : Picture
	DOM EXPORT TO VAR:C863($vT_svg; $vX_svgData)
	SVG EXPORT TO PICTURE:C1017($vT_svg; $vO_svgImage)
	SET PICTURE TO PASTEBOARD:C521($vO_svgImage)
	APPEND DATA TO PASTEBOARD:C403("private.4d.svg.data"; $vX_svgData)
	DOM CLOSE XML:C722($vT_svg)
	$isOk:=True:C214
End if 

$0:=$isOk

