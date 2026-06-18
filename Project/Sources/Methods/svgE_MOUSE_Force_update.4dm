//%attributes = {"invisible":true,"lang":"en"}


var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_containerX; $vL_containerY : Integer
$vL_containerX:=$vJ_canvas.containerX
$vL_containerY:=$vJ_canvas.containerY

var $vR_x; $vR_y : Real
var $vL_b : Integer
GET MOUSE:C468($vR_x; $vR_y; $vL_b)
var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
var $vL_scrH; $vL_scrV : Integer
OBJECT GET SCROLL POSITION:C1114($vP_canvas->; $vL_scrV; $vL_scrH)

OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
$vR_x:=$vR_x-$vL_left+$vL_scrH
$vR_y:=$vR_y-$vL_top+$vL_scrV

If (Not:C34(Is nil pointer:C315(OBJECT Get pointer:C1124(Object subform container:K67:4))))
	$vR_x:=$vR_x-$vL_containerX
	$vR_y:=$vR_y-$vL_containerY
End if 

MouseX:=$vR_x
MouseY:=$vR_y





