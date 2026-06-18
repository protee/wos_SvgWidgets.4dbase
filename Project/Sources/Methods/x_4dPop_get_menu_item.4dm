//%attributes = {}
// Project Method: x__get_main_menu_item
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 11/06/2022   OG   Initial version.

#DECLARE($is_valid : Boolean; $vT_label : Text; $vT_menu : Text; $c4fu_method : 4D:C1709.Function)->$vJ_menu_item : Object

$vJ_menu_item:=New object:C1471
$vJ_menu_item.is_valid:=$is_valid
$vJ_menu_item.t_label:=$vT_label
$vJ_menu_item.t_menu:=$vT_menu
$vJ_menu_item.fu_method:=$c4fu_method

