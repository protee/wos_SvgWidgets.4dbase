//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x__write_external
//
// Parameter Type Description
//
//
// Description:
// Write Form.[prop] to external value in case of valid pointer
// - valid pointer ptr_ext
// - valid ob_ext and prop_ext
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.

var $vT_prop; $vT_prop_ext : Text
var $vP__ext : Pointer
var $vJ_ext : Object

$vT_prop:=Form:C1466.prop
If ($vT_prop#Null:C1517)
	$vP__ext:=Form:C1466.ptr_ext
	If ($vP__ext#Null:C1517)
		$vP__ext->:=OB Get:C1224(Form:C1466; $vT_prop)
	Else 
		$vJ_ext:=Form:C1466.ob_ext
		$vT_prop_ext:=Form:C1466.prop_ext
		If ($vJ_ext#Null:C1517)
			OB SET:C1220($vJ_ext; $vT_prop_ext; OB Get:C1224(Form:C1466; $vT_prop))
		End if 
	End if 
End if 




