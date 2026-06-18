//%attributes = {"invisible":true,"lang":"en"}
// Project Method: xh_picLib_picture_get
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 20/05/2021   OG   Initial version.

var $vP__picture : Pointer
$vP__picture:=$1

ON ERR CALL:C155("h_onError")
Error:=0
var $vJ_picLib; $vJ_entityPic : Object
$vJ_picLib:=New object:C1471
// query="" or "all" or "id:x"
EXECUTE METHOD:C1007("wosh_picLib_callback"; *; $vJ_picLib)
ON ERR CALL:C155("")
var $isHost; $isOk : Boolean
$isHost:=(Error=0)
If ($isHost)
	$vJ_entityPic:=$vJ_picLib.entity
	$isOk:=($vJ_entityPic#Null:C1517)
	If ($isOk)
		$vP__picture->:=$vJ_entityPic.Picture
		//$defaultWidthPt:=$ob_entityPic.DefaultWidthPt
		//$defaultHeightPt:=$ob_entityPic.DefaultHeightPt
	End if 
End if 
$0:=$isHost

