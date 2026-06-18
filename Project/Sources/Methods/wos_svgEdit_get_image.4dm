//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_svgEdit_get_image
//
// Parameter Type Description
// $1 <TXT> {widgetName} or current widget
// $0 <PIC> Picture made from the svg 
//
// Description:
// Get the svg from the widget and convert it to a picture.
//
// Date        Init  Description
// ===================================================================
// 01/02/2021   OG   Initial version.

#DECLARE($vT_widgetName : Text)->$vO_picture : Picture  // {#1} optionnals
If ($vT_widgetName="")
	$vT_widgetName:=OBJECT Get name:C1087(Object current:K67:2)
End if 

var $vT_svg : Text
EXECUTE METHOD IN SUBFORM:C1085($vT_widgetName; "_svgEditor_get_svg"; $vT_svg)

var $vT_dom_svg : Text
$vT_dom_svg:=DOM Parse XML variable:C720($vT_svg)
SVG EXPORT TO PICTURE:C1017($vT_dom_svg; $vO_picture)
DOM CLOSE XML:C722($vT_dom_svg)

