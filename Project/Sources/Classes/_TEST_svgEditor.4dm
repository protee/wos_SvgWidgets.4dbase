
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
			This:C1470._form_close()
			
			//: ($vL_event_code=On Deactivate)
			//This._close_box()
			
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="is_editing")
					This:C1470.is_editing($vT_objectName)
				: ($vT_objectName="is_toolsOnTop")
					This:C1470.is_toolsOnTop($vT_objectName)
				: ($vT_objectName="is_palettes")
					This:C1470.is_palettes($vT_objectName)
				: ($vT_objectName="is_palettesOnTop")
					This:C1470.is_palettesOnTop($vT_objectName)
				: ($vT_objectName="is_visibility")
					This:C1470.is_visibility($vT_objectName)
				: ($vT_objectName="is_sticky")
					This:C1470.is_sticky($vT_objectName)
					
				: ($vT_objectName="btn_canvas")
					This:C1470.btn_canvas()
				: ($vT_objectName="btn_wh_mini")
					This:C1470.btn_wh_mini()
				: ($vT_objectName="btn_wh_resize")
					This:C1470.btn_wh_resize()
				: ($vT_objectName="btn_clear")
					This:C1470.btn_clear()
				: ($vT_objectName="btn_is_modified")
					This:C1470.btn_is_modified()
					
					
				: ($vT_objectName="btn_menu")
					This:C1470._menu()
					
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
	var $vJ_wos_editor : Object
	var $vT_svg : Text
	var $c4Fi_svg : 4D:C1709.File
	wox_prefs_windows_load()
	
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	OBJECT SET VALUE:C1742("is_editing"; Num:C11($vJ_wos_editor.is_editing))
	OBJECT SET VALUE:C1742("is_toolsOnTop"; Num:C11($vJ_wos_editor.is_toolsOnTop))
	OBJECT SET VALUE:C1742("is_palettes"; Num:C11($vJ_wos_editor.is_palettes))
	OBJECT SET VALUE:C1742("is_palettesOnTop"; Num:C11($vJ_wos_editor.is_palettesOnTop))
	OBJECT SET VALUE:C1742("is_visibility"; Num:C11($vJ_wos_editor.is_visibility))
	OBJECT SET VALUE:C1742("is_sticky"; Num:C11($vJ_wos_editor.is_sticky))
	
	$c4Fi_svg:=Folder:C1567(fk resources folder:K87:11).file("TestData/ogSvgEditor.svg")
	$vT_svg:=$c4Fi_svg.getText()
	$vJ_wos_editor.set_svg($vT_svg)
	This:C1470.resize()
	This:C1470.redraw()
	
	
Function _form_close()
	CANCEL:C270
	
Function btn_accept()
	var $vT_svg : Text
	var $vJ_wos_editor : Object
	var $c4Fi_svg : 4D:C1709.File
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vT_svg:=$vJ_wos_editor.get_svg()
	$c4Fi_svg:=Folder:C1567(fk resources folder:K87:11).file("TestData/ogSvgEditor.svg")
	$c4Fi_svg.setText($vT_svg)
	ACCEPT:C269
	
Function btn_cancel()
	CANCEL:C270
	
