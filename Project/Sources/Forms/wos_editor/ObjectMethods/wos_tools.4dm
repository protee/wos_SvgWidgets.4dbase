
var $is_history; $isOk; $isHost : Boolean
var $vL_event_code : Integer
var $vJ_widget; $vJ_canvas : Object
var $vO_picture : Picture
var $vT_tool : Text
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.resize()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$vT_tool:=$vJ_widget.t_value
		svgE_getStuff_vJ(->$vJ_canvas)
		$vJ_canvas.t_tool:=$vT_tool
		
		$is_history:=False:C215
		$isOk:=False:C215
		//If ($tool="SELECT")
		//OB REMOVE($ob_canvas;"picture")
		//End if
		OB REMOVE:C1226($vJ_canvas; "picture")
		
		
		// PICTURE Manager
		If ($vT_tool="IMG@")
			$isOk:=False:C215
			$isHost:=Not:C34(Macintosh command down:C546 | Macintosh control down:C544)
			If ($isHost)
				$isHost:=xh_picLib_picture_get(->$vO_picture)
				$isOk:=True:C214
			End if 
			
			If (Not:C34($isHost))  // Modifiers OR no host (error)...
				READ PICTURE FILE:C678(""; $vO_picture)
				$isOk:=(OK=1)
			End if 
			
			// PLace picture
			If ($isOk)
				$isOk:=(Picture size:C356($vO_picture)#0)
			End if 
			If ($isOk)
				// Save picture for later use, and indicate something to drop on drawing
				$vJ_canvas.picture:=$vO_picture
			Else 
				$vT_tool:="SELECT"
				x_maj_wos_tools($vT_tool; $vJ_canvas)
			End if 
		End if 
		
		$isOk:=$isOk | svgE_EDIT_Text_validate
		$isOk:=$isOk | svgE_SELECT_OBJ_none
		svgE_EDIT_widgets_enabler($vT_tool)
		If ($isOk)
			svgE_FORM_canvas_redraw
			svgE_HISTORY_Append
		End if 
		
End case 

