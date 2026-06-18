//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_TOOLS
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 02/03/2021   OG   Initial version.

#DECLARE($vT_refMenu : Text; $vJ_widget : Object)->$vT_refMenu_answer : Text
var $vC_lbl : Collection
var $vL_selected; $tt; $i; $vL_idx : Integer
var $vJ_menu : Object
var $vT_path_menu; $vT_name; $vT_icon : Text

$vJ_menu:=wos__storage_stuff.j_menu_tools
$vT_path_menu:="path:/RESOURCES/"+$vJ_menu.t_icn

$vT_refMenu_answer:=Create menu:C408
$vC_lbl:=$vJ_menu.at_lbl
$vL_selected:=$vC_lbl.indexOf($vJ_widget.t_value)
$tt:=$vC_lbl.length
For ($i; 1; $tt)
	$vL_idx:=$i-1
	$vT_name:=$vC_lbl[$vL_idx]
	$vT_icon:="icn_"+$vT_name+".png"
	APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_name)
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_icon)
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "tool-"+$vT_name)
	If ($vL_selected=$i)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Tools"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

