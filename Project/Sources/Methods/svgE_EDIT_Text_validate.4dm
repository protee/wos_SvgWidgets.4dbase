//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

svgE_getStuff_vJ(->$vJ_canvas; $vP_null; ->$vJ_history)
//$currentObject:=$ob_canvas.t_currentObject
$vT_editTextObject:=$vJ_canvas.t_editTextObject
$vT_editedText_new:=$vJ_canvas.editedText_new
$vT_editedText_old:=$vJ_canvas.editedText_old
$vP_textEditArea:=$vJ_canvas.ptr_text

//$historyIndex:=$ob_canvas.j_historyIndex
$vJ_ui:=wos__storage_prefs_ui
$vL_handle_fill_opacity:=$vJ_ui.handle_fill_opacity

// Widgets
$vJ_font:=wos_getWidget("wos_text")
$vT_font_face:=$vJ_font.t_face
$vL_font_size:=$vJ_font.l_size
$vT_font_colour:=$vJ_font.t_colour
$vL_font_opacity:=$vJ_font.l_opacity
$vL_font_style:=$vJ_font.l_style
$vL_font_align:=$vJ_font.l_align


$vP_focusObject:=OBJECT Get pointer:C1124(Object with focus:K67:3)

var $isOk : Boolean
var $vL_handle_fill_opacity; $vL_font_size; $vL_font_opacity; $vL_font_style; $vL_font_align; $vL_h; $vL_countBreaks; $vL_n; $vL_t; $vL_historyIndex : Integer
var $vJ_canvas; $vJ_history; $vJ_ui; $vJ_font : Object
var $vP_null; $vP_textEditArea; $vP_focusObject : Pointer
var $vT_editTextObject; $vT_editedText_new; $vT_editedText_old; $vT_font_face; $vT_font_colour; $vT_rect; $vT_xml_null; $vT_line; $vT_breaks; $vT_tbreak; $vT_append; $vT_currentObject : Text
$isOk:=False:C215
If ($vP_focusObject=$vP_textEditArea)
	If (Length:C16($vT_editTextObject)#0)
		$vT_editedText_new:=$vP_textEditArea->
		$vJ_canvas.editedText_new:=$vT_editedText_new
		DOM SET XML ATTRIBUTE:C866($vT_editTextObject; "stroke-opacity"; 1; "fill-opacity"; $vL_font_opacity/100)
		
		$vT_rect:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".select")
		$vT_xml_null:=wos__storage_stuff.t_xml_null
		If ($vT_rect#$vT_xml_null)
			DOM SET XML ATTRIBUTE:C866($vT_rect; "stroke-opacity"; 1; "fill-opacity"; 0.1)
			$isOk:=True:C214
		End if 
		ARRAY TEXT:C222($aT_handles; 8)
		$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".tl")
		$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".tm")
		$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".tr")
		$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".ml")
		$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".mr")
		$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".bl")
		$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".bm")
		$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".br")
		
		For ($vL_h; 1; 8)
			If ($aT_handles{$vL_h}#$vT_xml_null)
				DOM SET XML ATTRIBUTE:C866($aT_handles{$vL_h}; "stroke-opacity"; 1; "fill-opacity"; $vL_handle_fill_opacity)
			End if 
		End for 
		
		If (Position:C15($vT_editedText_new; $vT_editedText_old)=1) & (Length:C16($vT_editedText_new)=Length:C16($vT_editedText_old))
			//unchanged
		Else 
			
			If (Length:C16($vT_editedText_new)#0)
				
				$vL_countBreaks:=DOM Count XML elements:C726($vT_editTextObject; "tbreak")
				
				For ($vL_n; 1; $vL_countBreaks)
					DOM REMOVE XML ELEMENT:C869(DOM Find XML element:C864($vT_editTextObject; "textArea/tbreak"))
				End for 
				
				$vL_t:=1
				
				ARRAY LONGINT:C221($aL_len; 0)
				ARRAY LONGINT:C221($aL_pos; 0)
				
				While (Match regex:C1019("(.+)"; $vT_editedText_new; $vL_t; $aL_pos; $aL_len))
					$vT_line:=Substring:C12($vT_editedText_new; $aL_pos{1}; $aL_len{1})
					If ($vL_t=1)
						DOM SET XML ELEMENT VALUE:C868($vT_editTextObject; $vT_line)
					Else 
						$vT_breaks:=Substring:C12($vT_editedText_new; $vL_t; $aL_pos{1}-$vL_t)
						$vL_countBreaks:=Length:C16(Replace string:C233($vT_breaks; "\r\n"; "\n"))
						For ($vL_n; 1; $vL_countBreaks)
							$vT_tbreak:=DOM Create XML element:C865($vT_editTextObject; "tbreak")
						End for 
						$vT_append:=DOM Append XML child node:C1080($vT_editTextObject; XML DATA:K45:12; $vT_line)
					End if 
					$vL_t:=$aL_pos{1}+$aL_len{1}
				End while 
				
				$vL_historyIndex:=$vJ_history.l_index
				If (Length:C16($vT_editedText_old)=0)  //new object, don't record the start state in history
					$vL_historyIndex:=wox_max(1; $vL_historyIndex-1)
					$vJ_history.l_index:=$vL_historyIndex
					Form:C1466.is_modified:=($vL_historyIndex>1)
				End if 
				$isOk:=True:C214
				
			Else 
				//delete the object if content is void
				$vT_currentObject:=$vT_editTextObject
				$vJ_canvas.t_currentObject:=$vT_currentObject
				svgE_SELECT_Clear_selection($vT_currentObject)
				DOM REMOVE XML ELEMENT:C869($vT_editTextObject)
				If (Length:C16($vT_editedText_old)=0)  //if the object was only created, clear from history
					svgE_HISTORY_Rewind
				End if 
				$isOk:=True:C214
			End if 
		End if 
	End if 
	
	OBJECT SET ENABLED:C1123(*; "delete_btn"; True:C214)
	OBJECT SET ENABLED:C1123(*; "Backspace_btn"; True:C214)
	svgE_EDIT_ACTIONS_enabler
	
	
	
	CLEAR VARIABLE:C89($vP_textEditArea->)
	$vJ_canvas.editedText_new:=""
	$vJ_canvas.editedText_old:=""
	OBJECT MOVE:C664($vP_textEditArea->; 0; 0; 0; 0; *)
	OBJECT MOVE:C664(*; "TextEditAreaFrame"; 0; 0; 0; 0; *)
	
	svgE_FORM_Size_validate
	$vJ_canvas.t_editTextObject:=""
End if 

$0:=$isOk

