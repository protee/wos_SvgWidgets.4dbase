//%attributes = {"invisible":true,"lang":"en"}

#DECLARE()->$isOk : Boolean
var $vL_handle_radius; $vL_handles_diameter; $vL_rotate; $i; $vL_p; $j : Integer
var $vJ_canvas; $vJ_polyline; $vJ_ui; $vJ_rotate : Object
var $vP_canvas; $vP_T_currentObjects; $vP_T_polylineHandles : Pointer
var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy; $vR_x; $vR_y; $vR_w; $vR_h; $vR_ssx; $vR_ssy : Real
var $vT_editTextObject; $vT_currentPolylineObject; $vT_xml_null; $vT_objectType; $vT_rect; $vT_idx_currentObjects : Text

//C_TEXT($domRef)
//  $domRef:=Form.t_domRef
$isOk:=False:C215

svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)
//$currentObject:=$ob_canvas.t_currentObject
$vT_editTextObject:=$vJ_canvas.t_editTextObject

$vJ_ui:=wos__storage_prefs_ui
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2

$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

$vJ_rotate:=wos_getWidget("wos_rotate")
$vL_rotate:=$vJ_rotate.l_value

$vT_currentPolylineObject:=$vJ_polyline.t_currentObject

$vT_xml_null:=wos__storage_stuff.t_xml_null

For ($i; 1; Size of array:C274($vP_T_currentObjects->))
	
	Case of 
			//don't move objects in edit mode
		: ($vP_T_currentObjects->{$i}=$vT_currentPolylineObject)
			$vT_objectType:=svgE_OBJECT_Get_transform($vP_T_currentObjects->{$i}; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vR_cx:=$vR_x+($vR_w/2)
			$vR_cy:=$vR_y+($vR_h/2)
			
			svgE_OBJECT_set_transform($vP_T_currentObjects->{$i}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vL_rotate; $vR_cx; $vR_cy)
			$vP_T_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")
			//$ptr_T_polylinePointX:=OBJECT Get pointer(Object named;"T_polylinePointX")
			//$ptr_T_polylinePointY:=OBJECT Get pointer(Object named;"T_polylinePointY")
			
			For ($vL_p; 1; Size of array:C274($vP_T_polylineHandles->))
				svgE_OBJECT_set_transform($vP_T_polylineHandles->{$vL_p}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vL_rotate; $vR_cx; $vR_cy)
			End for 
			$isOk:=True:C214
			
		: ($vP_T_currentObjects->{$i}=$vT_editTextObject)
			
		Else 
			$vT_objectType:=svgE_OBJECT_Get_transform($vP_T_currentObjects->{$i}; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			$vR_cx:=$vR_x+($vR_w/2)
			$vR_cy:=$vR_y+($vR_h/2)
			If ($vT_objectType="polyline")
				$vR_ssx:=0
				$vR_ssy:=0
			End if 
			
			svgE_OBJECT_set_transform($vP_T_currentObjects->{$i}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vL_rotate; $vR_cx; $vR_cy)
			
			$isOk:=True:C214
			$vT_rect:=DOM Find XML element by ID:C1010($vP_T_currentObjects->{$i}; $vP_T_currentObjects->{$i}+".select")
			If ($vT_rect#$vT_xml_null)
				If ($vT_objectType="polyline")
					$vR_w:=$vR_w*$vR_sx
					$vR_h:=$vR_h*$vR_sy
					$vR_x:=-($vR_w/2)
					$vR_y:=-($vR_h/2)
					$vR_sx:=1
					$vR_sy:=1
				End if 
				svgE_OBJECT_set_transform($vT_rect; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vL_rotate; $vR_cx; $vR_cy)
				
				ARRAY TEXT:C222($aT_handles; 8)
				$vT_idx_currentObjects:=$vP_T_currentObjects->{$i}
				$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".tl")
				$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".tm")
				$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".tr")
				$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".ml")
				$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".mr")
				$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".bl")
				$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".bm")
				$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_idx_currentObjects; $vT_idx_currentObjects+".br")
				
				For ($j; 1; 8)
					If ($aT_handles{$j}#$vT_xml_null)
						
						Case of 
							: ($j=1)  //tl
								$vR_x:=-(($vR_w/2)*Cos:C18($vL_rotate*Degree:K30:2))+(($vR_h/2)*Cos:C18((90-$vL_rotate)*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=-(($vR_w/2)*Sin:C17($vL_rotate*Degree:K30:2))-(($vR_h/2)*Sin:C17((90-$vL_rotate)*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=2)  //tm
								$vR_x:=(($vR_h/2)*Cos:C18((90-$vL_rotate)*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=-(($vR_h/2)*Sin:C17((90-$vL_rotate)*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=3)  //tr
								$vR_x:=(($vR_w/2)*Cos:C18($vL_rotate*Degree:K30:2))+(($vR_h/2)*Cos:C18((90-$vL_rotate)*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=(($vR_w/2)*Sin:C17($vL_rotate*Degree:K30:2))-(($vR_h/2)*Sin:C17((90-$vL_rotate)*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=4)  //ml
								$vR_x:=-(($vR_w/2)*Cos:C18($vL_rotate*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=-(($vR_w/2)*Sin:C17($vL_rotate*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=5)  //mr
								$vR_x:=(($vR_w/2)*Cos:C18($vL_rotate*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=(($vR_w/2)*Sin:C17($vL_rotate*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=6)  //bl
								$vR_x:=-(($vR_w/2)*Cos:C18($vL_rotate*Degree:K30:2))-(($vR_h/2)*Cos:C18((90-$vL_rotate)*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=-(($vR_w/2)*Sin:C17($vL_rotate*Degree:K30:2))+(($vR_h/2)*Sin:C17((90-$vL_rotate)*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=7)  //bm
								$vR_x:=-(($vR_h/2)*Cos:C18((90-$vL_rotate)*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=(($vR_h/2)*Sin:C17((90-$vL_rotate)*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
							: ($j=8)  //br
								$vR_x:=(($vR_w/2)*Cos:C18($vL_rotate*Degree:K30:2))-(($vR_h/2)*Cos:C18((90-$vL_rotate)*Degree:K30:2))+$vR_cx-$vL_handle_radius
								$vR_y:=(($vR_w/2)*Sin:C17($vL_rotate*Degree:K30:2))+(($vR_h/2)*Sin:C17((90-$vL_rotate)*Degree:K30:2))+$vR_cy-$vL_handle_radius
								
						End case 
						
						$vR_x:=Num:C11(String:C10($vR_x))  //remove e
						$vR_y:=Num:C11(String:C10($vR_y))  //remove e
						DOM SET XML ATTRIBUTE:C866($aT_handles{$j}; "x"; $vR_x; "y"; $vR_y)
						svgE_OBJECT_set_transform($aT_handles{$j}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vL_rotate; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
					End if 
				End for 
			End if 
	End case 
End for 

