//%attributes = {"lang":"en"}

var $isOk; $is_edit : Boolean
var $vJ_cs_wox_link; $vJ_prefs; $vJ_wox_prefs : Object
var $vT_prefix; $vT_path_menu; $vT_refMenu; $vT_prefix_host : Text
var $vT_answerMenu; $vT_action; $vT_param; $vT_version_last : Text
var $vC_answer : Collection

$vT_prefix:="test"
$vT_path_menu:="path:/RESOURCES/icons/icn_"
$vT_refMenu:=Create menu:C408
$vJ_prefs:=wos__storage_prefs()

$vT_prefix:="home"
$vT_prefix_host:="host"
wox_4dPop_menu_header($vT_prefix; $vJ_prefs; $vT_refMenu)

// ***** External Host menu
// *
$vJ_cs_wox_link:=$vJ_prefs.cs_wox_link
If ($vJ_cs_wox_link#Null:C1517)
	$vJ_cs_wox_link.getMenu($vT_prefix_host+"."; $vT_refMenu)
End if 
// *
// *****

//$vT_refMenu:=This.actions_menu($vT_prefix)
$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
RELEASE MENU:C978($vT_refMenu)
$isOk:=(""#$vT_answerMenu)
If ($isOk)
	$vC_answer:=Split string:C1554($vT_answerMenu; ".")
	$vT_action:=$vC_answer[0]
	$vT_param:=$vC_answer[1]
	Case of 
		: ($vT_action=$vT_prefix)
			$vJ_wox_prefs:=wox__storage_prefs
			Case of 
				: ($vT_param="releases_notes")
					$is_edit:=Not:C34(Is compiled mode:C492) && Not:C34(Shift down:C543)
					$vJ_wox_prefs.fu_release_notes($vJ_prefs; $is_edit; $vT_version_last)
					
				: ($vT_param="agreement")
					$is_edit:=Not:C34(Is compiled mode:C492) && Not:C34(Shift down:C543)
					$vJ_wox_prefs.fu_agreement($vJ_prefs; $is_edit; $vT_version_last)
					
			End case 
			
			// ***** External Host menu
			// *
		: ($vT_action=($vT_prefix_host+"@"))
			$vJ_cs_wox_link:=$vJ_prefs.cs_wox_link
			//$vJ_cs_translt_menu:=This._cs_translt_menu
			If ($vJ_cs_wox_link#Null:C1517)
				$isOk:=$vJ_cs_wox_link.doMenu($vT_param)
			End if 
			// *
			// *****
	End case 
End if 
