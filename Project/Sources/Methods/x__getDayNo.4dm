//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x__getDayNo
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 10/03/2021   OG   Initial version.


var $1; $0; $vL_dayNumber : Integer

$vL_dayNumber:=$1
var $is_startOnMonday : Boolean
$is_startOnMonday:=$2

If ($is_startOnMonday)
	//for example, German
	Case of 
		: ($vL_dayNumber=0)
		: ($vL_dayNumber=7)
			$vL_dayNumber:=1  //change position off Sunday
		Else 
			$vL_dayNumber:=$vL_dayNumber+1  // change value from 7 to 2  --> 6 to 1
	End case 
	//$dayNumber:=v_dayCours_from_day($dayNumber)
End if 
$0:=$vL_dayNumber

