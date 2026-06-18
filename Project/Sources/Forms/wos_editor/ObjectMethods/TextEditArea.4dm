
var $isOk : Boolean
var $vL_zoom; $vL_event : Integer
var $vJ_canvas; $vJ_wos_text : Object
var $vP_textEditArea : Pointer
var $vR_scale : Real
svgE_getStuff_vJ(->$vJ_canvas)
$vP_textEditArea:=$vJ_canvas.ptr_text

$vL_zoom:=$vJ_canvas.l_zoom
$vR_scale:=$vL_zoom/100


$vL_event:=Form event code:C388
$isOk:=False:C215

Case of 
	: ($vL_event=On Getting Focus:K2:7)
		$vJ_canvas.editedText_old:=$vP_textEditArea->
		//set the attributes according to the current selection
		$vJ_wos_text:=wos_getWidget("wos_text")
		OBJECT SET FONT:C164($vP_textEditArea->; $vJ_wos_text.t_face)
		OBJECT SET FONT SIZE:C165($vP_textEditArea->; $vJ_wos_text.l_size*$vR_scale)
		
		
	: ($vL_event=On After Edit:K2:43)
		$vJ_canvas.editedText_new:=Get edited text:C655
		// /set selection attributes according to the current values
		//$vJ_font:=wos_getWidget("wos_text")
		//$vJ_font.face:=OBJECT Get font($vP_textEditArea->)
		//$vJ_font.size:=OBJECT Get font size($vP_textEditArea->)
		
		//$isOk:=svgE_OBJECT_text_set_attributes
		//If ($isOk)
		//svgE_FORM_canvas_redraw
		//svgE_HISTORY_Append
		//End if
		
		
	: ($vL_event=On Losing Focus:K2:8)
		$vJ_canvas.editedText_new:=$vP_textEditArea->
		$isOk:=svgE_EDIT_Text_validate()
		
End case 

If ($isOk)
	svgE_FORM_canvas_redraw()
	svgE_CURSOR_Update()
	svgE_HISTORY_Append()
End if 

