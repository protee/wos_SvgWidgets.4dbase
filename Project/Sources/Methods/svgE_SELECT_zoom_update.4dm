//%attributes = {"invisible":true,"lang":"en"}


//$CanvasZoom:=OBJECT Get pointer(Object named;"CanvasZoom")
//$startEvent:=OBJECT Get pointer(Object named;"startEvent";"CanvasZoom")
//$canvas_width:=OBJECT Get pointer(Object named;"CanvasWidth";"CanvasZoom")
//$canvas_height:=OBJECT Get pointer(Object named;"CanvasHeight";"CanvasZoom")

//$canvas_scrollPositionV:=OBJECT Get pointer(Object named;"CanvasScrollPositionV";"CanvasZoom")
//$canvas_scrollPositionH:=OBJECT Get pointer(Object named;"CanvasScrollPositionH";"CanvasZoom")

//$ResetButton:=OBJECT Get pointer(Object named;"ResetButton";"CanvasZoom")
//$DoubleButton:=OBJECT Get pointer(Object named;"DoubleButton";"CanvasZoom")
//$HalfButton:=OBJECT Get pointer(Object named;"HalfButton";"CanvasZoom")


var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vR_scale : Real
$vR_scale:=$vJ_canvas.l_zoom/100

var $isOk; $is_history : Boolean
$isOk:=False:C215
$is_history:=False:C215

var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

var $vL_scrollH; $vL_scrollV : Integer
OBJECT GET SCROLL POSITION:C1114(*; "Canvas"; $vL_scrollV; $vL_scrollH)
var $vL_canvas_left; $vL_canvas_top; $vL_canvas_right; $vL_canvas_bottom : Integer
OBJECT GET COORDINATES:C663(*; "Canvas"; $vL_canvas_left; $vL_canvas_top; $vL_canvas_right; $vL_canvas_bottom)
var $is_scrollH; $is_scrollV : Boolean
OBJECT GET SCROLLBAR:C1076(*; "Canvas"; $is_scrollH; $is_scrollV)

var $vL_canvas_height; $vL_canvas_width : Integer
$vL_canvas_width:=$vL_canvas_right-$vL_canvas_left-(Num:C11($is_scrollV)*15)
$vL_canvas_height:=$vL_canvas_bottom-$vL_canvas_top-(Num:C11($is_scrollH)*15)

//get current center position
var $vL_imgWidth; $vL_imgHeight : Integer
PICTURE PROPERTIES:C457($vP_canvas->; $vL_imgWidth; $vL_imgHeight)
var $vL_canvas_scrollPositionH; $vL_canvas_scrollPositionV : Integer
$vL_canvas_scrollPositionV:=($vL_scrollV+($vL_canvas_height/2))/$vL_imgHeight
$vL_canvas_scrollPositionH:=($vL_scrollH+($vL_canvas_width/2))/$vL_imgWidth

$isOk:=svgE_EDIT_Text_validate()
//$is_canvas_shouldUpdate:=$is_canvas_shouldUpdate | SELECT_Object_none

If ($isOk)
	$is_history:=True:C214
End if 
If ($vL_scrollV=0)
	$vL_canvas_scrollPositionV:=0
End if 
If ($vL_scrollH=0)
	$vL_canvas_scrollPositionH:=0
End if 
TRANSFORM PICTURE:C988($vP_canvas->; Scale:K61:2; $vR_scale; $vR_scale)

$isOk:=True:C214
If ($isOk)
	svgE_FORM_canvas_redraw()
	PICTURE PROPERTIES:C457($vP_canvas->; $vL_imgWidth; $vL_imgHeight)
	If ($vL_canvas_scrollPositionV=0)
		$vL_scrollV:=0
	Else 
		$vL_scrollV:=($vL_imgHeight*$vL_canvas_scrollPositionV)-($vL_canvas_height/2)
	End if 
	If ($vL_canvas_scrollPositionH=0)
		$vL_scrollH:=0
	Else 
		$vL_scrollH:=($vL_imgWidth*$vL_canvas_scrollPositionH)-($vL_canvas_width/2)
	End if 
	//command will not work in the first instance when the scroll bars are about to appear
	//default to 0,0 behaviour in that case
	OBJECT SET SCROLL POSITION:C906(*; "Canvas"; $vL_scrollV; $vL_scrollH; *)
End if 

If ($is_history)
	svgE_HISTORY_Append()
End if 

