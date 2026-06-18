//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)
var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool
var $vP_textEditArea : Pointer
$vP_textEditArea:=$vJ_canvas.ptr_text
var $vT_currentObject; $vT_currentHandle : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_currentHandle:=$vJ_canvas.currentHandle

var $vT_currentPolylineObject : Text
$vT_currentPolylineObject:=$vJ_polyline.t_currentObject

var $vP_focusObject : Pointer
$vP_focusObject:=OBJECT Get pointer:C1124(Object with focus:K67:3)


var $x; $y; $vL_buttons : Integer
GET MOUSE:C468($x; $y; $vL_buttons)

var $isOk : Boolean
$isOk:=False:C215

If (MouseX=-1) & (MouseY=-1)  //could happen on edge/on mouse move
	svgE_MOUSE_Force_update
End if 
If (MouseX#-1) & (MouseY#-1)
	If ($vP_focusObject#$vP_textEditArea)
		
		Case of 
			: ($vL_buttons=0)
				svgE_CURSOR_Update
				
			: ($vL_buttons=1)
				Case of 
					: ($vT_tool="SELECT")
						If ($vT_currentObject#"")  //object(s) selected
							Case of 
								: (Length:C16($vT_currentHandle)#0)
									$isOk:=svgE_OBJECT_Resize_update
									
								: (Length:C16($vT_currentPolylineObject)#0)
									$isOk:=svgE_OBJECT_Transform_polyline
									
								Else 
									$isOk:=svgE_OBJECT_Motion_update
									
							End case 
							
						Else 
							$isOk:=svgE_OBJECT_Select_update
						End if 
					Else 
						$isOk:=svgE_OBJECT_New_update
				End case 
		End case 
	End if 
End if 
$0:=$isOk

