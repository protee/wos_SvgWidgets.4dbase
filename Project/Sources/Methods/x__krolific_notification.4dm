//%attributes = {}
// Project Method: x__krolific_notification
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 16/11/2022   OG   Initial version.

#DECLARE($vL_bit_license : Integer; $vL_display : Integer)->$isOk : Boolean

If (Count parameters:C259<3)
	$vL_bit_license:=-1
End if 

$isOk:=wok_check_trial_module(wos__storage_prefs; $vL_bit_license; $vL_display)

// wok_check_notification
