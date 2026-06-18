//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_svg_rulerPicker_ob
//
// Parameter Type Description
// $1 <OBJ> Object. In and out
// $0 <BOO> True if form ACCEPT.
//
// Description:
// Will open a form with the wos_rulerPicker in it.
// The window type is defined in <>vJ_wos_main.windowType
// See documentation for the object properties.
//
// Date        Init  Description
// ===================================================================
// 18/06/2021   OG   Initial version.


#DECLARE($vJ_form : Object)->$isOk : Boolean

var $vL_window_kind : Integer
//If (Window kind=Modal dialog)
//  //Frontmost window for the current process is modal so must open the colour picker window modal also
//$window_kind:=Modal form dialog box
//Else 
//$window_kind:=x__window_type 
//End if 

//$window_kind:=Modal form dialog box
$vL_window_kind:=Pop up form window:K39:11

var $vT_form : Text
$vT_form:="wos_ruler_form"
var $vP_null : Pointer
$isOk:=x_form_xy_open_atMouse($vP_null; $vT_form; $vL_window_kind; ""; k_form_leftTop; $vJ_form)

