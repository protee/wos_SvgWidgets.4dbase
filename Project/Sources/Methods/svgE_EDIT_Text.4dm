//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom : Integer
$vL_zoom:=$vJ_canvas.l_zoom
var $vP_textEditArea : Pointer
var $vT_currentHandle; $vT_currentObject; $vT_editTextObject : Text
$vT_currentObject:=$vJ_canvas.t_currentObject
$vT_currentHandle:=$vJ_canvas.currentHandle
$vT_editTextObject:=$vJ_canvas.t_editTextObject
$vT_currentHandle:=$vJ_canvas.currentHandle
$vP_textEditArea:=$vJ_canvas.ptr_text

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vT_selection_stroke : Text
$vT_selection_stroke:=$vJ_ui.selection_stroke

var $vP_canvas : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")


var $vR_scale : Real
$vR_scale:=$vL_zoom/100


var $vJ_font : Object
$vJ_font:=wos_getWidget("wos_text")
var $vT_font_face : Text
var $vL_font_size; $vL_font_style; $vL_font_align : Integer
var $vT_font_colour : Text
var $vL_font_opacity : Integer
$vT_font_face:=$vJ_font.t_face
$vL_font_size:=$vJ_font.l_size
$vT_font_colour:=$vJ_font.t_colour
$vL_font_opacity:=$vJ_font.l_opacity
$vL_font_style:=$vJ_font.l_style
$vL_font_align:=$vJ_font.l_align



