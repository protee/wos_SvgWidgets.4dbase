//%attributes = {}
// Project Method: x__storage_at_lbl_push
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 05/08/2022   OG   Initial version.

var $vJ_menu : Object
$vJ_menu:=$1

// TODO manage add to existing if exists

var $vC_aT_lbl : Collection
var $i; $vL_count : Integer
$vL_count:=Count parameters:C259
$vC_aT_lbl:=New collection:C1472
For ($i; 2; $vL_count)
	$vC_aT_lbl.push(${$i})
End for 
$vJ_menu.at_lbl:=$vC_aT_lbl

