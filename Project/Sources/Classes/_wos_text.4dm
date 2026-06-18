// *****
// *
// Class: _wos_cap
// Olivier Grimbert — Protée sarl — 20/04/2026 16:30:12
//
// Description: 
//
// Date       | Who | Comment
// 20/04/2026 | OG  | Updated
// *
// *****

Class extends _WIDGETS

Class constructor
	Super:C1705("j_text")
	This:C1470._init()
	//This.at_events:=New collection()
	
Function getSize($vT_layout : Text; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $vL_tight_height; $vL_width; $vL_height : Integer
	$vL_tight_height:=88
	Case of 
		: ($vT_layout="tight")
			$vL_width:=220
			$vL_height:=$vL_tight_height
		Else 
			$vL_width:=265
			$vL_height:=140
	End case 
	$vP_vL_width->:=$vL_width
	$vP_vL_height->:=$vL_height
	
	
Function _unload()
	var $vP_fontface_PU : Pointer
	Case of 
			//: (Is Windows)
		: ($vP_fontface_PU=Null:C1517)
		: (Not:C34(Is a list:C621($vP_fontface_PU->)))
		Else 
			CLEAR LIST:C377($vP_fontface_PU->)
	End case 
	
	
	
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
		: ($vL_event_code=On Unload:K2:2)
			This:C1470._unload()
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="@_CB")
					This:C1470._style_clicked($vT_objectName)
					
				: ($vT_objectName="@_RB")
					This:C1470._align_clicked($vT_objectName)
					
			End case 
	End case 
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _init()
	var $vC_at_objects; $vC_col_sizes : Collection
	var $vL_ListRef; $tt; $i; $vL_ItemRef : Integer
	var $vP_fontface_PU; $vP_fontSize_PU : Pointer
	var $vT_face; $vT_fontName; $vT_size_txt; $vT_col_size : Text
	$vC_at_objects:=New collection:C1472()
	$vC_at_objects.push("bold_CB"; "italic_CB"; "underline_CB"; "strike_CB")
	This:C1470._at_styles:=$vC_at_objects
	$vC_at_objects:=New collection:C1472()
	$vC_at_objects.push("alignLeft_RB"; "alignCenter_RB"; "alignRight_RB")
	This:C1470._at_aligns:=$vC_at_objects
	
	
	$vP_fontface_PU:=OBJECT Get pointer:C1124(Object named:K67:5; "fontface_PU")
	ARRAY TEXT:C222($aT_FontName; 0)
	FONT LIST:C460($aT_FontName)
	//If (Is macOS) //& false
	//$face:="Arial"
	//Form.face:=$face
	$vT_face:=This:C1470.t_face
	
	//Use a hierarchical list with font family applied to each item.
	//OBJECT SET FONT SIZE($vP_FontNamePU->;14)
	$vL_ListRef:=New list:C375
	$tt:=Size of array:C274($aT_FontName)
	For ($i; 1; $tt)
		$vT_fontName:=$aT_FontName{$i}
		APPEND TO LIST:C376($vL_ListRef; $vT_fontName; $i)
		SET LIST ITEM FONT:C953($vL_ListRef; 0; $vT_fontName)
	End for 
	
	//Separator line between current font (if any - inserted below) and list of fonts.
	INSERT IN LIST:C625($vL_ListRef; 1; "-"; -10)
	//Locate and select the default font in the list.
	$vL_ItemRef:=Find in list:C952($vL_ListRef; $vT_face; 0; *)
	If ($vL_ItemRef>0)
		SELECT LIST ITEMS BY REFERENCE:C630($vL_ListRef; $vL_ItemRef)
		INSERT IN LIST:C625($vL_ListRef; -10; $vT_face; -100)
		SET LIST ITEM FONT:C953($vL_ListRef; 0; $vT_face)
	End if 
	OBJECT SET LIST BY REFERENCE:C1266($vP_fontface_PU->; Choice list:K42:19; $vL_ListRef)
	
	//Else
	//  //Windows
	//$face:="Segoe UI"
	//Form.face:=$face
	//COPY ARRAY($aT_FontName;$vP_FontNamePU->)
	//End if
	
	$vP_fontSize_PU:=OBJECT Get pointer:C1124(Object named:K67:5; "fontsize_PU")
	ARRAY LONGINT:C221($vP_fontSize_PU->; 0)
	$vT_size_txt:="6,7,8,9,10,11,12,13,14,16,18,20,22,24,26,28,32,36,48,72"
	$vC_col_sizes:=Split string:C1554($vT_size_txt; ",")
	For each ($vT_col_size; $vC_col_sizes)
		APPEND TO ARRAY:C911($vP_fontSize_PU->; Num:C11($vT_col_size))
	End for each 
	
	
