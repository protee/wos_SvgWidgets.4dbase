//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __resize_groups
//
// Parameter Type Description
// $1 <L> -> width of the instance
// $2 <L> -> height of the instance
// $3 <P> <- y top value
// $4 <P> <- y bottom value
//
// Description:
// Calculate yt and yb based on the group object visible or not
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.


#DECLARE($vL_width : Integer; $vL_height : Integer; $vP_vL_yt : Pointer; $vP_vL_yb : Pointer)
var $is_label : Boolean
var $vL_yt; $vL_yb : Integer
var $vT_label; $vT_objectName : Text

$vT_label:=Form:C1466.t_label
$is_label:=($vT_label#"")
$vT_objectName:="grp"
OBJECT SET VISIBLE:C603(*; $vT_objectName; $is_label)
If ($is_label)
	OBJECT SET COORDINATES:C1248(*; $vT_objectName; 0; 0; $vL_width; $vL_height)
	OBJECT SET TITLE:C194(*; $vT_objectName; $vT_label)
	$vL_yt:=18
	$vL_yb:=$vL_height-4
Else 
	$vL_yt:=4
	$vL_yb:=$vL_height-2
End if 
$vP_vL_yt->:=$vL_yt
$vP_vL_yb->:=$vL_yb

