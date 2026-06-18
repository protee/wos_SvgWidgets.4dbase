//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentObject; $vT_currentHandle : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_currentHandle:=$vJ_canvas.currentHandle
var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vL_handle_radius; $vL_handles_diameter : Integer
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2


var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $isOk : Boolean
$isOk:=False:C215

var $i; $vL_p : Integer

var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
var $vR_x; $vR_y; $vR_w; $vR_h; $vR_s; $vR_rx; $vR_ry; $vR_s : Real
var $vR_psx; $vR_psy : Real
var $vR_ccx; $vR_ccy; $vR_ptx; $vR_pty : Real
var $vR_pr; $vR_pcx; $vR_pcy; $vR_px; $vR_py; $vR_pw; $vR_ph : Real
var $vR_rr : Real


var $vR_scale : Real
If ($vL_zoom=0)
	$vR_scale:=1
Else 
	$vR_scale:=$vL_zoom/100
End if 

var $vR_movH; $vR_movV : Real
$vR_movH:=(MouseX-$vL_clickX)/$vR_scale
$vR_movV:=(MouseY-$vL_clickY)/$vR_scale

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null

ARRAY REAL:C219($aR_ppx; 0)
ARRAY REAL:C219($aR_ppy; 0)

For ($i; 1; Size of array:C274($vP_T_currentObjects->))
	$vT_currentObject:=$vP_T_currentObjects->{$i}
	//resize the object along selection rect; this will shift the center of rotation
	var $vT_objectType; $vT_rect : Text
	$vT_rect:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".select")
	
	If ($vT_rect#$vT_xml_null)
		$isOk:=True:C214
		$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h; ->$vR_s; ->$aR_ppx; ->$aR_ppy)
		Case of 
			: ($vT_objectType="rect") | ($vT_objectType="textArea") | ($vT_objectType="circle") | ($vT_objectType="polyline") | ($vT_objectType="image")
				$vR_ptx:=$vR_tx
				$vR_pty:=$vR_ty
				$vR_psx:=$vR_sx
				$vR_psy:=$vR_sy
				$vR_pr:=$vR_r
				$vR_pcx:=$vR_cx
				$vR_pcy:=$vR_cy
				$vR_px:=$vR_x
				$vR_py:=$vR_y
				$vR_pw:=$vR_w
				$vR_ph:=$vR_h
				svgE_OBJECT_Get_transform($vT_rect; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
				
		End case 
		
		Case of 
			: ($vT_currentHandle="tl")
				$vR_w:=$vR_w-(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)-(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_x:=$vR_x+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_h:=$vR_h+(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)-(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_y:=$vR_y-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="tm")
				$vR_h:=$vR_h+(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)-(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_y:=$vR_y-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="tr")
				$vR_w:=$vR_w+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_h:=$vR_h+(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)-(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_y:=$vR_y-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="ml")
				$vR_w:=$vR_w-(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)-(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_x:=$vR_x+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="mr")
				$vR_w:=$vR_w+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="bl")
				$vR_w:=$vR_w-(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)-(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_x:=$vR_x+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_h:=$vR_h-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="bm")
				$vR_h:=$vR_h-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				
			: ($vT_currentHandle="br")
				$vR_w:=$vR_w+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_movV)
				$vR_h:=$vR_h-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_movH)+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_movV)
				
		End case 
		
		// 2021-0602 Works fine even without "translate".
		$vR_rx:=($vR_w/2)
		$vR_ry:=($vR_h/2)
		$vR_cx:=$vR_rx+$vR_x
		$vR_cy:=$vR_ry+$vR_y
		
		Case of 
			: ($vT_objectType="line")
				$vR_x:=$vR_cx-($vR_w/2)
				$vR_y:=$vR_cy-($vR_h/2)
				var $x1; $x2; $y1; $y2 : Integer
				$x1:=$vR_x
				$x2:=$vR_x+$vR_w
				$y1:=$vR_y
				$y2:=$vR_y+$vR_h
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "x1"; $x1; "y1"; $y1; "x2"; $x2; "y2"; $y2)
				
				
			: ($vT_objectType="circle")
				If (Not:C34(Shift down:C543))
					//change to ellipse
					DOM SET XML ELEMENT NAME:C867($vT_currentObject; "ellipse")
					DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "r")
					
					Case of 
						: ($vT_currentHandle="tl")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="tm")
							$vR_rx:=($vR_w/2)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="tr")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="ml")
							$vR_ry:=($vR_h/2)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry)
							
						: ($vT_currentHandle="mr")
							$vR_ry:=($vR_h/2)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry)
							
						: ($vT_currentHandle="bl")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="bm")
							$vR_rx:=($vR_w/2)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="br")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
					End case 
					
				Else 
					
					Case of 
						: ($vT_currentHandle="tl")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
						: ($vT_currentHandle="tm")
							If (Abs:C99($vR_w/2))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=($vR_w/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cy"; $vR_cy)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							
						: ($vT_currentHandle="tr")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
						: ($vT_currentHandle="ml")
							If (Abs:C99($vR_h/2))>(Abs:C99($vR_rx))
								$vR_rr:=$vR_rx
							Else 
								$vR_rr:=($vR_h/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							
						: ($vT_currentHandle="mr")
							If (Abs:C99($vR_h/2))>(Abs:C99($vR_rx))
								$vR_rr:=$vR_rx
							Else 
								$vR_rr:=($vR_h/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							
						: ($vT_currentHandle="bl")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
						: ($vT_currentHandle="bm")
							If (Abs:C99($vR_w/2))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=($vR_w/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cy"; $vR_cy)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							
						: ($vT_currentHandle="br")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
					End case 
				End if 
				$vR_x:=$vR_cx-($vR_w/2)
				$vR_y:=$vR_cy-($vR_h/2)
				//*
				//****
				
				
			: ($vT_objectType="ellipse")
				If (Shift down:C543)
					//change to circle
					DOM SET XML ELEMENT NAME:C867($vT_currentObject; "circle")
					DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "rx")
					DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "ry")
					
					Case of 
						: ($vT_currentHandle="tl")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
						: ($vT_currentHandle="tm")
							If (Abs:C99($vR_w/2))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=($vR_w/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cy"; $vR_cy)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							
						: ($vT_currentHandle="tr")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
						: ($vT_currentHandle="ml")
							If (Abs:C99($vR_h/2))>(Abs:C99($vR_rx))
								$vR_rr:=$vR_rx
							Else 
								$vR_rr:=($vR_h/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							
						: ($vT_currentHandle="mr")
							If (Abs:C99($vR_h/2))>(Abs:C99($vR_rx))
								$vR_rr:=$vR_rx
							Else 
								$vR_rr:=($vR_h/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							
						: ($vT_currentHandle="bl")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
						: ($vT_currentHandle="bm")
							If (Abs:C99($vR_w/2))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=($vR_w/2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cy"; $vR_cy)
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							
						: ($vT_currentHandle="br")
							If (Abs:C99($vR_rx))>(Abs:C99($vR_ry))
								$vR_rr:=$vR_ry
							Else 
								$vR_rr:=$vR_rx
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_rr; "cx"; $vR_cx; "cy"; $vR_cy)
							
					End case 
					
				Else 
					
					Case of 
						: ($vT_currentHandle="tl")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="tm")
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="tr")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="ml")
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx)
							
						: ($vT_currentHandle="mr")
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cy"; $vR_cy)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx)
							
						: ($vT_currentHandle="bl")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="bm")
							DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "cx"; $vR_cx)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "ry"; $vR_ry; "cy"; $vR_cy)
							
						: ($vT_currentHandle="br")
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "cx"; $vR_cx; "ry"; $vR_ry; "cy"; $vR_cy)
							
					End case 
				End if 
				$vR_x:=$vR_cx-($vR_w/2)
				$vR_y:=$vR_cy-($vR_h/2)
				
				
				
			: ($vT_objectType="rect") | ($vT_objectType="image") | ($vT_objectType="textArea")
				$vR_x:=$vR_cx-($vR_w/2)
				$vR_y:=$vR_cy-($vR_h/2)
				If ($vR_w<0)
					$vR_px:=$vR_x-Abs:C99($vR_w)
				Else 
					$vR_px:=$vR_x
				End if 
				$vR_pw:=Abs:C99($vR_w)
				If ($vR_h<0)
					$vR_py:=$vR_y-Abs:C99($vR_h)
				Else 
					$vR_py:=$vR_y
				End if 
				$vR_ph:=Abs:C99($vR_h)
				If (Shift down:C543)  // Rectangular area
					If ($vR_pw>$vR_ph)
						$vR_pw:=$vR_ph
					Else 
						$vR_ph:=$vR_pw
					End if 
				End if 
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "x"; $vR_px; "y"; $vR_py; "width"; $vR_pw; "height"; $vR_ph)
				
				
			: ($vT_objectType="polyline")
				//for rect
				$vR_x:=$vR_cx-($vR_w/2)
				$vR_y:=$vR_cy-($vR_h/2)
				If ($vR_pw#0) & ($vR_ph#0)  //can be INF
					$vR_psx:=Abs:C99($vR_w/$vR_pw)
					$vR_psy:=Abs:C99($vR_h/$vR_ph)
					
					If ($vR_psx#0) & ($vR_psy#0)
						var $vT_points : Text
						$vT_points:=""
						For ($vL_p; 1; Size of array:C274($aR_ppx))
							$aR_ppx{$vL_p}:=$aR_ppx{$vL_p}*($vR_psx)
							$aR_ppy{$vL_p}:=$aR_ppy{$vL_p}*($vR_psy)
							$vT_points:=$vT_points+Replace string:C233(String:C10($aR_ppx{$vL_p}); ","; ".")+","+Replace string:C233(String:C10($aR_ppy{$vL_p}); ","; ".")+" "
						End for 
						DOM SET XML ATTRIBUTE:C866($vT_currentObject; "points"; $vT_points)
						
						$vR_ccx:=$vR_x+($vR_w/2)
						$vR_ccy:=$vR_y+($vR_h/2)
						
						$vR_ptx:=$vR_tx+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_ccx)-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_ccy)
						$vR_pty:=$vR_ty+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_ccx)+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_ccy)
						
						$vR_ptx:=Num:C11(String:C10($vR_ptx))  //remove e
						$vR_pty:=Num:C11(String:C10($vR_pty))  //remove e
						
						svgE_OBJECT_set_transform($vT_currentObject; $vR_ptx; $vR_pty; 1; 1; $vR_pr; $vR_pcx; $vR_pcy)
						
					End if 
					
				Else 
					//too thin, don't transform
				End if 
				
		End case 
		
		DOM SET XML ATTRIBUTE:C866($vT_rect; "x"; $vR_x; "y"; $vR_y; "width"; $vR_w; "height"; $vR_h)
		
		$vR_tx:=$vR_tx+(Cos:C18(($vR_r)*Degree:K30:2)*$vR_cx)-(Cos:C18((90-$vR_r)*Degree:K30:2)*$vR_cy)
		$vR_ty:=$vR_ty+(Sin:C17(($vR_r)*Degree:K30:2)*$vR_cx)+(Sin:C17((90-$vR_r)*Degree:K30:2)*$vR_cy)
		$vR_cx:=0
		$vR_cy:=0
		
		ARRAY TEXT:C222($aT_handles; 8)
		$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".tl")
		$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".tm")
		$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".tr")
		$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".ml")
		$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".mr")
		$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".bl")
		$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".bm")
		$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_currentObject; $vT_currentObject+".br")
		
		var $j : Integer
		For ($j; 1; 8)
			If ($aT_handles{$j}#$vT_xml_null)
				
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
				DOM SET XML ATTRIBUTE:C866($aT_handles{$j}; "x"; $vR_x; "y"; $vR_y)
				svgE_OBJECT_set_transform($aT_handles{$j}; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
			End if 
		End for 
	End if 
End for 

$vJ_canvas.l_clickX:=MouseX
$vJ_canvas.l_clickY:=MouseY

$0:=$isOk

