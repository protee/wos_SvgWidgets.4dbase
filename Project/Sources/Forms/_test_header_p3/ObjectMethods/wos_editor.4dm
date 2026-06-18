
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=-On Load:K2:1)  // WILL BE TRIGGERED ONLY ONCE!
		$vJ_widget:=Self:C308->
		$vJ_widget.is_domToClose:=False:C215
		// TO LET YOU NAVIGATE BETWEEN PAGES
		// DON'T FORGET TO REMOVE THE DOM in exit of the Form
		// With $vJ_widget.xml_dom_close()
		Form:C1466.fc.svg_load()
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=On Unload:K2:2)  // WILL BE TRIGGERED ONLY ONCE!
		$vJ_widget:=Self:C308->
		$vJ_widget.xml_dom_close()
		
		
End case 