var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentObject)#0)
	If (Length:C16($vT_currentHandle)=0)
		
		var $vT_objectType : Text
		DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
		
		If ($vT_objectType="textArea")
			$vT_editTextObject:=$vT_currentObject
			$vJ_canvas.t_editTextObject:=$vT_editTextObject
			
			var $vL_countAttributes; $i : Integer
			$vL_countAttributes:=DOM Count XML attributes:C727($vT_editTextObject)
			ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
			ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
			
			For ($i; 1; $vL_countAttributes)
				DOM GET XML ATTRIBUTE BY INDEX:C729($vT_editTextObject; $i; $aT_attributeNames{$i}; $aT_attributeValues{$i})
			End for 
			
			ARRAY LONGINT:C221($aL_nodeType; 0)
			ARRAY TEXT:C222($aT_nodeData; 0)
			DOM GET XML CHILD NODES:C1081($vT_editTextObject; $aL_nodeType; $aT_nodeData)
			
			var $vL_nodes : Integer
			$vP_textEditArea->:=""
			var $vT_nodeName : Text
			$vT_nodeName:=""
			
			For ($vL_nodes; 1; Size of array:C274($aL_nodeType))
				Case of 
					: ($aL_nodeType{$vL_nodes}=XML DATA:K45:12)
						$vP_textEditArea->:=$vP_textEditArea->+$aT_nodeData{$vL_nodes}
						
					: ($aL_nodeType{$vL_nodes}=XML ELEMENT:K45:20)
						DOM GET XML ELEMENT NAME:C730($aT_nodeData{$vL_nodes}; $vT_nodeName)
						If ($vT_nodeName="tbreak")
							$vP_textEditArea->:=$vP_textEditArea->+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
						End if 
						
				End case 
			End for 
			
			var $vR_x; $vR_y; $vR_width; $vR_height : Real
			$vR_x:=0
			$vR_y:=0
			
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_editTextObject; "x"; $vR_x)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_editTextObject; "y"; $vR_y)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_editTextObject; "width"; $vR_width)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_editTextObject; "height"; $vR_height)
			
			var $vR_tx; $vR_ty : Real
			$vR_tx:=0
			$vR_ty:=0
			
			ARRAY LONGINT:C221($aL_pos; 0)
			ARRAY LONGINT:C221($aL_len; 0)
			
			If (Find in array:C230($aT_attributeNames; "transform")#-1)
				var $vT_transform : Text
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_editTextObject; "transform"; $vT_transform)
				If (Match regex:C1019("translate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
					$vR_tx:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
					$vR_ty:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
				End if 
			End if 
			
			$vR_x:=($vR_x+$vR_tx)*$vR_scale
			$vR_y:=($vR_y+$vR_ty)*$vR_scale
			
			// TextEditArea
			OBJECT SET FONT:C164($vP_textEditArea->; $vT_font_face)
			If (Find in array:C230($aT_attributeNames; "font-size")#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_editTextObject; "font-size"; $vL_font_size)
			Else 
				$vL_font_size:=12  // Default
			End if 
			OBJECT SET FONT SIZE:C165($vP_textEditArea->; $vL_font_size*$vR_scale)
			var $vL_stroke_rgb; $vL_fill_rgb : Integer
			$vL_stroke_rgb:=woc_sp_colourToColorRGB($vT_font_colour)
			//$fill_rgb:=wos_svg_colourStringToNumber ($fill_colour)
			$vL_fill_rgb:=Background color none:K23:10
			OBJECT SET RGB COLORS:C628($vP_textEditArea->; $vL_stroke_rgb; $vL_fill_rgb)
			OBJECT SET FONT STYLE:C166($vP_textEditArea->; $vL_font_style)
			OBJECT SET HORIZONTAL ALIGNMENT:C706($vP_textEditArea->; $vL_font_align+2)  // 2, 3, 4
			
			var $vL_canvas_left; $vL_canvas_top; $vL_canvas_right; $vL_canvas_bottom : Integer
			OBJECT GET COORDINATES:C663($vP_canvas->; $vL_canvas_left; $vL_canvas_top; $vL_canvas_right; $vL_canvas_bottom)
			var $vL_canvas_width; $vL_canvas_height : Integer
			$vL_canvas_width:=$vL_canvas_right-$vL_canvas_left
			$vL_canvas_height:=$vL_canvas_bottom-$vL_canvas_top
			
			var $vB_horizontal; $vB_vertical : Boolean
			OBJECT GET SCROLLBAR:C1076($vP_canvas->; $vB_horizontal; $vB_vertical)
			$vL_canvas_width:=$vL_canvas_width-(Num:C11($vB_vertical)*15)
			$vL_canvas_height:=$vL_canvas_height-(Num:C11($vB_horizontal)*15)
			
			var $vL_imgWidth; $vL_imgHeight : Integer
			PICTURE PROPERTIES:C457($vP_canvas->; $vL_imgWidth; $vL_imgHeight)
			var $vL_hh; $vL_ww : Integer
			$vL_ww:=$vL_imgWidth-$vL_canvas_width
			$vL_hh:=$vL_imgHeight-$vL_canvas_height
			
			var $vL_hpos; $vL_vpos : Integer
			OBJECT GET SCROLL POSITION:C1114($vP_canvas->; $vL_vpos; $vL_hpos)
			
			//compensate for the 15 px move at max scroll
			If ($vL_ww=$vL_hpos) & ($vL_hpos#0)
				$vL_canvas_left:=$vL_canvas_left+15
			End if 
			If ($vL_hh=$vL_vpos) & ($vL_vpos#0)
				$vL_canvas_top:=$vL_canvas_top+15
			End if 
			If (Is Windows:C1573)
				$vL_canvas_left:=$vL_canvas_left-1
				$vR_width:=$vR_width+1
			End if 
			
			var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
			$vL_left:=$vR_x+$vL_canvas_left-$vL_hpos
			$vL_top:=$vR_y+$vL_canvas_top-$vL_vpos
			$vL_right:=$vL_left+($vR_width*$vR_scale)-1
			$vL_bottom:=$vL_top+($vR_height*$vR_scale)-1
			
			//trim edge
			//$left:=x_max($left;$canvas_left)
			//$top:=x_max($top;$canvas_top)
			//$right:=x_min($right;$canvas_right)
			//$bottom:=x_min($bottom;$canvas_bottom)
			
			// Better! keep the initial dimension of the text object
			//If ($left<$canvas_left)
			//$right:=$canvas_left+($right-$left)
			//$left:=$canvas_left
			//End if
			//If ($top<$canvas_top)
			//$bottom:=$canvas_top+($bottom-$top)
			//$top:=$canvas_top
			//End if
			//If ($right>$canvas_right)
			//$left:=$canvas_right-($right-$left)
			//$right:=$canvas_right
			//End if
			//If ($bottom>$canvas_bottom)
			//$top:=$canvas_bottom-($bottom-$top)
			//$bottom:=$canvas_bottom
			//End if
			
			
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "fill-opacity"; 0; "stroke-opacity"; 0)
			var $vT_rect : Text
			$vT_rect:=DOM Find XML element by ID:C1010($vT_editTextObject; $vT_editTextObject+".select")
			var $vT_xml_null : Text
			$vT_xml_null:=wos__storage_stuff.t_xml_null
			If ($vT_rect#$vT_xml_null)
				DOM SET XML ATTRIBUTE:C866($vT_rect; "fill-opacity"; 0; "stroke-opacity"; 0)
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
			var $vL_h : Integer
			For ($vL_h; 1; 8)
				If ($aT_handles{$vL_h}#$vT_xml_null)
					DOM SET XML ATTRIBUTE:C866($aT_handles{$vL_h}; "stroke-opacity"; 0; "fill-opacity"; 0)
				End if 
			End for 
			
			//OBJECT SET SCROLLBAR($vP_canvas->;False;False)
			OBJECT SET RGB COLORS:C628(*; "TextEditAreaFrame"; $vL_stroke_rgb; Background color:K23:2)
			OBJECT MOVE:C664(*; "TextEditAreaFrame"; $vL_left-2; $vL_top-2; $vL_right+2; $vL_bottom+2; *)
			OBJECT MOVE:C664($vP_textEditArea->; $vL_left; $vL_top; $vL_right; $vL_bottom; *)
			GOTO OBJECT:C206($vP_textEditArea->)
			SET CURSOR:C469(0)
			SET TIMER:C645(0)
			OBJECT SET ENABLED:C1123(*; "delete_btn"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Backspace_btn"; False:C215)
			svgE_EDIT_ACTIONS_enabler(False:C215)
			$isOk:=True:C214
		End if 
	End if 
End if 

$0:=$isOk

