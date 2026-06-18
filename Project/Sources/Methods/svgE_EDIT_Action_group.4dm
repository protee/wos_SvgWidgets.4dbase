//%attributes = {"invisible":true,"lang":"en"}

var $vT_action : Text
$vT_action:=$1

Case of 
	: ($vT_action="group")
		
	: ($vT_action="ungroup")
		
	Else 
		ALERT:C41($vT_action)
		
End case 





