//%attributes = {"invisible":true,"lang":"en"}
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

var $vT_refMenu : Text
var $vJ_widget : Object
$vT_refMenu:=$1
$vJ_widget:=$2

var $vJ_canvas : Object
var $vL_zoom_current : Integer
svgE_getStuff_vJ(->$vJ_canvas)
$vL_zoom_current:=$vJ_widget.l_zoom

ARRAY LONGINT:C221($aL_aT_zoom; 0)
APPEND TO ARRAY:C911($aL_aT_zoom; 50)
APPEND TO ARRAY:C911($aL_aT_zoom; 100)
APPEND TO ARRAY:C911($aL_aT_zoom; 150)
APPEND TO ARRAY:C911($aL_aT_zoom; 200)

var $i; $tt; $vL_zoom : Integer
var $vT_path_icons; $vT_refMenu_zoom; $vT_zoom : Text
$vT_path_icons:=""
$vT_refMenu_zoom:=Create menu:C408
$tt:=Size of array:C274($aL_aT_zoom)
For ($i; 1; $tt)
	$vL_zoom:=$aL_aT_zoom{$i}
	$vT_zoom:=String:C10($vL_zoom)
	APPEND MENU ITEM:C411($vT_refMenu_zoom; $vT_zoom+"%")
	SET MENU ITEM ICON:C984($vT_refMenu_zoom; -1; $vT_path_icons+$vT_zoom+".png")
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_zoom; -1; "zoom-"+$vT_zoom)
	If ($vL_zoom=$vL_zoom_current)
		SET MENU ITEM MARK:C208($vT_refMenu_zoom; -1; Char:C90(18))
	End if 
	
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Zoom"; $vT_refMenu_zoom)
RELEASE MENU:C978($vT_refMenu_zoom)
$0:=$vT_refMenu_zoom

