//%attributes = {"lang":"en"}
//Project Method: ___test_widgets
//
//
//Description: to test all the widgets in a form
//
//
//Date        Init  Description
//===============================================================================
//01/02/2021   CR   Initial version.


wos_initRegister
var $vJ_FormData : Object
var $vL_WinRef : Integer

$vJ_FormData:=New object:C1471

var $vT_form : Text
$vT_form:="_test_widgets"
$vL_WinRef:=Open form window:C675($vT_form; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40($vT_form; $vJ_FormData)
CLOSE WINDOW:C154($vL_WinRef)

