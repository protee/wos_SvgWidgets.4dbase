//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vL_type : Integer)->$vL_window_type : Integer

$vL_window_type:=$vL_type
If ($vL_window_type=0)
	$vL_window_type:=wos__storage_prefs.l_window_type
End if 

