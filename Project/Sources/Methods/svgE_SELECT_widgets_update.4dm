//%attributes = {"invisible":true,"lang":"en"}

var $is_text; $is_line; $is_others : Boolean
var $vL_font_size; $vL_font_opacity; $vL_font_style; $vL_font_align; $vL_stroke_opacity; $vL_stroke_width; $vL_stroke_marker; $vL_stroke_dash; $vL_stroke_join; $vL_stroke_cap; $vL_fill_opacity; $vL_rotate; $vL_countAttributes; $i; $vL_fontAlign; $k : Integer
var $vJ_canvas; $vJ_storage_stuff : Object
var $vJ_wos_text; $vJ_wos_stroke; $vJ_wos_fill; $vJ_wos_rotate : Object
var $vR_opacity : Real
var $vT_currentObject; $vT_objectType; $vT_wos_text; $vT_wos_stroke; $vT_wos_fill; $vT_wos_rotate; $vT_font_face; $vT_font_colour; $vT_stroke_colour; $vT_fill_colour; $vT_font_attribute; $vT_attributeName; $vT_font_align_txt; $vT_transform; $vT_attribute_name; $vT_mano : Text
svgE_getStuff_vJ(->$vJ_canvas)
$vT_currentObject:=$vJ_canvas.t_currentObject

