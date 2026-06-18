//%attributes = {}
// Project Method: x__get_main_menu
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 04/11/2022   OG   Initial version.

#DECLARE($is_in_palette : Boolean)->$vC_main_menu : Collection

var $is_ogDev : Boolean
$is_ogDev:=Macintosh command down:C546 | Macintosh control down:C544

$vC_main_menu:=New collection:C1472
$vC_main_menu.push(x_4dPop_get_menu_item(True:C214; "wos_editor"; "svgEditor"))
//$vC_main_menu.push(x__get_main_menu_item)
//$vC_main_menu.push(x__get_main_menu_item(True; "DBs Explorer"; "dbs_explorer"))
