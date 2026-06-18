//%attributes = {"invisible":true,"lang":"en"}

#DECLARE()->$isOk : Boolean
var $vJ_canvas : Object
var $vT_tool : Text

svgE_getStuff_vJ(->$vJ_canvas)
$vT_tool:=$vJ_canvas.t_tool

$isOk:=svgE_SELECT_Context_for_click()
If ($isOk)
	Case of 
		: ($vT_tool="SELECT")
			//$isOk:=$isOk | svgE_SELECT_Click_update
			$isOk:=svgE_SELECT_Click_update()
			svgE_EDIT_ACTIONS_enabler()
			svgE_SELECT_widgets_update()
		Else 
			$isOk:=svgE_OBJECT_New_on_click()
	End case 
End if 

