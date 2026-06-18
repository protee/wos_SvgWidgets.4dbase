//%attributes = {"invisible":true,"lang":"en"}
// Project Method: zzzz_ms
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 03/03/2021   OG   Initial version.

var $vL_start; $vL_end : Integer
ARRAY LONGINT:C221($aL_duration; 0)

$vL_start:=5  // Cadran ++
$vL_end:=15
APPEND TO ARRAY:C911($aL_duration; $vL_end-$vL_start)

$vL_start:=-5  // Cadran -+
$vL_end:=5
APPEND TO ARRAY:C911($aL_duration; $vL_end-$vL_start)

$vL_start:=-15  // Cadran --
$vL_end:=-5
APPEND TO ARRAY:C911($aL_duration; $vL_end-$vL_start)

$vL_start:=0x7FFFFFFC  // Cadran +-
$vL_end:=$vL_start+10  // Ici cela déborde en 0x80000006
APPEND TO ARRAY:C911($aL_duration; $vL_end-$vL_start)  // Mais toujours 10!