Function _menu()
	var $vL_action; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height : Integer
	var $vO_img : Picture
	var $vP_widget : Pointer
	ARRAY TEXT:C222($aT_widgets_name; 0)
	ARRAY POINTER:C280($aP_widgets; 0)
	y_getFormWidgets(->$aT_widgets_name; ->$aP_widgets)
	
	$vL_action:=-1
	If (x_btnPopup_choice(->$vL_action; ""; ->$aT_widgets_name))
		FORM SCREENSHOT:C940($vO_img)
		$vP_widget:=$aP_widgets{$vL_action+1}
		OBJECT GET COORDINATES:C663($vP_widget->; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_width:=$vL_right-$vL_left
		$vL_height:=$vL_bottom-$vL_top
		TRANSFORM PICTURE:C988($vO_img; Crop:K61:7; $vL_left-1; $vL_top-1; $vL_width+2; $vL_height+2)
		//WRITE PICTURE FILE($path+$property+".png";$img)
		SET PICTURE TO PASTEBOARD:C521($vO_img)
	End if 
	
	
	// *****
	// *
Function is_editing($vT_objectName : Text)
	var $is_editable : Boolean
	var $vJ_wos_editor : Object
	var $vP_object : Pointer
	$vP_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_editable:=($vP_object->=1)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.is_editing:=$is_editable
	This:C1470.redraw()
	
Function is_toolsOnTop($vT_objectName : Text)
	var $is_toolsOnTop : Boolean
	var $vJ_wos_editor : Object
	var $vP_object : Pointer
	$vP_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_toolsOnTop:=($vP_object->=1)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.is_toolsOnTop:=$is_toolsOnTop
	This:C1470.resize()
	This:C1470.redraw()
	
Function is_palettes($vT_objectName : Text)
	var $is_palettes : Boolean
	var $vJ_wos_editor : Object
	var $vP_object : Pointer
	$vP_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_palettes:=($vP_object->=1)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.is_palettes:=$is_palettes
	This:C1470.resize()
	This:C1470.redraw()
	
Function is_palettesOnTop($vT_objectName : Text)
	var $is_palettesOnTop : Boolean
	var $vJ_wos_editor : Object
	var $vP_object : Pointer
	$vP_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_palettesOnTop:=($vP_object->=1)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.is_palettesOnTop:=$is_palettesOnTop
	This:C1470.resize()
	This:C1470.redraw()
	
Function is_visibility($vT_objectName : Text)
	var $is_visibility : Boolean
	var $vJ_wos_editor : Object
	var $vP_object : Pointer
	$vP_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_visibility:=($vP_object->=1)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.is_visibility:=$is_visibility
	This:C1470.resize()
	This:C1470.redraw()
	
Function is_sticky($vT_objectName : Text)
	var $is_sticky : Boolean
	var $vJ_wos_editor : Object
	var $vP_object : Pointer
	$vP_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_sticky:=($vP_object->=1)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.is_sticky:=$is_sticky
	This:C1470.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function get_wos_editor()->$vJ_wos_editor : Object
	var $vT_wos_editor : Text
	$vT_wos_editor:="wos_editor"
	$vJ_wos_editor:=OBJECT Get value:C1743($vT_wos_editor)
	
	
Function redraw()
	var $vT_wos_editor : Text
	var $vJ_widget : Object
	$vT_wos_editor:="wos_editor"
	$vJ_widget:=wos_getWidget($vT_wos_editor)
	$vJ_widget.redraw()
	
Function resize()
	var $vT_wos_editor : Text
	var $vJ_widget : Object
	$vT_wos_editor:="wos_editor"
	$vJ_widget:=wos_getWidget($vT_wos_editor)
	$vJ_widget.resize()
	//$vJ_widget.redraw()
	// *
	// *****
	
	
	
Function btn_canvas()
	var $vL_width; $vL_height : Integer
	var $vJ_wos_editor : Object
	//$vT_wos_editor:="wos_editor"
	//wos_svgEdit_get_canvasSize(->$vL_width; ->$vL_height; $vT_wos_editor)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.get_canvas_wh(->$vL_width; ->$vL_height)
	wox_io_alert_popup("W:"+String:C10($vL_width)+" H:"+String:C10($vL_height))
	
Function btn_wh_mini()
	var $vL_width; $vL_height : Integer
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.get_widget_size(->$vL_width; ->$vL_height)
	wox_io_alert_popup("W:"+String:C10($vL_width)+" H:"+String:C10($vL_height))
	
	
Function btn_wh_resize()
	var $vL_width; $vL_height; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_diff_x; $vL_diff_y : Integer
	var $vT_wos_editor : Text
	var $vJ_wos_editor : Object
	//wos_svgEdit_get_widgetSize(->$vL_width; ->$vL_height; $vT_wos_editor)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.get_widget_size(->$vL_width; ->$vL_height)
	$vT_wos_editor:="wos_editor"
	OBJECT GET COORDINATES:C663(*; $vT_wos_editor; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_diff_x:=$vL_width-($vL_right-$vL_left)
	$vL_diff_y:=$vL_height-($vL_bottom-$vL_top)
	RESIZE FORM WINDOW:C890($vL_diff_x; $vL_diff_y)
	
Function btn_clear()
	var $vJ_wos_editor : Object
	var $vT_wos_editor : Text
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.set_svg(""; $vT_wos_editor)
	This:C1470.redraw()
	
Function btn_is_modified()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	wox_io_alert_popup("Modified "+String:C10($vJ_wos_editor.is_modified))
	