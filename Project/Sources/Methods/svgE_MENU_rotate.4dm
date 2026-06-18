//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_ROTATE
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 02/03/2021   OG   Initial version.

// Project Method: svgE_MENU_ZOOM
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 02/03/2021   OG   Initial version.

#DECLARE($vT_refMenu : Text; $vJ_widget : Object)->$vT_refMenu_answer : Text

var $vL_rotate_current : Integer
$vL_rotate_current:=$vJ_widget.l_value


ARRAY LONGINT:C221($aL_aT_rotate; 0)
APPEND TO ARRAY:C911($aL_aT_rotate; 0)
APPEND TO ARRAY:C911($aL_aT_rotate; 90)
APPEND TO ARRAY:C911($aL_aT_rotate; 180)
APPEND TO ARRAY:C911($aL_aT_rotate; 270)

var $i; $vL_rotate; $tt : Integer
var $vT_path_icons; $vT_rotate : Text
$vT_path_icons:=""
$vT_refMenu_answer:=Create menu:C408
$tt:=Size of array:C274($aL_aT_rotate)
For ($i; 1; $tt)
	$vL_rotate:=$aL_aT_rotate{$i}
	$vT_rotate:=String:C10($vL_rotate)
	APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_rotate+"°")
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+$vT_rotate+".png")
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "rotate-"+$vT_rotate)
	If ($vL_rotate=$vL_rotate_current)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
	
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Rotate"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

