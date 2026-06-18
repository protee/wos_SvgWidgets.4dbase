//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vL_bit_license : Integer)->$txt : Text
If (Count parameters:C259<1)
	$vL_bit_license:=-1
End if 

$txt:=wok_check_trial_module_text(wos__storage_prefs; $vL_bit_license)

