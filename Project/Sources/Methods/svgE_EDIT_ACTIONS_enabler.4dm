//%attributes = {"invisible":true,"lang":"en"}


#DECLARE($is_on_off : Boolean)  // {#1} optionals 
var $tt : Integer
var $vJ_widget : Object
var $vP_T_currentObjects : Pointer
var $vT_wos_actions : Text
$is_on_off:=Count parameters:C259>=1 ? $is_on_off : True:C214

If ($is_on_off)
	$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
	$tt:=Size of array:C274($vP_T_currentObjects->)
Else 
	$tt:=0
End if 

$vT_wos_actions:="wos_actions"
$vJ_widget:=wos_getWidget($vT_wos_actions)
$vJ_widget.l_count:=$tt
$vJ_widget.redraw()

