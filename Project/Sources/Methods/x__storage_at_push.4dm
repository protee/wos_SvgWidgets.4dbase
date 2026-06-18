//%attributes = {}
// Project Method: x__storage_at_push
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
var $vT_property : Text
$vJ_menu:=$1
$vT_property:=$2

// TODO manage add to existing if exists
var $vC_value : Collection
$vC_value:=$vJ_menu[$vT_property]
var $is_not_exist : Boolean
$is_not_exist:=($vC_value=Null:C1517)
If ($is_not_exist)
	$vC_value:=New shared collection:C1527
End if 

var $i; $vL_count : Integer
$vL_count:=Count parameters:C259
For ($i; 3; $vL_count)
	$vC_value.push(${$i})
End for 
If ($is_not_exist)
	Use ($vJ_menu)
		$vJ_menu[$vT_property]:=$vC_value
	End use 
End if 

