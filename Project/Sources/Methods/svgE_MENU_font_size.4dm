//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_FONT_SIZE
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

#DECLARE($vT_refMenu : Text; $vL_size_current : Integer)->$vT_refMenu_answer : Text
var $vC_col_sizes : Collection
var $vT_size_txt; $vT_col_size : Text

$vT_refMenu_answer:=Create menu:C408
$vT_size_txt:="8,9,10,11,12,13,14,16,18,20,22,24,26,28,32,36,48,72"
$vC_col_sizes:=Split string:C1554($vT_size_txt; ",")
For each ($vT_col_size; $vC_col_sizes)
	APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_col_size)
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "font-size-"+$vT_col_size)
	If ($vL_size_current=Num:C11($vT_col_size))
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
End for each 

APPEND MENU ITEM:C411($vT_refMenu; "Size"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

