//%attributes = {"shared":true,"lang":"en"}
// Project Method: 
//
// Parameter Type Description
// $0 <OBJ> The main object for all parameters, widgets, pickers...
//
// Description:
// 
//
// Date        Init  Description
// ===============================================================================
// 01/02/2021   OG   Initial version.


#DECLARE($vT_widget : Text)->$vJ_widgets : Object

$vJ_widgets:=Storage:C1525.j_widgets
If ($vT_widget#"")
	$vJ_widgets:=$vJ_widgets[$vT_widget]
End if 

