//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vC_at_menu : Collection)
var $is_param : Boolean
var $vL_no_process : Integer
var $vT_method_name; $vT_menu; $vT_param : Text

//$vT_menu:=$vC_at_menu[0]
$vT_menu:=$vC_at_menu.shift()
If ($vT_menu="woxPop")
	wox_4Dpop_execute($vC_at_menu)
	
Else 
	$vT_param:=$vC_at_menu.length>=1 ? $vC_at_menu[0] : ""
	$vT_method_name:="wosm_"+$vT_menu
	$vL_no_process:=Process number:C372("$"+$vT_method_name)
	If ($vL_no_process=0)
		$is_param:=$vT_param#""
		If ($is_param)
			BRING TO FRONT:C326(New process:C317($vT_method_name; 0; "$"+$vT_method_name; $vT_param; *))
		Else 
			BRING TO FRONT:C326(New process:C317($vT_method_name; 0; "$"+$vT_method_name; *))
		End if 
	Else 
		BRING TO FRONT:C326($vL_no_process)
	End if 
End if 

