//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __test_svgEditor_init
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 29/03/2021   OG   Initial version.


var $vJ_storage_widgets : Object
$vJ_storage_widgets:=wos__storage_widgets

Use ($vJ_storage_widgets)
	// Default values for all new instances of svgEditor
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=$vJ_storage_widgets.j_editor
	$vJ_wos_editor.is_editing:=True:C214  // editable
	$vJ_wos_editor.is_toolsOnTop:=True:C214  // Tools on top
	$vJ_wos_editor.is_palettes:=True:C214  // Display palettes when needed
	$vJ_wos_editor.is_sticky:=False:C215  // No sticky default
End use 

