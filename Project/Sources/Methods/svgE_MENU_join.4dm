//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_Join
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

#DECLARE($vT_refMenu : Text; $vL_join : Integer)->$vT_refMenu_answer : Text
var $vT_path_menu : Text
var $vC_lbl : Collection
var $tt; $i; $vL_idx : Integer
var $vJ_menu : Object

$vJ_menu:=wos__storage_stuff().j_menu_stroke_linejoin
$vT_path_menu:="path:/RESOURCES/"+$vJ_menu.t_icn
$vT_path_menu:="path:/RESOURCES/images/join/join"
$vT_refMenu_answer:=Create menu:C408
$vC_lbl:=$vJ_menu.at_lbl
$tt:=$vC_lbl.length
For ($i; 1; $tt)
	$vL_idx:=$i-1
	APPEND MENU ITEM:C411($vT_refMenu_answer; $vC_lbl[$vL_idx])
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "join-"+String:C10($vL_idx))
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+String:C10($vL_idx)+".svg")
	If ($vL_join=$vL_idx)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Join"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

