//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool

var $isOk : Boolean
$isOk:=svgE_SELECT_Context_for_click

Case of 
	: ($vT_tool="SELECT")
		$isOk:=$isOk | svgE_SELECT_Click_update
		svgE_EDIT_ACTIONS_enabler
		svgE_SELECT_widgets_update
		
		Case of 
			: (svgE_EDIT_Polyline)
				$isOk:=True:C214
				
			: (svgE_EDIT_Text)
				$isOk:=True:C214
				
		End case 
		
End case 

$0:=$isOk

