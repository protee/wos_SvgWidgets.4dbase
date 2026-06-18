//%attributes = {"invisible":true,"lang":"en"}

var $vT_currentObject : Text
$vT_currentObject:=$1


var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vL_countAttributes; $i : Integer

$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject)
ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)

For ($i; 1; $vL_countAttributes)
	DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject; $i; $aT_attributeNames{$i}; $aT_attributeValues{$i})
End for 

var $vT_fillColor : Text
If (Find in array:C230($aT_attributeNames; "stroke-opacity")#-1)
	var $vT_fillOpacity : Text
	DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "stroke-opacity"; $vT_fillOpacity)
End if 

If (Find in array:C230($aT_attributeNames; "stroke")#-1)
	DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "stroke"; $vT_fillColor)
	If (Find in array:C230($aT_attributeNames; "marker-start")#-1)
		var $vT_markerStart; $vT_markerStartId; $vT_path : Text
		$vT_markerStartId:=$vT_currentObject+".marker.start"
		$vT_markerStart:=SVG_Define_marker($vT_domRef; $vT_markerStartId; 5; 3; 6; 6)
		DOM SET XML ATTRIBUTE:C866($vT_markerStart; "orient"; "auto"; "fill"; $vT_fillColor; "id"; $vT_markerStartId)
		$vT_path:=SVG_New_polygon($vT_markerStart; "5,1 1,3 5,5")
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-start"; "url(#"+$vT_markerStartId+")")
		If (Length:C16($vT_fillOpacity)#0)
			DOM SET XML ATTRIBUTE:C866($vT_markerStart; "fill-opacity"; $vT_fillOpacity)
		End if 
	End if 
	
	If (Find in array:C230($aT_attributeNames; "marker-end")#-1)
		var $vT_markerEnd; $vT_markerEndId : Text
		$vT_markerEndId:=$vT_currentObject+".marker.end"
		$vT_markerEnd:=SVG_Define_marker($vT_domRef; $vT_markerEndId; 1; 3; 6; 6)
		DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "orient"; "auto"; "fill"; $vT_fillColor; "id"; $vT_markerEndId)
		$vT_path:=SVG_New_polygon($vT_markerEnd; "1,1 1,5 5,3")
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-end"; "url(#"+$vT_markerEndId+")")
		If (Length:C16($vT_fillOpacity)#0)
			DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "fill-opacity"; $vT_fillOpacity)
		End if 
	End if 
End if 

