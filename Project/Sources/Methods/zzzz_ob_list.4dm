//%attributes = {"invisible":true,"lang":"en"}

var $vJ_widget : Object
$vJ_widget:=wos__storage_prefs

ARRAY TEXT:C222($aT_properties; 0)
OB GET PROPERTY NAMES:C1232($vJ_widget; $aT_properties)
SORT ARRAY:C229($aT_properties)
var $i; $tt : Integer
var $txt : Text
$txt:=""
$tt:=Size of array:C274($aT_properties)
For ($i; 1; $tt)
	If ($txt#"")
		$txt:=$txt+Char:C90(Carriage return:K15:38)
	End if 
	$txt:=$txt+$aT_properties{$i}
End for 

SET TEXT TO PASTEBOARD:C523($txt)

