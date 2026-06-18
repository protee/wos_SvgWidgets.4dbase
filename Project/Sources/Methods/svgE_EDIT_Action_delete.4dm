//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $isOk : Boolean
$isOk:=False:C215

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

var $tt : Integer
var $vT_markerStartId : Text
$tt:=Size of array:C274($vP_T_currentObjects->)
If ($tt#0)
	$isOk:=True:C214
	var $i : Integer
	var $vT_objectType : Text
	For ($i; 1; $tt)
		DOM GET XML ELEMENT NAME:C730($vP_T_currentObjects->{$i}; $vT_objectType)
		//remove markers, if line or polyline
		Case of 
			: ($vT_objectType="line") | ($vT_objectType="polyline")
				$vT_markerStartId:=$vP_T_currentObjects->{$i}+".marker.start"
				var $vT_markerEnd; $vT_markerEndId; $vT_markerStart : Text
				$vT_markerStart:=DOM Find XML element by ID:C1010($vP_T_currentObjects->{$i}; $vT_markerStartId)
				$vT_markerEndId:=$vP_T_currentObjects->{$i}+".marker.end"
				$vT_markerEnd:=DOM Find XML element by ID:C1010($vP_T_currentObjects->{$i}; $vT_markerEndId)
				If ($vT_markerStart#$vT_xml_null)
					DOM REMOVE XML ELEMENT:C869($vT_markerStart)
				End if 
				If ($vT_markerEnd#$vT_xml_null)
					DOM REMOVE XML ELEMENT:C869($vT_markerEnd)
				End if 
		End case 
		//remove object
		DOM REMOVE XML ELEMENT:C869($vP_T_currentObjects->{$i})
	End for 
End if 

$0:=$isOk

