//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vT_dropText : Text)->$isOk : Boolean
var $vT_domRef; $vT_currentObject; $vT_defaultFontName; $vT_colour; $vT_svg; $vT_text : Text
var $vL_clickX; $vL_clickY; $vL_defaultFontSize : Integer
var $vJ_canvas; $vJ_font : Object
var $vO_image : Picture
var $vP_T_currentObjects : Pointer
var $vR_w; $vR_h; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_x; $vR_y : Real

$vT_domRef:=Form:C1466.t_domRef

svgE_getStuff_vJ(->$vJ_canvas)
$vT_currentObject:=$vJ_canvas.t_currentObject
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
$vT_defaultFontName:=$vJ_canvas.defaultFontName
$vL_defaultFontSize:=$vJ_canvas.defaultFontSize

$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

$vJ_font:=wos_getWidget("wos_text")
$vT_colour:=$vJ_font.t_colour

$isOk:=False:C215

If (Length:C16($vT_dropText)#0)
	
	
	$vT_svg:=SVG_New
	$vT_text:=SVG_New_textArea($vT_svg; $vT_dropText)
	DOM SET XML ATTRIBUTE:C866($vT_text; "font-size"; $vL_defaultFontSize; "font-family"; $vT_defaultFontName)
	SVG EXPORT TO PICTURE:C1017($vT_svg; $vO_image)
	PICTURE PROPERTIES:C457($vO_image; $vR_w; $vR_h)
	DOM CLOSE XML:C722($vT_svg)
	
	$vR_tx:=$vL_clickX
	$vR_ty:=$vL_clickY
	$vR_sx:=1
	$vR_sy:=1
	$vR_x:=-($vR_w/2)
	$vR_y:=-($vR_h/2)
	$vT_currentObject:=SVG_New_textArea($vT_domRef; $vT_dropText)
	$vJ_canvas.t_currentObject:=$vT_currentObject
	DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y; "id"; $vT_currentObject; "font-size"; $vL_defaultFontSize; "font-family"; $vT_defaultFontName; "fill"; $vT_colour)
	
	//make the center point be 0,0 like ellpise or circle
	svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
	APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
	$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
	$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
	
End if 


