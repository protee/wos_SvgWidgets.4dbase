//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_ALIGN
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
$vT_path_icons:="path:/RESOURCES/Images/svg_actions/align"
$vT_refMenu_answer:=Create menu:C408
// Align
APPEND MENU ITEM:C411($vT_refMenu_answer; "Align on Left")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"Left.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "align-left")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Align on Right")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"Right.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "align-right")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Align Top")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"Top.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "align-top")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Align Bottom")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"Bottom.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "align-bottom")

// Center
APPEND MENU ITEM:C411($vT_refMenu_answer; "-")
APPEND MENU ITEM:C411($vT_refMenu_answer; "Center Horizontally")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"CentreHorizontal.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "align-centerH")

APPEND MENU ITEM:C411($vT_refMenu_answer; "Center Vertically")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"CentreVertical.png")
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "align-centerV")

If ($is_toAttach)
	APPEND MENU ITEM:C411($vT_refMenu; "Align"; $vT_refMenu_answer)
	RELEASE MENU:C978($vT_refMenu_answer)
End if 

