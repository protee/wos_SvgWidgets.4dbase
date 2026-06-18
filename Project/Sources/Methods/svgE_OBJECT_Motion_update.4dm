//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean


var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vL_handle_radius; $vL_handles_diameter : Integer
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2

var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $vR_scale : Real
If ($vL_zoom=0)
	$vR_scale:=1
Else 
	$vR_scale:=$vL_zoom/100
End if 

var $isOk : Boolean
$isOk:=False:C215

var $i; $j; $vL_tt : Integer
var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
var $vR_x; $vR_y; $vR_w; $vR_h : Real

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

$vL_tt:=Size of array:C274($vP_T_currentObjects->)
For ($i; 1; $vL_tt)
	var $vT_idx_currentObjects; $vT_objectType : Text
	$vT_idx_currentObjects:=$vP_T_currentObjects->{$i}
	$vT_objectType:=svgE_OBJECT_Get_transform($vT_idx_currentObjects; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
	
	// 2021-0602 Works fine even without "translate".
	$vR_cx:=$vR_x+($vR_w/2)
	$vR_cy:=$vR_y+($vR_h/2)
	
	$vR_tx:=$vR_tx+((MouseX-$vL_clickX)/$vR_scale)
	$vR_ty:=$vR_ty+((MouseY-$vL_clickY)/$vR_scale)
	svgE_OBJECT_set_transform($vT_idx_currentObjects; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
	
	$isOk:=True:C214
	var $vT_rect : Text
	$vT_rect:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".select")
	If ($vT_rect#$vT_xml_null)
		If ($vT_objectType="polyline")
			$vR_w:=$vR_w*$vR_sx
			$vR_h:=$vR_h*$vR_sy
			$vR_x:=-($vR_w/2)
			$vR_y:=-($vR_h/2)
			$vR_sx:=1
			$vR_sy:=1
		End if 
		svgE_OBJECT_set_transform($vT_rect; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
		
		ARRAY TEXT:C222($aT_handles; 8)
		$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".tl")
		$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".tm")
		$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".tr")
		$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".ml")
		$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".mr")
		$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".bl")
		$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".bm")
		$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".br")
		
		For ($j; 1; 8)
			var $vT_handle : Text
			$vT_handle:=$aT_handles{$j}
			If ($vT_handle#$vT_xml_null)
				Case of 
					: ($j=1)  //tl
						$vR_x:=-(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=-(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))-(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=2)  //tm
						$vR_x:=(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=-(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=3)  //tr
						$vR_x:=(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))-(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=4)  //ml
						$vR_x:=-(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=-(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=5)  //mr
						$vR_x:=(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=6)  //bl
						$vR_x:=-(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))-(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=-(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=7)  //bm
						$vR_x:=-(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
					: ($j=8)  //br
						$vR_x:=(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))-(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
						$vR_y:=(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
						
				End case 
				
				$vR_x:=Num:C11(String:C10($vR_x))  //remove e
				$vR_y:=Num:C11(String:C10($vR_y))  //remove e
				
				DOM SET XML ATTRIBUTE:C866($vT_handle; "x"; $vR_x; "y"; $vR_y)
				svgE_OBJECT_set_transform($vT_handle; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
			End if 
		End for 
	End if 
End for 

$vJ_canvas.l_clickX:=MouseX
$vJ_canvas.l_clickY:=MouseY

$0:=$isOk

