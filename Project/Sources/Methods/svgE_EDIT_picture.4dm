//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas; $vJ_history : Object
var $vP_null : Pointer
svgE_getStuff_vJ(->$vJ_canvas; $vP_null; ->$vJ_history)
var $vT_currentObject; $vT_tool : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_tool:=$vJ_canvas.t_tool

var $vP_aT_currentObjects : Pointer
$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")

var $isOk : Boolean
$isOk:=False:C215

var $vT_objectType : Text
If (Length:C16($vT_currentObject)#0)
	If ($vT_tool="IMG@")
		DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
		Case of 
			: ($vT_objectType="rect")
				$isOk:=OB Is defined:C1231($vJ_canvas; "picture")
				If ($isOk)
					var $vO_picture : Picture
					$vO_picture:=$vJ_canvas.picture
					var $vR_x; $vR_y; $vR_w; $vR_h : Real
					var $vR_r; $vR_cx; $vR_cy; $vR_sx; $vR_sy; $vR_tx; $vR_ty : Real
					//$objectType:=svgE_OBJECT_Get_transform ($vT_currentObject;->$tx;->$ty;->$sx;->$sy;->$r;->$cx;->$cy;->$x;->$y;->$w;->$h)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "width"; $vR_w)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "height"; $vR_h)
					If ($vR_w<4) & ($vR_h<4)
						$vR_w:=128
						$vR_h:=$vR_w
						$vR_x:=-($vR_w/2)
						$vR_y:=-($vR_h/2)
						DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "x"; $vR_x; "y"; $vR_y)
					End if 
					$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
					DOM REMOVE XML ELEMENT:C869($vT_currentObject)
					ARRAY TEXT:C222($vP_aT_currentObjects->; 0)
					
					$vT_currentObject:=SVG_New_embedded_image($vT_domRef; $vO_picture; $vR_x; $vR_y)
					$vJ_canvas.t_currentObject:=$vT_currentObject
					DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; $vR_w; "height"; $vR_h; "id"; $vT_currentObject)
					svgE_OBJECT_set_transform($vT_currentObject; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
					APPEND TO ARRAY:C911($vP_aT_currentObjects->; $vT_currentObject)
					OB REMOVE:C1226($vJ_canvas; "picture")
				Else 
					$isOk:=svgE_EDIT_Action_delete
					$isOk:=$isOk | svgE_SELECT_OBJ_none
					If ($isOk)
						SET CURSOR:C469(0)
					End if 
				End if 
				
				
		End case 
	End if 
End if 
$0:=$isOk

