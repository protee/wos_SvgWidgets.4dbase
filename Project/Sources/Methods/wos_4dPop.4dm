//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_4DPop
//
// Parameter Type Description
// $1 PTR for compatibility only
//
// Description:
// 4DPop access
//
// Date        Init  Description
// ===================================================================
// 01/03/2021   OG   Initial version.


#DECLARE($vP : Pointer)
//For 4DPop compatibility

wos_initRegister  // Licence key
$vJ_prefs:=wos__storage_prefs

// To protect from people getting the component from a compiled product
// Wrong key => all in non editable mode after a 30 minutes trial.

var $vT_menu : Text
$vT_menu:=""
var $isOk : Boolean
var $vT_subPath_icons; $vT_title; $vT_answerMenu : Text
$vT_subPath_icons:="main/icn_"
var $vC_menu; $vC_at_menu : Collection
$vC_menu:=x_4dPop_get_menu_vC()
var $vJ_prefs : Object
$vT_title:=$vJ_prefs.t_name+" "+$vJ_prefs.t_version
$isOk:=x_4dPop_menu(On Clicked:K2:4; ->$vT_answerMenu; Null:C1517; $vT_subPath_icons; $vC_menu; $vJ_prefs)
If ($isOk)
	$vC_at_menu:=Split string:C1554($vT_answerMenu; ".")
	x_4Dpop_execute($vC_at_menu)
End if 

