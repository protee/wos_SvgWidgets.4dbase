//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool
var $vP_textEditArea : Pointer
$vP_textEditArea:=$vJ_canvas.ptr_text

var $vP_focusObject : Pointer
$vP_focusObject:=OBJECT Get pointer:C1124(Object with focus:K67:3)


var $x; $y; $vL_b : Integer
GET MOUSE:C468($x; $y; $vL_b)

If ($vP_focusObject#$vP_textEditArea)
	
	Case of 
		: ($vL_b=0)
			
			Case of 
				: ($vT_tool="SELECT")
					$vJ_canvas.t_currentObject_old:=$vJ_canvas.t_currentObject
					$vJ_canvas.t_currentObject:=""
			End case 
			
	End case 
End if 

$vJ_canvas.is_cursorOut:=True:C214

