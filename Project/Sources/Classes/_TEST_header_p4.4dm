
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
				: ($vT_objectName="btn_choose")
					This:C1470.choose_file()
					
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
	var $vX_SVGPicture : Blob
	var $vJ_wos_editor : Object
	var $vT_file_path; $vT_svg : Text
	wox_prefs_windows_load()
	
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	OBJECT SET VALUE:C1742("is_editing"; Num:C11($vJ_wos_editor.is_editing))
	OBJECT SET VALUE:C1742("is_toolsOnTop"; Num:C11($vJ_wos_editor.is_toolsOnTop))
	OBJECT SET VALUE:C1742("is_palettes"; Num:C11($vJ_wos_editor.is_palettes))
	OBJECT SET VALUE:C1742("is_palettesOnTop"; Num:C11($vJ_wos_editor.is_palettesOnTop))
	OBJECT SET VALUE:C1742("is_visibility"; Num:C11($vJ_wos_editor.is_visibility))
	OBJECT SET VALUE:C1742("is_sticky"; Num:C11($vJ_wos_editor.is_sticky))
	
	$vT_file_path:=Get 4D folder:C485(Current resources folder:K5:16)+"TestData"+Folder separator:K24:12+"ogSvgEditor.svg"
	DOCUMENT TO BLOB:C525($vT_file_path; $vX_SVGPicture)
	$vT_svg:=Convert to text:C1012($vX_SVGPicture; kMCSU_CharEnc_UTF_8)
	$vJ_wos_editor.set_svg($vT_svg)
	This:C1470.resize()
	This:C1470.redraw()
	
	
Function _form_close()
	var $isOk : Boolean
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$isOk:=$vJ_wos_editor.xml_dom_close()  // Close the dom
	CANCEL:C270
	
	
Function btn_accept()
	var $isOk : Boolean
	var $vJ_wos_editor; $vJ_wos_editor : Object
	var $vT_svg; $vT_path; $vT_file_name; $vT_file_path : Text
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vT_svg:=$vJ_wos_editor.get_svg()
	$vT_path:=Get 4D folder:C485(Current resources folder:K5:16)+"TestData"+Folder separator:K24:12
	$vT_file_name:=Form:C1466.fileName
	$vT_file_path:=$vT_path+$vT_file_name
	TEXT TO DOCUMENT:C1237($vT_file_path; $vT_svg)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$isOk:=$vJ_wos_editor.xml_dom_close()  // Close the dom
	ACCEPT:C269
	
Function btn_cancel()
	var $isOk : Boolean
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$isOk:=$vJ_wos_editor.xml_dom_close()  // Close the dom
	CANCEL:C270
	
	
	
	// *****
	// *
Function get_wos_editor()->$vJ_wos_editor : Object
	var $vT_wos_editor : Text
	$vT_wos_editor:="wos_editor"
	$vJ_wos_editor:=OBJECT Get value:C1743($vT_wos_editor)
	
	
Function redraw()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.redraw()
	
Function resize()
	var $vJ_wos_editor : Object
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.resize()
	// *
	// *****
	
	
Function svg_load()
	var $vJ_wos_editor : Object
	var $vR_coefficient; $vR_paper_width; $vR_paper_height : Real
	var $vT_file_name : Text
	$vT_file_name:="header_p3.svg"
	Form:C1466.fileName:=$vT_file_name
	
	// The widget even do not exist before being once in page 3! 4D shitty
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vR_coefficient:=4  // milimetres to pixels
	$vR_paper_width:=210*$vR_coefficient  // In mm
	$vR_paper_height:=30*$vR_coefficient  // In mm
	//wos_svgEdit_paper_fit ($vR_paper_width/$vR_paper_height;->$vR_paper_width;->$vR_paper_height;$vT_wos_editor)
	//wos_svgEdit_paper_calculate($vJ_wos_editor; $vR_paper_width; $vR_paper_height; 0; 1)
	$vJ_wos_editor.paper_calculate($vR_paper_width; $vR_paper_height; 0; 1)
	$vJ_wos_editor.resize()
	$vJ_wos_editor.redraw()
	This:C1470.open()
	
	
	
