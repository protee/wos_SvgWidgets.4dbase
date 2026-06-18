//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY

var $vT_currentSelectArea : Text
$vT_currentSelectArea:=$vJ_canvas.t_currentSelectArea


var $vR_scale : Real
If ($vL_zoom=0)
	$vR_scale:=1
Else 
	$vR_scale:=$vL_zoom/100
End if 

var $vR_w; $vR_h; $vR_x; $vR_y : Real

var $isOk : Boolean
$isOk:=False:C215

If ($vT_currentSelectArea#"")
	
	$vR_w:=Abs:C99((MouseX-$vL_clickX)/$vR_scale)
	$vR_h:=Abs:C99((MouseY-$vL_clickY)/$vR_scale)
	
	If (MouseX>$vL_clickX)
		$vR_x:=$vL_clickX/$vR_scale
	Else 
		$vR_x:=MouseX/$vR_scale
	End if 
	If (MouseY>$vL_clickY)
		$vR_y:=$vL_clickY/$vR_scale
	Else 
		$vR_y:=MouseY/$vR_scale
	End if 
	
	SVG_SET_ATTRIBUTES($vT_currentSelectArea; "width"; String:C10($vR_w); "height"; String:C10($vR_h))
	SVG_SET_TRANSFORM_TRANSLATE($vT_currentSelectArea; $vR_x; $vR_y)
	
	SET TIMER:C645(1)
	
	$isOk:=True:C214
	
End if 

$0:=$isOk

