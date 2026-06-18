//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_currentObject : Text
$vT_currentObject:=$1

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentObject)#0)
	var $vT_rect : Text
	$vT_rect:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".select")
	If ($vT_rect#$vT_xml_null)
		DOM REMOVE XML ELEMENT:C869($vT_rect)
		$isOk:=True:C214
	End if 
	
	ARRAY TEXT:C222($aT_handles; 8)
	$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".tl")
	$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".tm")
	$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".tr")
	$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".ml")
	$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".mr")
	$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".bl")
	$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".bm")
	$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".br")
	
	var $vL_h : Integer
	For ($vL_h; 1; 8)
		If ($aT_handles{$vL_h}#$vT_xml_null)
			DOM REMOVE XML ELEMENT:C869($aT_handles{$vL_h})
			$isOk:=True:C214
		End if 
	End for 
	
End if 

$0:=$isOk

