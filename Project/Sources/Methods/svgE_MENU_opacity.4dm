//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_OPACITY
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 03/03/2021   OG   Initial version.

#DECLARE($vL_opacity : Integer; $vT_mode : Text; $vT_refMenu : Text)->$vT_refMenu_answer : Text
var $is_toAttach : Boolean
var $i : Integer
var $vT_prefix; $vT_path_menu : Text

$is_toAttach:=($vT_refMenu#"")
$vT_prefix:=(($vT_mode="stroke") || ($vT_mode="font")) ? "stroke" : "fill"

$vT_path_menu:="path:/RESOURCES/images/opacity/"
$vT_refMenu_answer:=Create menu:C408
For ($i; 0; 100; 10)
	APPEND MENU ITEM:C411($vT_refMenu_answer; String:C10($i)+"%")
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_mode+"-opacity-"+String:C10($i))
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_prefix+"-opacity-"+String:C10($i)+".svg")
	
	Case of 
		: ($i=0) && ($vL_opacity=0)
			SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
			
		: ($i=$vL_opacity)
			SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
			
	End case 
End for 

If ($is_toAttach)
	APPEND MENU ITEM:C411($vT_refMenu; "Opacity"; $vT_refMenu_answer)
	RELEASE MENU:C978($vT_refMenu_answer)
End if 

