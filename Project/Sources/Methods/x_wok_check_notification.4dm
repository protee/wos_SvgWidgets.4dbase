//%attributes = {}
// Project Method: x_wok_check_notification
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 18/11/2022   OG   Initial version.

#DECLARE($vL_check : Integer; $vL_display : Integer; $vL_bit_license : Integer)->$isOk : Boolean
If (Count parameters:C259<3)
	$vL_bit_license:=-1
End if 
$isOk:=wok_check_notification(wos__storage_prefs; $vL_check; $vL_display; $vL_bit_license)
