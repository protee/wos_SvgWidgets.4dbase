//%attributes = {"invisible":true,"lang":"en"}

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom : Integer
$vL_zoom:=$vJ_canvas.l_zoom

var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

var $vR_scale : Real
If ($vL_zoom#0)
	$vR_scale:=$vL_zoom/100
Else 
	$vR_scale:=1
End if 
SVG EXPORT TO PICTURE:C1017($vT_domRef; $vP_canvas->)
TRANSFORM PICTURE:C988($vP_canvas->; Scale:K61:2; $vR_scale; $vR_scale)
If (Form event code:C388=On Drop:K2:12)
	svgE_CURSOR_Update
End if 
svgE_FORM_Size_validate

