//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_getWidget
//
// Parameter Type Description
// $1 <TXT> {widgetName} or current widget
//
// Description:
// Gives back the object parameters of a given widget name.
// If the widget is undefined, an null object is returned
//
// Date        Init  Description
// ===================================================================
// 01/02/2021   OG   Initial version.

#DECLARE($vT_widgetName : Text)->$vJ_widget : Object  // {#1} optionnals
If ($vT_widgetName="")
	$vT_widgetName:=OBJECT Get name:C1087(Object current:K67:2)
End if 
$vJ_widget:=OBJECT Get value:C1743($vT_widgetName)

