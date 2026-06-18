//%attributes = {"shared":true}
//Project Method: ___test_widgets
//
//
//Description: to test all the widgets in a form
//
//
//Date        Init  Description
//===============================================================================
//01/02/2021   CR   Initial version.


var $c4Fi_pref_file : 4D:C1709.File
var $isOk : Boolean
var $vL_WinRef : Integer
var $vJ_prefs; $vJ_form : Object
var $vT_form : Text
wos_initRegister

$vT_form:="_widgets_mng"
$c4Fi_pref_file:=wos__prefs_get_c4Fi($vT_form)
$vJ_prefs:=New object:C1471
$isOk:=wox_prefs_load($c4Fi_pref_file; ->$vJ_prefs)
If (Not:C34($isOk))
	////$vJ_prefs.l_space:=k_svg_space
	//$vJ_prefs.l_selector:=0
	//$vJ_prefs.l_colors:=0
	//$vJ_prefs.is_stroke:=True
End if 

$vJ_form:=New object:C1471
$vJ_form.j_prefs:=$vJ_prefs

$vL_WinRef:=Open form window:C675($vT_form; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40($vT_form; $vJ_form)
CLOSE WINDOW:C154($vL_WinRef)
wox_prefs_save($c4Fi_pref_file; $vJ_prefs)
