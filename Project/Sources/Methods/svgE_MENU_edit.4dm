//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_EDIT
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

// Project Method: svgE_MENU_TOOLS
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
$vT_refMenu:=$1

var $vJ_history : Object
var $vP_null : Pointer
svgE_getStuff_vJ($vP_null; $vP_null; ->$vJ_history)
var $vL_historyIndex : Integer
$vL_historyIndex:=$vJ_history.l_index
var $is_redo; $is_undo : Boolean
var $vP_T_historyList : Pointer
$is_undo:=($vL_historyIndex>=1)
$vP_T_historyList:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_historyList")
$is_redo:=($vL_historyIndex<Size of array:C274($vP_T_historyList->))

var $vL_count_selected : Integer
var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$vL_count_selected:=Size of array:C274($vP_T_currentObjects->)


ARRAY TEXT:C222($aT_labels; 0)
ARRAY BOOLEAN:C223($aB_enabled; 0)
APPEND TO ARRAY:C911($aT_labels; "Undo")
APPEND TO ARRAY:C911($aB_enabled; $is_undo)
APPEND TO ARRAY:C911($aT_labels; "Redo")
APPEND TO ARRAY:C911($aB_enabled; $is_redo)
APPEND TO ARRAY:C911($aT_labels; "-")
APPEND TO ARRAY:C911($aB_enabled; False:C215)
APPEND TO ARRAY:C911($aT_labels; "Cut")
APPEND TO ARRAY:C911($aB_enabled; ($vL_count_selected>0))
APPEND TO ARRAY:C911($aT_labels; "Copy")
APPEND TO ARRAY:C911($aB_enabled; ($vL_count_selected>0))
APPEND TO ARRAY:C911($aT_labels; "Paste")
APPEND TO ARRAY:C911($aB_enabled; True:C214)
APPEND TO ARRAY:C911($aT_labels; "Clear")
APPEND TO ARRAY:C911($aB_enabled; ($vL_count_selected>0))
APPEND TO ARRAY:C911($aT_labels; "-")
APPEND TO ARRAY:C911($aB_enabled; False:C215)
APPEND TO ARRAY:C911($aT_labels; "Select All")
APPEND TO ARRAY:C911($aB_enabled; True:C214)



var $is_enabled : Boolean
var $i; $tt : Integer
var $vT_icon; $vT_Mnu_tools; $vT_name; $vT_path_icons : Text
$vT_Mnu_tools:=Create menu:C408
$tt:=Size of array:C274($aT_labels)
$vT_path_icons:="path:/RESOURCES/images/edit/"
For ($i; 1; $tt)
	$vT_name:=$aT_labels{$i}
	$vT_icon:="icn_edit"+$vT_name+".png"
	APPEND MENU ITEM:C411($vT_Mnu_tools; $vT_name)
	SET MENU ITEM ICON:C984($vT_Mnu_tools; -1; $vT_path_icons+$vT_icon)
	SET MENU ITEM PARAMETER:C1004($vT_Mnu_tools; -1; "edit-"+$vT_name)
	$is_enabled:=$aB_enabled{$i}
	If (Not:C34($is_enabled))
		DISABLE MENU ITEM:C150($vT_Mnu_tools; -1)
	End if 
End for 

APPEND MENU ITEM:C411($vT_refMenu; "Edit"; $vT_Mnu_tools)
RELEASE MENU:C978($vT_Mnu_tools)
$0:=$vT_Mnu_tools

