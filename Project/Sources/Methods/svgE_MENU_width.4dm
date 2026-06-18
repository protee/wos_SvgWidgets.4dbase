//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_WIDTH
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

#DECLARE($vT_refMenu : Text; $vL_width : Integer)->$vT_refMenu_answer : Text
var $i : Integer
var $vT_path_menu : Text

$vT_path_menu:="path:/RESOURCES/images/width/width"
$vT_refMenu_answer:=Create menu:C408
For ($i; 0; 9)
	APPEND MENU ITEM:C411($vT_refMenu_answer; String:C10($i)+"pt")
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "width-"+String:C10($i))
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+String:C10($i)+".svg")
	If ($vL_width=$i)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Width"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

