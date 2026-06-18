//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentObject; $vT_textGuideObject; $vT_tool : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_textGuideObject:=$vJ_canvas.textGuideObject
$vT_tool:=$vJ_canvas.t_tool

var $vP_T_currentObjects : Pointer
$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")


var $vT_circleType : Text
var $vR_r; $vR_rx; $vR_ry; $vR_w; $vR_h; $vR_x; $vR_y; $vR_y1; $vR_y2; $vR_x1; $vR_x2 : Real
var $vR_scale : Real
$vR_scale:=$vL_zoom/100

var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentObject)#0)
	
	Case of 
		: ($vT_tool="CIRCLE@")
			If (Shift down:C543)
				DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_circleType)
				If ($vT_circleType="ellipse")
					DOM SET XML ELEMENT NAME:C867($vT_currentObject; "circle")
					DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "rx")
					DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "ry")
				End if 
				$vR_r:=Square root:C539((((MouseX-$vL_clickX)/$vR_scale)^2)+(((MouseY-$vL_clickY)/$vR_scale)^2))
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "r"; $vR_r)
				$isOk:=True:C214
				
			Else 
				DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_circleType)
				If ($vT_circleType="circle")
					DOM SET XML ELEMENT NAME:C867($vT_currentObject; "ellipse")
					DOM REMOVE XML ATTRIBUTE:C1084($vT_currentObject; "r")
				End if 
				$vR_rx:=Abs:C99((MouseX-$vL_clickX)/$vR_scale)
				$vR_ry:=Abs:C99((MouseY-$vL_clickY)/$vR_scale)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "rx"; $vR_rx; "ry"; $vR_ry)
				$isOk:=True:C214
			End if 
			SET TIMER:C645(1)
			
		: ($vT_tool="RECT@") | ($vT_tool="ROUND@") | ($vT_tool="TEXT@") | ($vT_tool="IMG@")
			If (Shift down:C543)
				$vR_r:=Square root:C539((((MouseX-$vL_clickX)/$vR_scale)^2)+(((MouseY-$vL_clickY)/$vR_scale)^2))
				$vR_w:=$vR_r
				$vR_h:=$vR_r
			Else 
				$vR_w:=Abs:C99((MouseX-$vL_clickX)/$vR_scale)
				$vR_h:=Abs:C99((MouseY-$vL_clickY)/$vR_scale)
			End if 
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
			var $vR_sx; $vR_sy; $vR_tx; $vR_ty : Real
			$vR_sx:=1
			$vR_sy:=1
			
			//make the center point be 0,0 like ellipse or circle
			$vR_tx:=$vR_x+($vR_w/2)
			$vR_ty:=$vR_y+($vR_h/2)
			$vR_x:=-($vR_w/2)
			$vR_y:=-($vR_h/2)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y)
			svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
			Case of 
				: ($vT_tool="TEXT@")
					DOM SET XML ATTRIBUTE:C866($vT_textGuideObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y)
					svgE_OBJECT_set_transform($vT_textGuideObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
			End case 
			
			$isOk:=True:C214
			SET TIMER:C645(1)
			
			
		: ($vT_tool="LINE@")
			$vR_w:=Abs:C99((MouseX-$vL_clickX)/$vR_scale)
			$vR_h:=Abs:C99((MouseY-$vL_clickY)/$vR_scale)
			
			Case of 
				: (MouseX>$vL_clickX) & (MouseY>$vL_clickY)  //br
					$vR_x1:=-($vR_w/2)
					$vR_x2:=-$vR_x1
					$vR_y1:=-($vR_h/2)
					$vR_y2:=-$vR_y1
					$vR_tx:=($vL_clickX/$vR_scale)+($vR_w/2)
					$vR_ty:=($vL_clickY/$vR_scale)+($vR_h/2)
					
				: (MouseX>$vL_clickX) & (MouseY<$vL_clickY)  //tr
					$vR_x1:=-($vR_w/2)
					$vR_x2:=-$vR_x1
					$vR_y2:=-($vR_h/2)
					$vR_y1:=-$vR_y2
					$vR_tx:=($vL_clickX/$vR_scale)+($vR_w/2)
					$vR_ty:=(MouseY/$vR_scale)+($vR_h/2)
					
				: (MouseX<$vL_clickX) & (MouseY>$vL_clickY)  //bl
					$vR_x2:=-($vR_w/2)
					$vR_x1:=-$vR_x2
					$vR_y1:=-($vR_h/2)
					$vR_y2:=-$vR_y1
					$vR_tx:=(MouseX/$vR_scale)+($vR_w/2)
					$vR_ty:=($vL_clickY/$vR_scale)+($vR_h/2)
					
				: (MouseX<$vL_clickX) & (MouseY<$vL_clickY)  //tl
					$vR_x2:=-($vR_w/2)
					$vR_x1:=-$vR_x2
					$vR_y2:=-($vR_h/2)
					$vR_y1:=-$vR_y2
					$vR_tx:=(MouseX/$vR_scale)+($vR_w/2)
					$vR_ty:=(MouseY/$vR_scale)+($vR_h/2)
				Else   //station
					
			End case 
			$vR_sx:=1
			$vR_sy:=1
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "x1"; $vR_x1; "x2"; $vR_x2; "y1"; $vR_y1; "y2"; $vR_y2)
			svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
			$isOk:=True:C214
			SET TIMER:C645(1)
			
		: ($vT_tool="FREELINE@")
			SVG_ADD_POINT($vT_currentObject; (MouseX-$vL_clickX)/$vR_scale; (MouseY-$vL_clickY)/$vR_scale)
			$isOk:=True:C214
			SET TIMER:C645(1)
			
			
	End case 
	
Else 
	SET TIMER:C645(0)
End if 

$0:=$isOk

