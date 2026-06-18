//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vL_bit_license : Integer)
If (Count parameters:C259<1)
	$vL_bit_license:=-1
End if 

var $vP : Pointer
$vP:=OBJECT Get pointer:C1124(Object named:K67:5; "trial_txt")
$vP->:=wok_check_trial_module_text(wos__storage_prefs; $vL_bit_license)

