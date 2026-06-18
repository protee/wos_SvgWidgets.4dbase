//%attributes = {"invisible":true,"lang":"en"}

var $vJ_history : Object
var $vP_null : Pointer
svgE_getStuff_vJ($vP_null; $vP_null; ->$vJ_history)
var $vP_T_canvasHistoryList : Pointer
$vP_T_canvasHistoryList:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_historyList")
var $vL_historyIndex : Integer
$vL_historyIndex:=$vJ_history.l_index

If (($vL_historyIndex)<=Size of array:C274($vP_T_canvasHistoryList->))
	If (($vL_historyIndex)>=1)
		$vL_historyIndex:=$vL_historyIndex-1
		$vJ_history.l_index:=$vL_historyIndex
		svgE_HISTORY_Restore
		Form:C1466.is_modified:=($vL_historyIndex>1)
	End if 
End if 