Function load_file()
	var $vJ_wos_editor : Object
	var $vP : Pointer
	var $vT_file_name; $vT_file_path; $vT_path; $vT_svg : Text
	$vT_file_name:=Form:C1466.fileName
	$vT_file_path:=$vT_path+$vT_file_name
	$vT_svg:=Document to text:C1236($vT_file_path)
	$vJ_wos_editor.set_svg($vT_svg)
	$vP:=OBJECT Get pointer:C1124(Object named:K67:5; "letterHead")
	READ PICTURE FILE:C678($vT_file_path; $vP->)
	
	
Function choose_file()
	var $vL_action : Integer
	var $vJ_wos_editor : Object
	var $vT_path; $vT_file_name; $vT_file_path; $vT_svg : Text
	$vT_path:=This:C1470.get_path()
	ARRAY TEXT:C222($aT_files; 0)
	DOCUMENT LIST:C474($vT_path; $aT_files)
	SORT ARRAY:C229($aT_files)
	$vL_action:=Find in array:C230($aT_files; "")-1
	If (x_btnPopup_choice(->$vL_action; ""; ->$aT_files))
		$vT_file_name:=$aT_files{$vL_action+1}
		Form:C1466.fileName:=$vT_file_name
		$vT_file_path:=$vT_path+$vT_file_name
		$vT_svg:=Document to text:C1236($vT_file_path)
		$vJ_wos_editor:=This:C1470.get_wos_editor()
		$vJ_wos_editor.set_svg($vT_svg)
	End if 
	
	
Function get_path()->$vT_path : Text
	$vT_path:=Get 4D folder:C485(Current resources folder:K5:16)+"TestData"+Folder separator:K24:12
	
	
Function open()
	var $vJ_wos_editor : Object
	var $vP : Pointer
	var $vT_path; $vT_file_name; $vT_file_path; $vT_svg : Text
	$vT_path:=This:C1470.get_path()
	$vT_file_name:=Form:C1466.fileName
	$vT_file_path:=$vT_path+$vT_file_name
	$vT_svg:=Document to text:C1236($vT_file_path)
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.set_svg($vT_svg)
	
	$vP:=OBJECT Get pointer:C1124(Object named:K67:5; "letterHead")
	READ PICTURE FILE:C678($vT_file_path; $vP->)
	
	
Function wos_edit()
	$vJ_params:=New object:C1471
	//$ob.is_editing:=true
	$vJ_params.is_toolsOnTop:=True:C214
	$vJ_params.is_palettes:=True:C214
	
	$vJ_params.j_paper:=New object:C1471
	$vJ_params.j_margin:=New object:C1471
	//$vJ_widget.reserved:=New object
	
	$vR_coef:=1  //2.9
	$vJ_params.windowType:=Plain form window:K39:10
	
	$vR_coefficient:=5  // milimetres to pixels
	$vR_paper_width:=210*$vR_coefficient  // In mm
	$vR_paper_height:=30*$vR_coefficient  // In mm
	$vT_wos_editor:="wos_editor"
	wos_svgEdit_paper_fit($vR_paper_width/$vR_paper_height; ->$vR_paper_width; ->$vR_paper_height; $vT_wos_editor)
	
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	wos_svgEdit_paper_calculate($vJ_wos_editor; $vR_paper_width; $vR_paper_height; 0.01; 1)
	
	
	var $vT_file_name; $vT_file_path; $vT_wos_editor; $vT_path : Text
	$vT_file_name:=Form:C1466.fileName
	$vT_file_path:=$vT_path+$vT_file_name
	var $vX_SVGPicture : Blob
	DOCUMENT TO BLOB:C525($vT_file_path; $vX_SVGPicture)
	$vJ_params.t_svg:=Convert to text:C1012($vX_SVGPicture; kMCSU_CharEnc_UTF_8)
	var $isOk : Boolean
	var $vJ_params; $vJ_wos_editor : Object
	var $vP : Pointer
	var $vR_coef; $vR_coefficient; $vR_paper_width; $vR_paper_height : Real
	$isOk:=wos_editor_form($vJ_params)
	If ($isOk)
		TEXT TO DOCUMENT:C1237($vT_file_path; $vJ_params.t_svg)
		$vP:=OBJECT Get pointer:C1124(Object named:K67:5; "letterHead")
		READ PICTURE FILE:C678($vT_file_path; $vP->)
	End if 
	