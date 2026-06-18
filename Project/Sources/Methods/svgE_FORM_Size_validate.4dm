//%attributes = {"invisible":true,"lang":"en"}

//make this the only method where we manage scroll bar visibility

var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vT_editTextObject : Text
$vT_editTextObject:=$vJ_canvas.t_editTextObject
If ($vT_editTextObject#"")
	OBJECT SET SCROLLBAR:C843($vP_canvas->; False:C215; False:C215)
	
Else 
	var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	//OBJECT GET COORDINATES($ptr_canvas->;$left;$top;$right;$bottom)
	OBJECT GET COORDINATES:C663(*; "bkg"; $vL_left; $vL_top; $vL_right; $vL_bottom)
	
	var $vL_canvas_w; $vL_canvas_h : Integer
	$vL_canvas_w:=$vL_right-$vL_left
	$vL_canvas_h:=$vL_bottom-$vL_top
	var $vL_w; $vL_h : Integer
	PICTURE PROPERTIES:C457($vP_canvas->; $vL_w; $vL_h)
	
	var $is_scrollH; $is_scrollV : Boolean
	$is_scrollH:=($vL_w>$vL_canvas_w)
	If ($is_scrollH)
		$vL_canvas_h:=$vL_canvas_h-16
	End if 
	$is_scrollV:=($vL_h>$vL_canvas_h)
	If ($is_scrollV)
		$vL_canvas_w:=$vL_canvas_w-16
	End if 
	$is_scrollH:=($vL_w>$vL_canvas_w)
	
	OBJECT SET SCROLLBAR:C843($vP_canvas->; $is_scrollH; $is_scrollV)
	
End if 

