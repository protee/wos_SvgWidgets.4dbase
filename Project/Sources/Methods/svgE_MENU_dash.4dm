//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_Dash
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

#DECLARE($vT_refMenu : Text; $vL_dash : Integer)->$vT_refMenu_answer : Text
var $i : Integer
var $vT_path_menu : Text

$vT_refMenu_answer:=Create menu:C408
$vT_path_menu:="path:/RESOURCES/images/dash/dash"
For ($i; 0; 9)
	APPEND MENU ITEM:C411($vT_refMenu_answer; String:C10($i)+"pt")
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "dash-"+String:C10($i))
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+String:C10($i)+".svg")
	If ($vL_dash=$i)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Dash"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

