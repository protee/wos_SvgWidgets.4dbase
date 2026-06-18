//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __compiler_init
//
// Parameter Type Description
//
//
// Description:
// Main variables initializations
//
// Date        Init  Description
// ===================================================================
// 23/12/2023   OG   Compatible with 4DPop v20


// *****
// *
var $vJ_prefs : Object
var $cs__wox_menu : cs:C1710._wox_menu
$vJ_prefs:=wos__storage_prefs

Use ($vJ_prefs)
	$vJ_prefs.t_name:="wos_SvgWidgets"
	$vJ_prefs.t_app:="wos"  // For ogMake also ↴
	$vJ_prefs.t_version:="21.0.00"
	// For wom_Krolific only ↴
	$vJ_prefs.fo_rsc:=Folder:C1567(fk resources folder:K87:11)
	
	//$vJ_prefs.cs_wox_menu:=cs._wox_menu
	$cs__wox_menu:=cs:C1710._wox_menu.new()  // A "kind" of singleton !!
	$vJ_prefs.cs_wox_menu:=OB Copy:C1225($cs__wox_menu; ck shared:K85:29; $vJ_prefs)
	
	// For ogMake only ↴
	$vJ_prefs.l_make:=1  // Component
	$vJ_prefs.t_host_name:=""
	$vJ_prefs.fu_callback_init:=Formula:C1597(_wom_callback_init)
	//$vJ_prefs.fu_callback_built:=Formula(_wom_callback_built)
	
End use 

