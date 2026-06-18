//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)
var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool

var $vT_currentPolylineObject : Text
var $vR_currentPolylineScaleX; $vR_currentPolylineScaleY : Real
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject
$vR_currentPolylineScaleX:=$vJ_polyline.scaleX
$vR_currentPolylineScaleY:=$vJ_polyline.scaleY

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vL_handle_radius; $vL_handles_diameter : Integer
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2


var $vP_T_polylineHandles; $vP_T_polylinePointX; $vP_T_polylinePointY : Pointer
$vP_T_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")
$vP_T_polylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointX")
$vP_T_polylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointY")


var $vR_scale; $vR_move_X; $vR_move_Y : Real

$vR_scale:=$vL_zoom/100

var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentPolylineObject)#0)
	
	var $vL_p; $i : Integer
	
	var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
	var $vR_x; $vR_y; $vR_w; $vR_h : Real
	var $vR_px; $vR_py : Real
	
	$vL_p:=$vP_T_polylineHandles->
	
	$vR_move_X:=(MouseX-$vL_clickX)/$vR_scale
	$vR_move_Y:=(MouseY-$vL_clickY)/$vR_scale
	
	If ($vL_p>0) & ($vL_p<=Size of array:C274($vP_T_polylineHandles->))
		
		//move the handle
		svgE_OBJECT_Get_transform($vP_T_polylineHandles->{$vL_p}; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
		
		$vR_x:=$vP_T_polylinePointX->{$vL_p}
		$vR_y:=$vP_T_polylinePointY->{$vL_p}
		
		//move the point
		
		var $i : Integer
		
		$vR_sx:=$vR_currentPolylineScaleX
		$vR_sy:=$vR_currentPolylineScaleY
		
		$vR_px:=$vR_x+(Sin:C17((90-$vR_r)*Degree:K30:2)*($vR_move_X/$vR_sx))+(Sin:C17(($vR_r)*Degree:K30:2)*($vR_move_Y/$vR_sy))
		$vR_py:=$vR_y-(Cos:C18((90-$vR_r)*Degree:K30:2)*($vR_move_X/$vR_sx))+(Cos:C18(($vR_r)*Degree:K30:2)*($vR_move_Y/$vR_sy))
		
		var $vR_psx; $vR_psy : Real
		
		$vR_psx:=Num:C11(String:C10($vR_px*$vR_sx))  //remove e
		$vR_psy:=Num:C11(String:C10($vR_py*$vR_sy))  //remove e
		
		DOM SET XML ATTRIBUTE:C866($vP_T_polylineHandles->{$vL_p}; "x"; $vR_psx-$vL_handle_radius; "y"; $vR_psy-$vL_handle_radius)
		
		$vR_px:=Num:C11(String:C10($vR_px))  //remove e
		$vR_py:=Num:C11(String:C10($vR_py))  //remove e
		
		$vP_T_polylinePointX->{$vL_p}:=$vR_px
		$vP_T_polylinePointY->{$vL_p}:=$vR_py
		
		var $vT_points : Text
		$vT_points:=""
		
		For ($vL_p; 1; Size of array:C274($vP_T_polylinePointX->))
			$vT_points:=$vT_points+Replace string:C233(String:C10($vP_T_polylinePointX->{$vL_p}); ","; ".")+","+Replace string:C233(String:C10($vP_T_polylinePointY->{$vL_p}); ","; ".")+" "
		End for 
		
		DOM SET XML ATTRIBUTE:C866($vT_currentPolylineObject; "points"; $vT_points)
		
		$isOk:=True:C214
		
	End if 
	
End if 

$vJ_canvas.l_clickX:=MouseX
$vJ_canvas.l_clickY:=MouseY

$0:=$isOk

