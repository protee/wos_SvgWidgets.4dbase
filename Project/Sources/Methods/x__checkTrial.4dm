//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vL_bit_license : Integer; $vL_display : Integer)->$isOk : Boolean
If (Count parameters:C259<1)
	$vL_bit_license:=-1
End if 
If (Count parameters:C259<2)
	$vL_display:=k_wok_display_confirm
End if 

//$isOk:=wok_check_trial_module(wox__storage_license; $vL_bit_license; $vL_display)
$isOk:=wok_check_notification(wos__storage_prefs; k_wok_check_demoTrial_all; $vL_display; $vL_bit_license)

