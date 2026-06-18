//%attributes = {"invisible":true,"lang":"en"}
var $1 : Picture
var $0 : Boolean

var $vO_picture : Picture
$vO_picture:=$1

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_clickX; $vL_clickY : Integer
var $vT_currentObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY

var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")


var $isOk : Boolean
var $vL_height; $vL_width : Integer
$isOk:=False:C215
If (Picture size:C356($vO_picture)#0)
	var $vR_x; $vR_y; $vR_w; $vR_h : Real
	var $vR_tx; $vR_ty; $vR_sx; $vR_sy : Real
	var $vJ_paper : Object
	$vJ_paper:=Form:C1466.j_paper
	$vL_width:=$vJ_paper.l_width*0.7
	$vL_height:=$vJ_paper.l_height*0.7
	
	PICTURE PROPERTIES:C457($vO_picture; $vR_w; $vR_h)
	$vR_tx:=$vL_clickX
	$vR_ty:=$vL_clickY
	
	If ($vR_w>$vL_width)
		$vR_sx:=$vL_width/$vR_w
	Else 
		$vR_sx:=1
	End if 
	If ($vR_h>$vL_height)
		$vR_sy:=$vL_height/$vR_h
	Else 
		$vR_sy:=1
	End if 
	If ($vR_sx>$vR_sy)
		$vR_sx:=$vR_sy
	End if 
	$vR_w:=$vR_w*$vR_sx
	$vR_h:=$vR_h*$vR_sx
	$vR_x:=-($vR_w/2)
	$vR_y:=-($vR_h/2)
	
	// Don't chage $sx and $sy, as handles will be scaled too -> manage $w and $h
	$vR_sx:=1
	$vR_sy:=1
	
	$vT_currentObject:=SVG_New_embedded_image($vT_domRef; $vO_picture)
	$vJ_canvas.t_currentObject:=$vT_currentObject
	DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y; "id"; $vT_currentObject)
	svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
	APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
	
	$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
	$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
End if 

$0:=$isOk

