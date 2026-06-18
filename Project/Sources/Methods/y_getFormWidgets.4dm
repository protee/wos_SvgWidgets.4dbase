//%attributes = {"invisible":true,"lang":"en"}

var $vP__T_widgets_name; $vP__T_widgets_ptr : Pointer
$vP__T_widgets_name:=$1
$vP__T_widgets_ptr:=$2

ARRAY TEXT:C222($aT_objects_name; 0)
ARRAY POINTER:C280($aP_objects_ptr; 0)
ARRAY LONGINT:C221($aL_objects_page; 0)
FORM GET OBJECTS:C898($aT_objects_name; $aP_objects_ptr; $aL_objects_page; Form all pages:K67:7)

var $vL_current_page; $vL_line; $tt; $vL_widget_page : Integer
var $vP_widget_ptr : Pointer
var $vT_widget_name : Text
$tt:=Size of array:C274($aT_objects_name)
$vL_current_page:=FORM Get current page:C276
For ($vL_line; 1; $tt)
	$vT_widget_name:=$aT_objects_name{$vL_line}
	If ($vT_widget_name="wos_@")
		$vL_widget_page:=$aL_objects_page{$vL_line}
		If ($vL_widget_page=$vL_current_page)
			$vP_widget_ptr:=$aP_objects_ptr{$vL_line}
			APPEND TO ARRAY:C911($vP__T_widgets_name->; $vT_widget_name)
			APPEND TO ARRAY:C911($vP__T_widgets_ptr->; $vP_widget_ptr)
		End if 
	End if 
End for 
SORT ARRAY:C229($vP__T_widgets_name->; $vP__T_widgets_ptr->)

