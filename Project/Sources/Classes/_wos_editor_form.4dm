
Class constructor
	This:C1470._form_init()
	// *
	// *****
	
	
	// *****
	// *
Function _form_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470._form_close(True:C214)
			
			//: ($vL_event_code=On Deactivate)
			//This._close_box()
			
		: ($vL_event_code=On Unload:K2:2)
			//wox_prefs_windows_save()
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					
				: ($vT_objectName="btn_cancel")
					This:C1470.btn_cancel()
					
				: ($vT_objectName="btn_accept")
					This:C1470.btn_accept()
					
			End case 
			
		: ($vL_event_code=On Timer:K2:25)
			SET TIMER:C645(0)
			
			This:C1470.resize()
			This:C1470.redraw()
			
		: ($vL_event_code=On Resize:K2:27)  // DONE
			SET TIMER:C645(3)  // Let the time to redraw the window until the user continue to change the window's size
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _form_init()
	var $vL_width; $vL_height; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_diff_x; $vL_diff_y : Integer
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.get_widget_size(->$vL_width; ->$vL_height)
	var $vT_wos_editor : Text
	var $vJ_wos_editor : Object
	$vT_wos_editor:="wos_editor"
	OBJECT GET COORDINATES:C663(*; $vT_wos_editor; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_diff_x:=$vL_width-($vL_right-$vL_left)
	$vL_diff_y:=$vL_height-($vL_bottom-$vL_top)
	RESIZE FORM WINDOW:C890($vL_diff_x; $vL_diff_y)
	
	
Function _form_close()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	Form:C1466.is_modified:=$vJ_wos_editor.is_modified
	CANCEL:C270
	
	
Function btn_accept()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	Form:C1466.is_modified:=$vJ_wos_editor.is_modified
	Form:C1466.t_svg:=$vJ_wos_editor.get_svg()
	ACCEPT:C269
	
	
Function btn_cancel()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	Form:C1466.is_modified:=$vJ_wos_editor.is_modified
	CANCEL:C270
	
	
	// *****
	// *
Function get_wos_editor()->$vJ_wos_editor : Object
	var $vT_wos_editor : Text
	$vT_wos_editor:="wos_editor"
	$vJ_wos_editor:=OBJECT Get value:C1743($vT_wos_editor)
	
	
Function resize()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.resize()
	
Function redraw()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.redraw()
	// *
	// *****
	
	