$vT_objectType:=""
If ($vT_currentObject#"")
	
	$vT_wos_text:="wos_text"
	$vT_wos_stroke:="wos_stroke"
	$vT_wos_fill:="wos_fill"
	$vT_wos_rotate:="wos_rotate"
	
	$vJ_wos_text:=wos_getWidget($vT_wos_text)
	$vJ_wos_stroke:=wos_getWidget($vT_wos_stroke)
	$vJ_wos_fill:=wos_getWidget($vT_wos_fill)
	$vJ_wos_rotate:=wos_getWidget($vT_wos_rotate)
	
	
	// Widgets
	$vT_font_face:=""
	$vL_font_size:=-1
	$vT_font_colour:=""
	$vL_font_opacity:=-1
	$vL_font_style:=0
	$vL_font_align:=-1
	
	$vT_stroke_colour:=""
	$vL_stroke_opacity:=100
	$vL_stroke_width:=1
	$vL_stroke_marker:=0
	$vL_stroke_dash:=0
	$vL_stroke_join:=0
	$vL_stroke_cap:=0
	
	$vT_fill_colour:=""
	$vL_fill_opacity:=-1
	
	$vL_rotate:=-1
	
	
	
	DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
	$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject)
	ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
	ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
	For ($i; 1; $vL_countAttributes)
		DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject; $i; $aT_attributeNames{$i}; $aT_attributeValues{$i})
	End for 
	
	$is_text:=($vT_objectType="textArea")
	$is_line:=($vT_objectType="line")
	$is_others:=($vT_objectType="polyline") | $is_line | ($vT_objectType="rect") | ($vT_objectType="circle") | ($vT_objectType="ellipse") | ($vT_objectType="image")
	
	//update tool buttons
	Case of 
		: ($is_text)
			$vT_font_attribute:=""
			$vT_attributeName:="font-family"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_face)
			End if 
			$vT_attributeName:="font-size"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vL_font_size)
			End if 
			$vT_attributeName:="font-weight"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_attribute)
				If ($vT_font_attribute="bold")
					$vL_font_style:=$vL_font_style ?+ 0
				End if 
			End if 
			$vT_attributeName:="text-align"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				$vT_font_align_txt:=""
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_align_txt)
				$vJ_storage_stuff:=wos__storage_stuff
				$vL_fontAlign:=wox_max(0; $vJ_storage_stuff.at_text_align.indexOf($vT_font_align_txt))
			End if 
			$vT_attributeName:="font-style"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_attribute)
				If ($vT_font_attribute="italic")
					$vL_font_style:=$vL_font_style ?+ 1
				End if 
			End if 
			$vT_attributeName:="text-decoration"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_attribute)
				If ($vT_font_attribute="underline")
					$vL_font_style:=$vL_font_style ?+ 2
				End if 
			End if 
			//If (Find in array($attributeNames;"stroke")#-1)
			//DOM GET XML ATTRIBUTE BY NAME($currentObject;"stroke";$stroke_colour)
			//End if
			$vT_attributeName:="fill"
			$vT_font_colour:="black"  // Default if inex
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_colour)
			End if 
			$vT_attributeName:="fill-opacity"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vR_opacity)
				$vL_font_opacity:=$vR_opacity*100
			End if 
			
			ARRAY LONGINT:C221($aL_pos; 0)
			ARRAY LONGINT:C221($aL_len; 0)
			
			$vT_attributeName:="transform"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_transform)
				If (Match regex:C1019("rotate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
					$vL_rotate:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
				Else 
					$vL_rotate:=0
				End if 
			End if 
			
			// Widget update
			If ($vT_font_face#"")
				$vJ_wos_text.t_face:=$vT_font_face
			End if 
			If ($vL_font_size>=0)
				$vJ_wos_text.l_size:=$vL_font_size
			End if 
			If ($vT_font_colour#"")
				$vJ_wos_text.t_colour:=$vT_font_colour
			End if 
			If ($vL_font_opacity>=0)
				$vJ_wos_text.l_opacity:=$vL_font_opacity
			End if 
			
			If ($vL_font_style>=0)
				$vJ_wos_text.l_style:=$vL_font_style
			End if 
			If ($vL_font_align>=0)
				$vJ_wos_text.l_align:=$vL_font_align
			End if 
			$vJ_wos_text.redraw()
			
			
			
		: ($is_others)
			
			$vT_attribute_name:="transform"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_transform)
				ARRAY LONGINT:C221($aL_pos; 0)
				ARRAY LONGINT:C221($aL_len; 0)
				If (Match regex:C1019("rotate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
					$vL_rotate:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
				Else 
					$vL_rotate:=0
				End if 
			End if 
			
			$vT_attribute_name:="stroke"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_stroke_colour)
			End if 
			
			$vT_attribute_name:="fill"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_fill_colour)
			End if 
			
			$vT_attribute_name:="stroke-width"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vL_stroke_width)
			End if 
			
			$vT_attribute_name:="stroke-dasharray"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				$vT_mano:=""
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_mano)
				$vL_stroke_dash:=Num:C11(Substring:C12($vT_mano; 1; 2))
			End if 
			
			$vT_attribute_name:="stroke-linejoin"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				$vT_mano:=""
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_mano)
				$k:=wos__storage_stuff.at_stroke_linejoin.indexOf($vT_mano)
				If ($k>=0)
					$vL_stroke_join:=$k
				End if 
			End if 
			
			$vT_attribute_name:="stroke-linecap"
			If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
				$vT_mano:=""
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vT_mano)
				$k:=wos__storage_stuff.at_stroke_linecap.indexOf($vT_mano)
				If ($k>=0)
					$vL_stroke_cap:=$k
				End if 
			End if 
			
			$vL_stroke_marker:=0
			Case of 
				: ($vT_objectType="polyline") | ($vT_objectType="line")
					If (Find in array:C230($aT_attributeNames; "marker-start")#-1)
						$vL_stroke_marker:=$vL_stroke_marker+1
					End if 
					If (Find in array:C230($aT_attributeNames; "marker-end")#-1)
						$vL_stroke_marker:=$vL_stroke_marker+2
					End if 
			End case 
			
			Case of 
				: ($vT_objectType="image")
					$vT_attribute_name:="opacity"
					If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
						DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vR_opacity)
						$vL_fill_opacity:=$vR_opacity*100
					Else 
						$vL_fill_opacity:=100
					End if 
					
				: ($vT_objectType="line")
					$vT_attribute_name:="stroke-opacity"
					If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
						DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vR_opacity)
						$vL_stroke_opacity:=$vR_opacity*100
					End if 
					
				Else 
					$vT_attribute_name:="stroke-opacity"
					If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
						DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vR_opacity)
						$vL_stroke_opacity:=$vR_opacity*100
					End if 
					$vT_attribute_name:="fill-opacity"
					If (Find in array:C230($aT_attributeNames; $vT_attribute_name)#-1)
						DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attribute_name; $vR_opacity)
						$vL_fill_opacity:=$vR_opacity*100
					End if 
			End case 
	End case 
	
	// Widgets
	
	If ($vT_stroke_colour#"")
		$vJ_wos_stroke.t_colour:=$vT_stroke_colour
	End if 
	If ($vL_stroke_opacity>=0)
		$vJ_wos_stroke.l_opacity:=$vL_stroke_opacity
	End if 
	If ($vL_stroke_width>=0)
		$vJ_wos_stroke.l_width:=$vL_stroke_width
	End if 
	If ($vL_stroke_marker>=0)
		$vJ_wos_stroke.l_marker:=$vL_stroke_marker
	End if 
	If ($vL_stroke_dash>=0)
		$vJ_wos_stroke.l_dash:=$vL_stroke_dash
	End if 
	If ($vL_stroke_join>=0)
		$vJ_wos_stroke.l_join:=$vL_stroke_join
	End if 
	If ($vL_stroke_cap>=0)
		$vJ_wos_stroke.l_cap:=$vL_stroke_cap
	End if 
	$vJ_wos_stroke.redraw()
	
	If ($vT_fill_colour#"")
		$vJ_wos_fill.t_colour:=$vT_fill_colour
	End if 
	If ($vL_fill_opacity>=0)
		$vJ_wos_fill.l_opacity:=$vL_fill_opacity
	End if 
	$vJ_wos_fill.redraw()
	
	If ($vL_rotate>=0)
		$vJ_wos_rotate.l_value:=$vL_rotate
	End if 
	$vJ_wos_rotate.redraw()
	
End if 
svgE_EDIT_widgets_enabler()  //($vT_objectType)

