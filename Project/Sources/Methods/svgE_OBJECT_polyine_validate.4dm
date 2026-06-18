//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas; $vJ_polyline; $vJ_history : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline; ->$vJ_history)
var $vT_currentObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vL_handle_radius; $vL_handles_diameter : Integer
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2

var $vT_currentPolylineObject : Text
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject

var $isOk : Boolean
$isOk:=False:C215

var $vP_T_polylineHandles; $vP_T_polylinePointX; $vP_T_polylinePointY : Pointer
$vP_T_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")
$vP_T_polylinePointX:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointX")
$vP_T_polylinePointY:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylinePointY")

var $vT_objectType : Text

If (Length:C16($vT_currentObject)#0)
	
	DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
	
	Case of 
		: ($vT_objectType="polyline")
			
			var $vL_countAttributes; $i; $vL_p : Integer
			
			$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject)
			ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
			ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
			
			For ($i; 1; $vL_countAttributes)
				DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject; $i; $aT_attributeNames{$i}; $aT_attributeValues{$i})
			End for 
			
			var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
			
			$vR_tx:=0
			$vR_ty:=0
			$vR_sx:=1
			$vR_sy:=1
			
			$vR_r:=0
			$vR_cx:=0
			$vR_cy:=0
			
			ARRAY LONGINT:C221($aL_pos; 0)
			ARRAY LONGINT:C221($aL_len; 0)
			
			If (Find in array:C230($aT_attributeNames; "transform")#-1)
				
				var $vT_transform : Text
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "transform"; $vT_transform)
				
				If (Match regex:C1019("translate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
					$vR_tx:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
					$vR_ty:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
				End if 
				
				If (Match regex:C1019("scale\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
					$vR_sx:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
					$vR_sy:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
				End if 
				
				If (Match regex:C1019("rotate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
					$vR_r:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
					$vR_cx:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
					$vR_cy:=Num:C11(Substring:C12($vT_transform; $aL_pos{3}; $aL_len{3}); ".")
				End if 
				
			End if 
			
			If (Find in array:C230($aT_attributeNames; "points")#-1)
				var $vT_points : Text
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "points"; $vT_points)
				ARRAY REAL:C219($aR_relative_x; 0)
				ARRAY REAL:C219($aR_relative_y; 0)
				ARRAY REAL:C219($aR_absolute_x; 0)
				ARRAY REAL:C219($aR_absolute_y; 0)
				$vL_p:=1
				var $vR_x; $vR_y : Real
				While (Match regex:C1019("(-?(?:\\d|\\.)+)[,\\s](-?(?:\\d|\\.)+)"; $vT_points; $vL_p; $aL_pos; $aL_len))
					$vR_x:=Num:C11(Substring:C12($vT_points; $aL_pos{1}; $aL_len{1}); ".")
					$vR_y:=Num:C11(Substring:C12($vT_points; $aL_pos{2}; $aL_len{2}); ".")
					APPEND TO ARRAY:C911($aR_relative_x; $vR_x)
					APPEND TO ARRAY:C911($aR_relative_y; $vR_y)
					$vL_p:=$aL_pos{2}+$aL_len{2}
				End while 
				
				COPY ARRAY:C226($aR_relative_x; $aR_absolute_x)
				COPY ARRAY:C226($aR_relative_y; $aR_absolute_y)
				SORT ARRAY:C229($aR_relative_x)
				SORT ARRAY:C229($aR_relative_y)
				
				var $vR_x1; $vR_x2; $vR_y1; $vR_y2 : Real
				If (Size of array:C274($aR_relative_x)#0)
					$vR_x1:=$aR_relative_x{1}
					$vR_y1:=$aR_relative_y{1}
					$vR_x2:=$aR_relative_x{Size of array:C274($aR_relative_x)}
					$vR_y2:=$aR_relative_y{Size of array:C274($aR_relative_y)}
				Else 
					$vR_x1:=0
					$vR_y1:=0
					$vR_x2:=0
					$vR_y2:=0
				End if 
				
				var $vR_w; $vR_h : Real
				
				$vR_w:=Abs:C99($vR_x2-$vR_x1)
				$vR_h:=Abs:C99($vR_y2-$vR_y1)
				
				var $vL_offsetH; $vL_offsetW : Integer
				$vL_offsetW:=-$vR_x1-($vR_w/2)
				$vL_offsetH:=-$vR_y1-($vR_h/2)
				
				$vT_points:=""
				For ($vL_p; 1; Size of array:C274($aR_absolute_x))
					$aR_absolute_x{$vL_p}:=$aR_absolute_x{$vL_p}+$vL_offsetW
					$aR_absolute_y{$vL_p}:=$aR_absolute_y{$vL_p}+$vL_offsetH
					$vT_points:=$vT_points+Replace string:C233(String:C10($aR_absolute_x{$vL_p}); ","; ".")+","+Replace string:C233(String:C10($aR_absolute_y{$vL_p}); ","; ".")+" "
				End for 
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "points"; $vT_points)
				
				var $vL_ccx; $vL_ccy; $ttx; $tty : Integer
				$vL_ccx:=$vL_offsetW
				$vL_ccy:=$vL_offsetH
				
				//$ttx:=(Cos(($r)*Degree)*$vL_ccx)-(Cos((90-$r)*Degree)*$vL_ccy)
				//$tty:=(Sin(($r)*Degree)*$vL_ccx)+(Sin((90-$r)*Degree)*$vL_ccy)
				
				$ttx:=(Cos:C18(($vR_r)*Degree:K30:2)*($vL_ccx*$vR_sx))-(Cos:C18((90-$vR_r)*Degree:K30:2)*($vL_ccy*$vR_sy))
				$tty:=(Sin:C17(($vR_r)*Degree:K30:2)*($vL_ccx*$vR_sx))+(Sin:C17((90-$vR_r)*Degree:K30:2)*($vL_ccy*$vR_sy))
				
				$ttx:=Num:C11(String:C10($ttx))  //remove e
				$tty:=Num:C11(String:C10($tty))  //remove e
				
				$vR_tx:=$vR_tx-$ttx
				$vR_ty:=$vR_ty-$tty
				
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; 0; 0)
				
				If (Length:C16($vT_currentPolylineObject)#0)
					For ($vL_p; 1; Size of array:C274($vP_T_polylinePointX->))
						$vP_T_polylinePointX->{$vL_p}:=$aR_absolute_x{$vL_p}
						$vP_T_polylinePointY->{$vL_p}:=$aR_absolute_y{$vL_p}
						DOM SET XML ATTRIBUTE:C866($vP_T_polylineHandles->{$vL_p}; "x"; ($aR_absolute_x{$vL_p}*$vR_sx)-$vL_handle_radius; "y"; ($aR_absolute_y{$vL_p}*$vR_sy)-$vL_handle_radius)
						svgE_OBJECT_set_transform($vP_T_polylineHandles->{$vL_p}; $vR_tx; $vR_ty; 1; 1; $vR_r; 0; 0)
					End for 
				End if 
			End if 
	End case 
End if 

$0:=True:C214

