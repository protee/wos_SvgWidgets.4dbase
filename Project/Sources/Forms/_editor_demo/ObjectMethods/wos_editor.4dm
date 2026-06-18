
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_wos_editor : Object
		$vJ_wos_editor:=Self:C308->
		// Changes all those properties in widget if exist in Form ; else default
		wox_vJ_overload(Form:C1466; $vJ_wos_editor; "is_editing"; "is_toolsOnTop"; "is_palettes"; "is_sticky")
		
		$vJ_wos_editor.resize()
		$vJ_wos_editor.redraw()
		
		
		//: ($evt=On Data Change)
		//C_OBJECT($ob_widget)
		//$ob_widget:=Self->
		
End case 



