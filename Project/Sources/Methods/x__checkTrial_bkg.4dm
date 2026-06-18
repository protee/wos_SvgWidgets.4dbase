//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vL_bit_license : Integer)->$isOk : Boolean
If (Count parameters:C259<1)
	$vL_bit_license:=-1
End if 

$isOk:=wok_check_trial_module_bkg(wos__storage_prefs; $vL_bit_license)
// SAME:
//$isOk:=wok_check_notification(wox__storage_license; k_wok_check_demoTrial; k_wok_display_none)
