//%attributes = {"invisible":true,"lang":"en"}

If (Is Windows:C1573)
	var $vT_types : Text
	$vT_types:=".txt;.svg"
Else 
	$vT_types:="public.svg-image"
End if 
$0:=$vT_types

