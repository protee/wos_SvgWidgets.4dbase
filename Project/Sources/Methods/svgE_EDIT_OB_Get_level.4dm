//%attributes = {"invisible":true,"lang":"en"}


var $0 : Integer
var $1 : Text

var $vT_txt_ID : Text
var $vP__T_item_ids : Pointer
$vT_txt_ID:=$1
$vP__T_item_ids:=$2

var $k : Integer
$k:=Find in array:C230($vP__T_item_ids->; $vT_txt_ID)
$0:=$k



//C_LONGINT($Lon_level)
//ARRAY LONGINT($tLon_length;0)
//ARRAY LONGINT($tLon_position;0)

//If (Match regex("object-([\\d]+)";$Txt_ID;1;$tLon_position;$tLon_length))
//$Lon_level:=Num(Substring($Txt_ID;$tLon_position{1};$tLon_length{1}))
//End if 

//$0:=$Lon_level

//  // object-([\d]+)

