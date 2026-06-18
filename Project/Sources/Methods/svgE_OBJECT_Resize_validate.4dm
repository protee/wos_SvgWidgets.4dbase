//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_clickX; $vL_clickY : Integer
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentHandle; $vT_currentObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_currentHandle:=$vJ_canvas.currentHandle


var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $isOk : Boolean
$isOk:=False:C215

var $i : Integer

var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy; $vR_rx; $vR_ry; $vR_ccx; $vR_ccy : Real
var $vR_x; $vR_y; $vR_w; $vR_h; $vR_s : Real

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

If (Length:C16($vT_currentHandle)#0)
	var $tt : Integer
	var $vT_rect : Text
	$tt:=Size of array:C274($vP_T_currentObjects->)
	For ($i; 1; $tt)
		
		$vT_currentObject:=$vP_T_currentObjects->{$i}
		$vJ_canvas.t_currentObject:=$vT_currentObject
		$vT_rect:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".select")
		
		If ($vT_rect#$vT_xml_null)
			
			ARRAY REAL:C219($aR_px; 0)
			ARRAY REAL:C219($aR_py; 0)
			
			var $vT_objectType : Text
			$vT_objectType:=svgE_OBJECT_Get_transform($vP_T_currentObjects->{$i}; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h; ->$vR_s; ->$aR_px; ->$aR_py)
			
			Case of 
				: ($vT_objectType="ellipse")
					
					//shift the center of ellipse to the center of rotation
					//cx & cy returned by OBJECT_Get_transform represent the center of rotation
					//cx & cy as svg attributes represent the center of ellpise
					
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "cx"; $vR_ccx)
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "cy"; $vR_ccy)
					
					$vR_tx:=$vR_tx+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_ccx)-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					$vR_ty:=$vR_ty+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_ccx)+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					
					$vR_tx:=Num:C11(String:C10($vR_tx))  //remove e
					$vR_ty:=Num:C11(String:C10($vR_ty))  //remove e
					
					svgE_OBJECT_set_transform($vP_T_currentObjects->{$i}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
					
					//correct negative coordinates here;
					//if done during edit, we will loose track whether the image was flipped or has always been that way
					
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "rx"; $vR_rx)
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "ry"; $vR_ry)
					DOM SET XML ATTRIBUTE:C866($vP_T_currentObjects->{$i}; "rx"; Abs:C99($vR_rx); "ry"; Abs:C99($vR_ry); "cx"; 0; "cy"; 0)
					
				: ($vT_objectType="circle")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "cx"; $vR_ccx)
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "cy"; $vR_ccy)
					
					$vR_tx:=$vR_tx+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_ccx)-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					$vR_ty:=$vR_ty+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_ccx)+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					
					$vR_tx:=Num:C11(String:C10($vR_tx))  //remove e
					$vR_ty:=Num:C11(String:C10($vR_ty))  //remove e
					
					svgE_OBJECT_set_transform($vP_T_currentObjects->{$i}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($vP_T_currentObjects->{$i}; "r"; $vR_r)
					DOM SET XML ATTRIBUTE:C866($vP_T_currentObjects->{$i}; "r"; Abs:C99($vR_r); "cx"; 0; "cy"; 0)
					
				: ($vT_objectType="rect") | ($vT_objectType="image") | ($vT_objectType="textArea")
					
					$vR_ccx:=$vR_x+($vR_w/2)
					$vR_ccy:=$vR_y+($vR_h/2)
					
					$vR_tx:=$vR_tx+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_ccx)-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					$vR_ty:=$vR_ty+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_ccx)+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					
					$vR_tx:=Num:C11(String:C10($vR_tx))  //remove e
					$vR_ty:=Num:C11(String:C10($vR_ty))  //remove e
					
					svgE_OBJECT_set_transform($vP_T_currentObjects->{$i}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
					
					$vR_x:=$vR_cx-($vR_w/2)
					$vR_y:=$vR_cy-($vR_h/2)
					
					DOM SET XML ATTRIBUTE:C866($vP_T_currentObjects->{$i}; "x"; $vR_x; "y"; $vR_y)
					
				: ($vT_objectType="line")
					
					$vR_ccx:=$vR_x+($vR_w/2)
					$vR_ccy:=$vR_y+($vR_h/2)
					
					$vR_tx:=$vR_tx+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_ccx)-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					$vR_ty:=$vR_ty+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_ccx)+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_ccy)
					
					$vR_tx:=Num:C11(String:C10($vR_tx))  //remove e
					$vR_ty:=Num:C11(String:C10($vR_ty))  //remove e
					
					svgE_OBJECT_set_transform($vP_T_currentObjects->{$i}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
					
					var $x1; $x2; $y1; $y2 : Integer
					$x1:=$vR_cx-($vR_w/2)
					$y1:=$vR_cy-($vR_h/2)
					$x2:=$x1+$vR_w
					$y2:=$y1+$vR_h
					
					DOM SET XML ATTRIBUTE:C866($vP_T_currentObjects->{$i}; "x1"; $x1; "y1"; $y1; "x2"; $x2; "y2"; $y2)
					
				: ($vT_objectType="polyline")
					//we don't inverse the object anymore; no need to validate
			End case 
			
			$vT_currentObject:=$vP_T_currentObjects->{$i}
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$isOk:=$isOk | svgE_SELECT_Clear_selection($vT_currentObject)
			$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
			$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
		End if 
	End for 
	$vJ_canvas.currentHandle:=""
	
End if 

$0:=$isOk

