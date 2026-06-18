//%attributes = {"invisible":true,"lang":"en"}

var $vP__points; $vP__ttx; $vP__tty : Pointer
var $vR_sx; $vR_sy; $vR_r; $4; $5; $6 : Real
$vP__points:=$1
$vP__ttx:=$2
$vP__tty:=$3
$vR_sx:=$4
$vR_sy:=$5
$vR_r:=$6


var $vT_points : Text
$vT_points:=$vP__points->

ARRAY LONGINT:C221($aL_pos; 0)
ARRAY LONGINT:C221($aL_len; 0)

ARRAY REAL:C219($aR_relative_x; 0)
ARRAY REAL:C219($aR_relative_y; 0)
ARRAY REAL:C219($aR_absolute_x; 0)
ARRAY REAL:C219($aR_absolute_y; 0)
var $vL_p : Integer
$vL_p:=1
var $vR_x; $vR_y : Real
While (Match regex:C1019("(-?(?:\\d|\\.)+)[,\\s](-?(?:\\d|\\.)+)"; $vT_points; $vL_p; $aL_pos; $aL_len))
	$vR_x:=Num:C11(Substring:C12($vT_points; $aL_pos{1}; $aL_len{1}); ".")
	$vR_y:=Num:C11(Substring:C12($vT_points; $aL_pos{2}; $aL_len{2}); ".")
	APPEND TO ARRAY:C911($aR_relative_x; $vR_x)
	APPEND TO ARRAY:C911($aR_relative_y; $vR_y)
	$vL_p:=$aL_pos{2}+$aL_len{2}
End while 

COPY ARRAY:C226($aR_relative_x; $aR_absolute_x)
COPY ARRAY:C226($aR_relative_y; $aR_absolute_y)
SORT ARRAY:C229($aR_relative_x)
SORT ARRAY:C229($aR_relative_y)

var $vR_x1; $vR_x2; $vR_y1; $vR_y2 : Real
If (Size of array:C274($aR_relative_x)#0)
	$vR_x1:=$aR_relative_x{1}
	$vR_y1:=$aR_relative_y{1}
	$vR_x2:=$aR_relative_x{Size of array:C274($aR_relative_x)}
	$vR_y2:=$aR_relative_y{Size of array:C274($aR_relative_y)}
Else 
	$vR_x1:=0
	$vR_y1:=0
	$vR_x2:=0
	$vR_y2:=0
End if 

var $vR_w; $vR_h : Real
$vR_w:=Abs:C99($vR_x2-$vR_x1)
$vR_h:=Abs:C99($vR_y2-$vR_y1)
var $vL_offsetH; $vL_offsetW : Integer
$vL_offsetW:=-$vR_x1-($vR_w/2)
$vL_offsetH:=-$vR_y1-($vR_h/2)

$vT_points:=""
var $tt : Integer
$tt:=Size of array:C274($aR_absolute_x)
For ($vL_p; 1; $tt)
	$aR_absolute_x{$vL_p}:=$aR_absolute_x{$vL_p}+$vL_offsetW
	$aR_absolute_y{$vL_p}:=$aR_absolute_y{$vL_p}+$vL_offsetH
	$vT_points:=$vT_points+Replace string:C233(String:C10($aR_absolute_x{$vL_p}); ","; ".")+","+Replace string:C233(String:C10($aR_absolute_y{$vL_p}); ","; ".")+" "
End for 
//DOM SET XML ATTRIBUTE($currentObject;"points";$points)

var $vL_ccx; $vL_ccy; $ttx; $tty : Integer
$vL_ccx:=$vL_offsetW
$vL_ccy:=$vL_offsetH
//$ttx:=(Cos(($r)*Degree)*$ccx)-(Cos((90-$r)*Degree)*$ccy)
//$tty:=(Sin(($r)*Degree)*$ccx)+(Sin((90-$r)*Degree)*$ccy)
$ttx:=(Cos:C18(($vR_r)*Degree:K30:2)*($vL_ccx*$vR_sx))-(Cos:C18((90-$vR_r)*Degree:K30:2)*($vL_ccy*$vR_sy))
$tty:=(Sin:C17(($vR_r)*Degree:K30:2)*($vL_ccx*$vR_sx))+(Sin:C17((90-$vR_r)*Degree:K30:2)*($vL_ccy*$vR_sy))
$ttx:=Num:C11(String:C10($ttx))  //remove e
$tty:=Num:C11(String:C10($tty))  //remove e

$vP__points->:=$vT_points
$vP__ttx->:=$ttx
$vP__tty->:=$tty

//$tx:=$tx-$ttx
//$ty:=$ty-$tty
//svgE_OBJECT_SET_TRANSFORM ($currentObject;$tx;$ty;$sx;$sy;$r;0;0)

