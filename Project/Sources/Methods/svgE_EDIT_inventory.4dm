//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_EDIT_inventory
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

var $vP__is_text; $vP__is_line; $vP__is_rect; $vP__is_circle; $vP__is_polyline; $vP__is_image : Pointer
$vP__is_text:=$1
$vP__is_line:=$2
$vP__is_rect:=$3
$vP__is_circle:=$4
$vP__is_polyline:=$5
$vP__is_image:=$6


var $i; $tt : Integer
var $vP_aT_currentObjects : Pointer
$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$tt:=Size of array:C274($vP_aT_currentObjects->)
ARRAY TEXT:C222($aT_item_names; 0)
var $vT_objectType : Text
For ($i; 1; $tt)
	DOM GET XML ELEMENT NAME:C730($vP_aT_currentObjects->{$i}; $vT_objectType)
	APPEND TO ARRAY:C911($aT_item_names; $vT_objectType)
End for 

var $is_circle; $is_image; $is_line; $is_polyline; $is_rect; $is_text : Boolean
$is_text:=(Find in array:C230($aT_item_names; "textArea")>0)
$is_line:=(Find in array:C230($aT_item_names; "line")>0)
$is_rect:=(Find in array:C230($aT_item_names; "rect")>0)
$is_circle:=(Find in array:C230($aT_item_names; "circle")>0)
$is_circle:=$is_circle | (Find in array:C230($aT_item_names; "ellipse")>0)
$is_polyline:=(Find in array:C230($aT_item_names; "polyline")>0)
$is_image:=(Find in array:C230($aT_item_names; "image")>0)

$vP__is_text->:=$is_text
$vP__is_line->:=$is_line
$vP__is_rect->:=$is_rect
$vP__is_circle->:=$is_circle
$vP__is_polyline->:=$is_polyline
$vP__is_image->:=$is_image

$0:=$tt

