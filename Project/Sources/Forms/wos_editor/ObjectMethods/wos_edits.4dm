
var $vL_event_code : Integer
var $vJ_widget : Object
var $vT_edit : Text

$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.resize()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$vT_edit:=$vJ_widget.t_value
		
		Case of 
			: ($vT_edit="undo")
				svgE_ACTION_undo
				
			: ($vT_edit="redo")
				svgE_ACTION_redo
				
			: ($vT_edit="cut")
				svgE_ACTION_cut
				
			: ($vT_edit="copy")
				svgE_ACTION_copy
				
			: ($vT_edit="paste")
				svgE_ACTION_paste
				
			: ($vT_edit="clear")
				svgE_ACTION_delete
				
		End case 
		
End case 

