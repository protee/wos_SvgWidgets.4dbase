//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_svgEdit_set_image
//
// Parameter Type Description
// $1 <PIC> Picture containing an svg tree 
// $2 <TXT> {widgetName} or current widget
//
// Description:
// Set the svg in the widget from a picture.
//
// Date        Init  Description
// ===================================================================
// 01/02/2021   OG   Initial version.


#DECLARE($vO_picture : Picture; $vT_widgetName : Text)  // {#2} optionnals
If ($vT_widgetName="")
	$vT_widgetName:=OBJECT Get name:C1087(Object current:K67:2)
End if 

var $vX_pictureData : Blob
PICTURE TO BLOB:C692($vO_picture; $vX_pictureData; ".svg")
var $vT_svg : Text
$vT_svg:=BLOB to text:C555($vX_pictureData; UTF8 text without length:K22:17)
EXECUTE METHOD IN SUBFORM:C1085($vT_widgetName; "_svgEditor_set_svg"; *; $vT_svg)

