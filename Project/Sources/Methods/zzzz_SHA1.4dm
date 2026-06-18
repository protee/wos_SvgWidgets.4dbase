//%attributes = {"invisible":true,"lang":"en"}

var $vT_serial : Text
$vT_serial:=Request:C163("Key?")
If ($vT_serial#"")
	var $vT_digest : Text
	$vT_digest:=Generate digest:C1147($vT_serial; SHA1 digest:K66:2)
	CONFIRM:C162($vT_digest; "Copy"; "Cancel")
	If (OK=1)
		SET TEXT TO PASTEBOARD:C523($vT_digest)
	End if 
End if 

