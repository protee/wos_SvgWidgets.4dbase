//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Project method : DOM_ELEMENT_MOVE
// Database: 4D Labels
// ID[07D651BFFA02417CB8E1341C163E334C]
// Created #25-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
var $2 : Integer

var $vT_dom_new; $vT_dom_node; $vT_dom_parent : Text

$vT_dom_node:=$1
var $vL_level_count; $vL_level_new; $vL_level_old : Integer
$vL_level_old:=$2
$vL_level_new:=$3
$vL_level_count:=$4  // Needed, as if Insert without an element => put at begin :-(

//Optional parameters
//$count_parameters:=Count parameters
//If ($count_parameters>=2)
//$level:=$2
//End if 

var $is_up : Boolean
var $vL_count_items_back : Integer
$is_up:=($vL_level_new>$vL_level_old)
$vL_count_items_back:=wos__storage_stuff.l_count_items_back+1
$vL_level_new:=$vL_level_new+$vL_count_items_back+Num:C11($is_up)
$vL_level_count:=$vL_level_count+$vL_count_items_back
If ($vL_level_new>$vL_level_count)  //&$is_up
	$vL_level_new:=0  // append at the end (else is at begin)
End if 
// ----------------------------------------------------
$vT_dom_parent:=DOM Get parent XML element:C923($vT_dom_node)
//svgE_DOM_ELEMENT_CLEAR_ID ($Dom_node)
If ($vL_level_new>0)
	//move to given level
	$vT_dom_new:=DOM Insert XML element:C1083($vT_dom_parent; $vT_dom_node; $vL_level_new)
	DOM SET XML ATTRIBUTE:C866($vT_dom_new; "id"; $vT_dom_new)
Else 
	//move to last level
	$vT_dom_new:=DOM Append XML element:C1082($vT_dom_parent; $vT_dom_node)
	DOM SET XML ATTRIBUTE:C866($vT_dom_new; "id"; $vT_dom_new)
End if 
DOM REMOVE XML ELEMENT:C869($vT_dom_node)
//svgE_DOM_ELEMENT_RESTORE_ID ($Dom_new)
$0:=$vT_dom_new

