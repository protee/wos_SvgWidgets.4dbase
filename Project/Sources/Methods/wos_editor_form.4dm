//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_svgEditor
//
// Parameter Type Description
// $1 <J> Object. In and out
//        svg <-> the file in out
//        windowType -> if defined, used, else default in ob_wos_main.windowType
// $0 <BOO> True if form ACCEPT.
//
// Description:
// Will open a form with the wos_svg_colourWidget in it.
// The window type is defined in <>vJ_wos_main.windowType
// See documentation for the object properties.
//
// Date        Init  Description
// ===================================================================
// 01/02/2021   OG   Initial version.

#DECLARE($vJ_form : Object)->$isOk : Boolean
var $vL_window_type : Integer
var $vP_null : Pointer
var $vT_form : Text

If (Window kind:C445=Modal dialog:K27:2)
	//Frontmost window for the current process is modal so must open the colour picker window modal also
	$vL_window_type:=Modal form dialog box:K39:7
Else 
	$vL_window_type:=x__window_type($vJ_form.windowType)
End if 

$vT_form:="wos_editor_form"
$isOk:=x_form_xy_open_atMouse($vP_null; $vT_form; $vL_window_type; "Colour"; k_form_rightBottom; $vJ_form)

