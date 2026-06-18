
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
	var $vT_file_name : Text
	wox_prefs_windows_load()
	$vT_file_name:="header_p3.svg"
	Form:C1466.t_fileName:=$vT_file_name
	
	
	//$vT_file_path:=Get 4D folder(Current resources folder)+"TestData"+Folder separator+"ogSvgEditor.svg"
	//DOCUMENT TO BLOB($vT_file_path; $vX_SVGPicture)
	//$vT_svg:=Convert to text($vX_SVGPicture; kMCSU_CharEnc_UTF_8)
	//$vJ_wos_editor.set_svg($vT_svg)
	//This.resize()
	//This.redraw()
	
	
Function _form_close()
	CANCEL:C270
	
	
Function btn_accept()
	var $vJ_wos_editor : Object
	var $vT_svg; $vT_file_name : Text
	var $c4Fi_svg : 4D:C1709.File
	var $c4Fo_path : 4D:C1709.Folder
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	If ($vJ_wos_editor#Null:C1517)
		$vT_svg:=$vJ_wos_editor.get_svg()
		$vT_file_name:=Form:C1466.t_fileName
		$c4Fo_path:=This:C1470.get_path()
		$c4Fi_svg:=$c4Fo_path.file($vT_file_name)
		$c4Fi_svg.setText($vT_svg)
	End if 
	ACCEPT:C269
	
Function btn_cancel()
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
	$vT_file_name:=Form:C1466.t_fileName
	// The widget even do not exist before being once in page 3! 4D shitty
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vR_coefficient:=4  // milimetres to pixels
	$vR_paper_width:=210*$vR_coefficient  // In mm
	$vR_paper_height:=60*$vR_coefficient  // In mm
	//wos_svgEdit_paper_fit ($vR_paper_width/$vR_paper_height;->$vR_paper_width;->$vR_paper_height;$vT_wos_editor)
	//wos_svgEdit_paper_calculate($vJ_wos_editor; $vR_paper_width; $vR_paper_height; 0; 1)
	$vJ_wos_editor.paper_fit($vR_paper_width/$vR_paper_height; ->$vR_paper_width; ->$vR_paper_height)
	$vJ_wos_editor.paper_calculate($vR_paper_width; $vR_paper_height; 0; 1)
	This:C1470.open()
	
	
	
	//Function load_file()
	//var $vJ_wos_editor : Object
	//var $vT_file_name; $vT_svg : Text
	//var $c4Fi_svg : 4D.File
	//var $c4Fo_path : 4D.Folder
	//$vT_file_name:=Form.t_fileName
	//$c4Fo_path:=This.get_path()
	//$c4Fi_svg:=$c4Fo_path.file($vT_file_name)
	//$vT_svg:=$c4Fi_svg.getText()
	
	//$vJ_wos_editor.set_svg($vT_svg)
	//$vP:=OBJECT Get pointer(Object named; "letterHead")
	//READ PICTURE FILE($vT_file_path; $vP->)
	
	
Function choose_file()
	var $vL_action : Integer
	var $vT_file_name : Text
	var $c4Fo_path : 4D:C1709.Folder
	var $vC_aj_files; $vC_at_files : Collection
	$c4Fo_path:=This:C1470.get_path()
	$vC_aj_files:=$c4Fo_path.files()
	$vC_at_files:=$vC_aj_files.extract("fullName")
	$vC_at_files:=$vC_at_files.orderBy()
	$vT_file_name:=Form:C1466.t_fileName
	$vL_action:=$vC_at_files.indexOf($vT_file_name)
	ARRAY TEXT:C222($aT_files; 0)
	COLLECTION TO ARRAY:C1562($vC_at_files; $aT_files)
	If (x_btnPopup_choice(->$vL_action; ""; ->$aT_files))
		$vT_file_name:=$vC_at_files[$vL_action]
		Form:C1466.t_fileName:=$vT_file_name
		This:C1470.open()
	End if 
	
	
Function get_path()->$c4Fo_path : 4D:C1709.Folder
	$c4Fo_path:=Folder:C1567(fk resources folder:K87:11).folder("TestData")
	
	
Function open()
	var $vJ_wos_editor : Object
	var $vT_file_name; $vT_svg : Text
	var $c4Fi_svg : 4D:C1709.File
	var $c4Fo_path : 4D:C1709.Folder
	$c4Fo_path:=This:C1470.get_path()
	$vT_file_name:=Form:C1466.t_fileName
	$c4Fi_svg:=$c4Fo_path.file($vT_file_name)
	$vT_svg:=$c4Fi_svg.getText()
	$vJ_wos_editor:=This:C1470.get_wos_editor()
	$vJ_wos_editor.set_svg($vT_svg)
	$vJ_wos_editor.resize()
	$vJ_wos_editor.redraw()
	
	//$vP:=OBJECT Get pointer(Object named; "letterHead")
	//READ PICTURE FILE($vT_file_path; $vP->)
	
	
	//Function wos_edit()
	//$vJ_params:=New object
	////$ob.is_editing:=true
	//$vJ_params.is_toolsOnTop:=True
	//$vJ_params.is_palettes:=True
	
	//$vJ_params.j_paper:=New object
	//$vJ_params.j_margin:=New object
	////$vJ_widget.reserved:=New object
	
	//$vR_coef:=1  //2.9
	//$vJ_params.windowType:=Plain form window
	
	//$vR_coefficient:=5  // milimetres to pixels
	//$vR_paper_width:=210*$vR_coefficient  // In mm
	//$vR_paper_height:=30*$vR_coefficient  // In mm
	//$vT_wos_editor:="wos_editor"
	//wos_svgEdit_paper_fit($vR_paper_width/$vR_paper_height; ->$vR_paper_width; ->$vR_paper_height; $vT_wos_editor)
	
	//$vJ_wos_editor:=This.get_wos_editor()
	//wos_svgEdit_paper_calculate($vJ_wos_editor; $vR_paper_width; $vR_paper_height; 0.01; 1)
	
	
	//var $vT_file_name; $vT_file_path; $vT_wos_editor; $vT_path : Text
	//$vT_file_name:=Form.t_fileName
	//$vT_file_path:=$vT_path+$vT_file_name
	//var $vX_SVGPicture : Blob
	//DOCUMENT TO BLOB($vT_file_path; $vX_SVGPicture)
	//$vJ_params.t_svg:=Convert to text($vX_SVGPicture; kMCSU_CharEnc_UTF_8)
	//var $isOk : Boolean
	//var $vJ_params; $vJ_wos_editor : Object
	//var $vP : Pointer
	//var $vR_coef; $vR_coefficient; $vR_paper_width; $vR_paper_height : Real
	//$isOk:=wos_editor_form($vJ_params)
	//If ($isOk)
	//TEXT TO DOCUMENT($vT_file_path; $vJ_params.t_svg)
	//$vP:=OBJECT Get pointer(Object named; "letterHead")
	//READ PICTURE FILE($vT_file_path; $vP->)
	//End if 
	