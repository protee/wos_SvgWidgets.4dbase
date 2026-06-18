//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_LEVEL
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
$vT_path_icons:="path:/RESOURCES/Images/svg_actions/move"
$vT_refMenu_answer:=Create menu:C408
APPEND MENU ITEM:C411($vT_refMenu_answer; "Move to Front")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"ToFront.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "level-front")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Up One Level")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"Up.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "level-up")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Down One Level")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"Down.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "level-down")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Move to Back")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"ToBack.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "level-back")

If ($is_toAttach)
	APPEND MENU ITEM:C411($vT_refMenu; "Layers"; $vT_refMenu_answer)
	RELEASE MENU:C978($vT_refMenu_answer)
End if 

