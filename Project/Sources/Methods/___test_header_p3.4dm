//%attributes = {"lang":"en"}
// Project Method: ___test_header
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 22/02/2021   OG   Initial version.




__test_svgEditor_init

var $vJ_FormData : Object
$vJ_FormData:=New object:C1471

var $vT_form : Text
$vT_form:="_test_header_p3"
var $vL_WinRef : Integer
$vL_WinRef:=Open form window:C675($vT_form; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40($vT_form; $vJ_FormData)
CLOSE WINDOW:C154($vL_WinRef)






