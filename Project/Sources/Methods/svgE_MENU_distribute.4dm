//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_distribute
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

#DECLARE($vT_refMenu : Text)->$vT_refMenu_answer : Text  // {#1} optionals 
var $is_toAttach : Boolean
var $vT_path_icons : Text

$is_toAttach:=($vT_refMenu#"")
$vT_path_icons:="path:/RESOURCES/Images/svg_actions/distribute"
$vT_refMenu_answer:=Create menu:C408
APPEND MENU ITEM:C411($vT_refMenu_answer; "Distribute Horizontally")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"H.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "distribute-H")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Distribute Vertically")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"V.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "distribute-V")

If ($is_toAttach)
	APPEND MENU ITEM:C411($vT_refMenu; "Distribute"; $vT_refMenu_answer)
	RELEASE MENU:C978($vT_refMenu_answer)
End if 

