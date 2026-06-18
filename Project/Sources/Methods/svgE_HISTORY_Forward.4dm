//%attributes = {"invisible":true,"lang":"en"}

var $vJ_history : Object
var $vP_null : Pointer
svgE_getStuff_vJ($vP_null; $vP_null; ->$vJ_history)
var $vL_historyIndex : Integer
$vL_historyIndex:=$vJ_history.l_index

var $vP_T_historyList : Pointer
$vP_T_historyList:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_historyList")

If (($vL_historyIndex)<Size of array:C274($vP_T_historyList->))
	$vL_historyIndex:=$vL_historyIndex+1
	$vJ_history.l_index:=$vL_historyIndex
	Form:C1466.is_modified:=($vL_historyIndex>1)
	svgE_HISTORY_Restore
End if 

