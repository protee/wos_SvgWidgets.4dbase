//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __resize_btns
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 17/06/2021   OG   Initial version.

#DECLARE($vL_width : Integer; $xl : Integer; $vL_yt : Integer; $vL_gap : Integer; $vC_at_lbl : Collection; $vL_mask : Integer)  // {#6} optionals 
var $is_mask; $is_enabled : Boolean
var $vL_btn_xl; $vL_btn_yt; $idx; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_w; $vL_h; $vL_btn_xr; $vL_btn_yb : Integer
var $vP : Pointer
var $vT_key : Text

$is_mask:=Count parameters:C259>=6
$is_enabled:=True:C214
$vL_btn_xl:=$xl
$vL_btn_yt:=$vL_yt
$idx:=0
For each ($vT_key; $vC_at_lbl)
	$vP:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_key)
	If ($is_mask)
		$is_enabled:=$vL_mask ?? $idx
	End if 
	If ($is_enabled)
		OBJECT GET COORDINATES:C663(*; $vT_key; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		$vL_h:=$vL_bottom-$vL_top
		$vL_btn_xr:=$vL_btn_xl+$vL_w
		If ($vL_btn_xr>=($vL_width-$vL_gap))
			$vL_btn_xl:=$xl
			$vL_btn_xr:=$vL_btn_xl+$vL_w
			$vL_btn_yt:=$vL_btn_yt+$vL_h+$vL_gap
		End if 
		$vL_btn_yb:=$vL_btn_yt+$vL_h
		//$y:=$yh-($vL_h/2)
		OBJECT SET COORDINATES:C1248(*; $vT_key; $vL_btn_xl; $vL_btn_yt; $vL_btn_xr; $vL_btn_yb)
		$vL_btn_xl:=$vL_btn_xl+$vL_w+$vL_gap
	End if 
	OBJECT SET VISIBLE:C603(*; $vT_key; $is_enabled)
	$idx+=1
End for each 

