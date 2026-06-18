//%attributes = {"invisible":true,"lang":"en"}
// Project Method: p_wos_svgEditor
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 01/03/2021   OG   Initial version.

var $isOk : Boolean
var $vL_paper_width; $vL_paper_height : Integer
var $vJ_form; $vJ_path; $vJ_file; $vJ_file_source : Object
var $vR_coef : Real
var $vT_file_name; $vT_file_path : Text
$vJ_form:=New object:C1471
//$ob.is_editing:=true
$vJ_form.is_toolsOnTop:=True:C214
$vJ_form.is_palettes:=True:C214
$vJ_form.is_palettesOnTop:=True:C214

$vJ_form.is_sticky:=True:C214

$vJ_form.is_cap:=True:C214
$vJ_form.is_marker:=True:C214
$vJ_form.is_join:=True:C214


$vJ_form.j_paper:=New object:C1471
$vJ_form.j_margin:=New object:C1471
//$vJ_form.reserved:=New object

$vR_coef:=1  //2.9
$vJ_form.windowType:=0  //Plain form window

//$paper_width:=210*$coef
//$paper_height:=120*$coef
$vL_paper_width:=600*$vR_coef
$vL_paper_height:=600*$vR_coef
wos_svgEdit_paper_calculate($vJ_form; $vL_paper_width; $vL_paper_height; 0.01; 1)

$vJ_path:=wos__prefs_get_c4Fo()
$vT_file_name:="ogSvgEditor.svg"
$vJ_file:=$vJ_path.file($vT_file_name)
If (Not:C34($vJ_file.exists))
	$vJ_path.create()
	$vJ_file_source:=Folder:C1567(fk resources folder:K87:11).folder("TestData").file($vT_file_name)
	$vJ_file_source.copyTo($vJ_path)
End if 
$vJ_form.t_svg:=$vJ_file.getText()

$isOk:=wos_editor_form($vJ_form)
If ($isOk)
	TEXT TO DOCUMENT:C1237($vT_file_path; $vJ_form.t_svg)
End if 