Function _resize()
	var $vL_width; $vL_height; $vL_h; $y : Integer
	var $vL_yt; $vL_yb; $vL_xr; $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	var $xl; $x1; $vL_left_x; $vL_right_x : Integer
	var $vL_w; $x2 : Integer
	var $vL_option; $vL_btn_size; $idx : Integer
	var $is_tight; $is_basic : Boolean
	var $vJ_woc_colour : Object
	var $vT_woc_colour; $vT_ot_opacity : Text
	var $vT_ot_face; $vT_ot_size; $vT_ot_style; $vT_ot_align; $txt; $vT_object : Text
	var $vP_ruler; $vP_fontface_PU; $vP_fontSize_PU : Pointer
	var $vC_at_objects : Collection
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vP_fontface_PU:=OBJECT Get pointer:C1124(Object named:K67:5; "fontface_PU")
	$vP_fontSize_PU:=OBJECT Get pointer:C1124(Object named:K67:5; "fontsize_PU")
	$vT_woc_colour:="woc_colour"
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "opacity_rlr")
	
	w_resize_groups($vL_width; $vL_height; ->$vL_yt; ->$vL_yb)
	$xl:=2
	$vL_xr:=$vL_width-6
	
	$vT_ot_face:="ot_face"
	$vT_ot_size:="ot_size"
	$vT_ot_opacity:="ot_opacity"
	$vT_ot_style:="ot_style"
	$vT_ot_align:="ot_align"
	
	$is_tight:=($vL_height<110)
	$is_basic:=Not:C34($is_tight)
	OBJECT SET VISIBLE:C603(*; $vT_ot_face; $is_basic)
	OBJECT SET VISIBLE:C603(*; $vT_ot_size; $is_basic)
	OBJECT SET VISIBLE:C603(*; $vT_ot_opacity; $is_basic)
	OBJECT SET VISIBLE:C603(*; $vT_ot_style; $is_basic)
	OBJECT SET VISIBLE:C603(*; $vT_ot_align; $is_basic)
	
	$vL_option:=0x0020  // +10 ruler ; +15 graduation ; +25 labels
	If (True:C214)
		$vL_option:=$vL_option ?+ 4  // Graduation
	End if 
	If ($is_basic)
		$vL_option:=$vL_option ?+ 1  // Labels
	End if 
	$txt:="0;100;25;1;"+String:C10($vL_option)+";##0"
	OBJECT SET FORMAT:C236($vP_ruler->; $txt)
	
	$vL_btn_size:=20
	If ($is_tight)
		OBJECT GET COORDINATES:C663($vP_fontSize_PU->; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		$x1:=$vL_xr-$vL_w
		OBJECT GET COORDINATES:C663($vP_fontface_PU->; $vL_left_x; $vL_top; $vL_right_x; $vL_bottom)
		OBJECT SET COORDINATES:C1248($vP_fontface_PU->; $xl; $vL_top; $x1-2; $vL_bottom)
		OBJECT SET COORDINATES:C1248($vP_fontSize_PU->; $x1; $vL_top; $vL_xr; $vL_bottom)
		
		$x1:=$xl+2
		$x2:=$x1+20
		$vL_h:=20
		OBJECT GET COORDINATES:C663(*; $vT_woc_colour; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_woc_colour; $x1; $vL_top; $x2; $vL_bottom)
		$y:=$vL_top
		OBJECT SET COORDINATES:C1248($vP_ruler->; $x2+4; $y; $vL_xr; $y+6)
		
		$vC_at_objects:=This:C1470._at_styles
		$vC_at_objects.combine(This:C1470._at_aligns)
		
		$x1:=$xl
		$y:=$vL_yb
		$vL_w:=$vL_btn_size
		$vL_h:=$vL_btn_size
		$idx:=0
		For each ($vT_object; $vC_at_objects)
			If ($idx=4)
				$x1:=$vL_xr-(($vL_w+2)*3)+2
			End if 
			OBJECT GET COORDINATES:C663(*; $vT_object; $vL_left; $vL_top; $vL_right; $vL_bottom)
			OBJECT SET COORDINATES:C1248(*; $vT_object; $x1; $y-$vL_h; $x1+$vL_w; $y)
			$x1:=$x1+$vL_w+2
			$idx+=1
		End for each 
		
	Else 
		
		OBJECT GET COORDINATES:C663(*; $vT_ot_face; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT GET COORDINATES:C663($vP_fontface_PU->; $vL_left; $vL_top; $vL_right_x; $vL_bottom)
		OBJECT SET COORDINATES:C1248($vP_fontface_PU->; $vL_right; $vL_top; $vL_xr; $vL_bottom)
		
		OBJECT GET COORDINATES:C663($vP_fontSize_PU->; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		OBJECT GET COORDINATES:C663(*; $vT_ot_size; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$x1:=$vL_right+$vL_w
		OBJECT SET COORDINATES:C1248($vP_fontSize_PU->; $vL_right; $vL_top-3; $x1; $vL_bottom+1)
		
		OBJECT GET COORDINATES:C663(*; $vT_woc_colour; $vL_left; $vL_top; $vL_right; $vL_bottom)
		OBJECT SET COORDINATES:C1248(*; $vT_woc_colour; $x1+2; $vL_top; $vL_xr; $vL_bottom)
		
		OBJECT GET COORDINATES:C663(*; $vT_ot_opacity; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "opacity_Rlr")
		OBJECT SET COORDINATES:C1248($vP_ruler->; $vL_right; $vL_top; $vL_xr; $vL_bottom)
		
		$vC_at_objects:=This:C1470._at_styles
		OBJECT GET COORDINATES:C663(*; $vT_ot_style; $x1; $vL_top; $vL_right_x; $vL_bottom)
		$y:=$vL_top
		$vL_w:=$vL_btn_size
		$vL_h:=$vL_btn_size
		$idx:=0
		For each ($vT_object; $vC_at_objects)
			OBJECT GET COORDINATES:C663(*; $vT_object; $vL_left; $vL_top; $vL_right; $vL_bottom)
			OBJECT SET COORDINATES:C1248(*; $vT_object; $x1; $y-$vL_h; $x1+$vL_w; $y)
			$x1:=$x1+$vL_w+2
			$idx+=1
		End for each 
		
		$vC_at_objects:=This:C1470._at_aligns
		OBJECT GET COORDINATES:C663(*; $vT_ot_align; $vL_left; $vL_top; $vL_right; $vL_bottom)
		$vL_w:=$vL_right-$vL_left
		$x1:=$vL_xr-$vL_w
		OBJECT SET COORDINATES:C1248(*; $vT_ot_align; $x1; $vL_top; $vL_xr; $vL_bottom)
		$y:=$vL_top
		$vL_w:=$vL_btn_size
		$vL_h:=$vL_btn_size
		$idx:=0
		For each ($vT_object; $vC_at_objects)
			OBJECT GET COORDINATES:C663(*; $vT_object; $vL_left; $vL_top; $vL_right; $vL_bottom)
			OBJECT SET COORDINATES:C1248(*; $vT_object; $x1; $y-$vL_h; $x1+$vL_w; $y)
			$x1:=$x1+$vL_w+2
			$idx+=1
		End for each 
	End if 
	$vJ_woc_colour:=OBJECT Get value:C1743($vT_woc_colour)
	$vJ_woc_colour.is_displayText:=Not:C34($is_tight)
	$vJ_woc_colour.l_space_palette:=woc__storage_prefs().l_space
	$vJ_woc_colour.resize($vT_woc_colour)
	//$vJ_colour.redraw()
	// *
	// *****
	
	
Function _redraw()
	var $is_editing : Boolean
	var $vJ_woc_colour : Object
	var $vP_ruler; $vP_fontface_PU; $vP_fontSize_PU; $vP : Pointer
	var $vC_at_objects : Collection
	var $vL_ItemRef; $vL_size; $vL_index; $vL_style; $idx; $vL_align : Integer
	var $vT_face; $vT_object : Text
	$is_editing:=This:C1470.is_editing
	$vP_fontface_PU:=OBJECT Get pointer:C1124(Object named:K67:5; "fontface_PU")
	$vT_face:=This:C1470.t_face
	//If (Is macOS)
	$vL_ItemRef:=Find in list:C952($vP_fontface_PU->; $vT_face; 0; *)
	If ($vL_ItemRef#0)
		SELECT LIST ITEMS BY REFERENCE:C630($vP_fontface_PU->; $vL_ItemRef)
		//INSERT IN LIST($vP_FontNamePU->;-10;$face;-100)
		//SET LIST ITEM FONT($vP_FontNamePU->;0;$face)
	Else 
		SELECT LIST ITEMS BY POSITION:C381($vP_fontface_PU->; 100000)
	End if 
	//Else
	//  //Windows
	//$vP_FontNamePU->:=Find in array($vP_FontNamePU->;$face)
	//If ($vP_FontNamePU-><0)
	//$vP_FontNamePU->:=0
	//End if
	//End if
	OBJECT SET FONT:C164($vP_fontface_PU->; $vT_face)
	OBJECT SET ENABLED:C1123($vP_fontface_PU->; $is_editing)
	
	$vP_fontSize_PU:=OBJECT Get pointer:C1124(Object named:K67:5; "fontsize_PU")
	$vL_size:=This:C1470.l_size
	$vL_index:=Find in array:C230($vP_fontSize_PU->; $vL_size)
	$vP_fontSize_PU->:=wox_max(0; $vL_index)
	OBJECT SET ENABLED:C1123($vP_fontSize_PU->; $is_editing)
	
	// colour
	//woc_setWidgetProperties(Form; "woc_colour"; "is_editing"; "colour"; "is_displayText")
	$vJ_woc_colour:=OBJECT Get value:C1743("woc_colour")
	$vJ_woc_colour.is_editing:=This:C1470.is_editing
	$vJ_woc_colour.t_colour:=This:C1470.t_colour
	//$vJ_woc_colour.is_displayText:=This.is_displayText
	$vJ_woc_colour.redraw()
	
	$vP_ruler:=OBJECT Get pointer:C1124(Object named:K67:5; "opacity_Rlr")
	$vP_ruler->:=This:C1470.l_opacity
	OBJECT SET ENABLED:C1123($vP_ruler->; $is_editing)
	
	//style 0=Plain ; 1=Bold ; 2=Italic ; 4=Underline ; 8=Strikethrough
	$vC_at_objects:=This:C1470._at_styles
	$vL_style:=Form:C1466.l_style
	$idx:=0
	For each ($vT_object; $vC_at_objects)
		$vP:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_object)
		$vP->:=Num:C11($vL_style ?? $idx)
		OBJECT SET ENABLED:C1123($vP->; $is_editing)
		$idx+=1
	End for each 
	
	
	// Align 0=Align left (2) ; 1=Center (3) ; 2=Align right (4) ; 3=Justify (5)
	$vC_at_objects:=This:C1470._at_aligns
	$vL_align:=Form:C1466.l_align
	//$vP:=OBJECT Get pointer(Object named;$T_alignNames{$align+1})
	//$vP->:=1
	$idx:=0
	For each ($vT_object; $vC_at_objects)
		$vP:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_object)
		$vP->:=Num:C11($vL_align=$idx)
		OBJECT SET ENABLED:C1123($vP->; $is_editing)
		$idx+=1
	End for each 
	
	
	//Function wos_widget_set($vT_widget : Text; $vL_value : Integer)
	//var $vJ_widget : Object
	//$vJ_widget:=OBJECT Get value($vT_widget)
	//$vJ_widget.l_value:=$vL_value
	//$vJ_widget.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _colour_chge($vJ_widget : Object)
	Form:C1466.t_colour:=$vJ_widget.t_colour
	This:C1470._send_onDataChange()
	
Function _send_onDataChange()
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)  // Move
	
	
Function _fontface_PU_chge($vP_object : Pointer)
	var $vL_ItemRef : Integer
	var $vT_CurrentFontName : Text
	GET LIST ITEM:C378($vP_Object->; *; $vL_ItemRef; $vT_CurrentFontName)
	If ($vL_ItemRef#0)
		//Update the currently selected font at the top of the list (above the line).
		If (List item position:C629($vP_Object->; -100)<1)
			INSERT IN LIST:C625($vP_Object->; -10; $vT_CurrentFontName; -100)
		Else 
			SET LIST ITEM:C385($vP_Object->; -100; $vT_CurrentFontName; -100)
		End if 
		SET LIST ITEM FONT:C953($vP_Object->; -100; $vT_CurrentFontName)
		SELECT LIST ITEMS BY REFERENCE:C630($vP_Object->; $vL_ItemRef)
		OBJECT SET FONT:C164($vP_Object->; $vT_CurrentFontName)
		Form:C1466.t_face:=$vT_CurrentFontName
		This:C1470._send_onDataChange()
	End if 
	
Function _fontsize_PU_chge($vP_object : Pointer)
	Form:C1466.l_size:=$vP_object->{$vP_object->}
	This:C1470._send_onDataChange()
	
Function _opacity_rlr($vP_object : Pointer)
	var $is_editing : Boolean
	var $vL_event_code : Integer
	$is_editing:=This:C1470.is_editing
	If ($is_editing)
		$vL_event_code:=Form event code:C388
		This:C1470.l_opacity:=$vP_object->
		Case of 
			: ($vL_event_code=On Data Change:K2:15)
				CALL SUBFORM CONTAINER:C1086(k_OnDataMove)  // Move
				
			: ($vL_event_code=On Clicked:K2:4)
				This:C1470._send_onDataChange()
		End case 
		//This._redraw()
	Else 
		wox_sounds_play_edit()
	End if 
	
	
Function _style_clicked($vT_objectName : Text)
	var $isOk : Boolean
	var $vC_at_objects : Collection
	var $vL_style; $idx : Integer
	var $vP : Pointer
	var $vT_object : Text
	$vC_at_objects:=This:C1470._at_styles
	// 0=Plain ; 1=Bold ; 2=Italic ; 4=Underline ; 8=Strikethrough
	$isOk:=($vC_at_objects.indexOf($vT_objectName)>=0)
	If ($isOk)
		$vL_style:=0
		$idx:=0
		For each ($vT_object; $vC_at_objects)
			$vP:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_object)
			If ($vP->=1)
				$vL_style:=$vL_style ?+ $idx
			End if 
			$idx+=1
		End for each 
		This:C1470.l_style:=$vL_style
		This:C1470._send_onDataChange()
	End if 
	
	
Function _align_clicked($vT_objectName : Text)
	var $isOk : Boolean
	var $vC_at_objects : Collection
	var $vL_align; $idx : Integer
	var $vP : Pointer
	var $vT_object : Text
	$vC_at_objects:=This:C1470._at_aligns
	// 0=Align left -> SVG 2 ; 1=Center -> SVG 3 ; 2=Align right -> SVG 4
	// 3=Justify -> SVG 5
	$isOk:=($vC_at_objects.indexOf($vT_objectName)>=0)
	If ($isOk)
		$vL_align:=0
		$idx:=0
		For each ($vT_object; $vC_at_objects)
			$vP:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_object)
			If ($vP->=1)
				$vL_align:=$idx
				break
			End if 
			$idx+=1
		End for each 
		This:C1470.l_align:=$vL_align
		This:C1470._send_onDataChange()
	End if 
	// *
	// *****
	
	