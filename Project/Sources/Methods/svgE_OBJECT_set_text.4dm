//%attributes = {"invisible":true,"lang":"en"}

#DECLARE()->$isOk : Boolean
var $is_on : Boolean
var $vL_zoom; $vL_font_size; $vL_font_opacity; $vL_font_style; $vL_font_align; $vL_tt; $i; $vL_countAttributes; $j; $vL_fontAlign; $tt_att; $vL_att; $vL_idx : Integer
var $vJ_canvas; $vJ_wos_text; $vJ_storage_stuff : Object
var $vP_textEditArea; $vP_canvas; $vP__T_currentObjects : Pointer
var $vR_scale; $vR_size; $vR_fontOpacity : Real
var $vT_font_face; $vT_font_colour; $vT_objectType; $vT_currentObject; $vT_attributeName; $vT_font; $vT_fontColour; $vT_font_align_txt; $vT_ChangedAttributeName; $vT_ChangedAttributeValue; $vT_style_txt : Text

$isOk:=False:C215

//C_TEXT($domRef)
//$domRef:=Form.t_domRef

svgE_getStuff_vJ(->$vJ_canvas)
$vP_textEditArea:=$vJ_canvas.ptr_text

$vL_zoom:=$vJ_canvas.l_zoom
$vR_scale:=$vL_zoom/100

$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP__T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")


$vJ_wos_text:=wos_getWidget("wos_text")
$vT_font_face:=$vJ_wos_text.t_face
$vL_font_size:=$vJ_wos_text.l_size
$vT_font_colour:=$vJ_wos_text.t_colour
$vL_font_opacity:=$vJ_wos_text.l_opacity
$vL_font_style:=$vJ_wos_text.l_style
$vL_font_align:=$vJ_wos_text.l_align


ARRAY TEXT:C222($aT_attrs_names; 0)
APPEND TO ARRAY:C911($aT_attrs_names; "font-weight")
APPEND TO ARRAY:C911($aT_attrs_names; "font-style")
APPEND TO ARRAY:C911($aT_attrs_names; "text-decoration")
APPEND TO ARRAY:C911($aT_attrs_names; "text-decoration")
ARRAY TEXT:C222($aT_attrs_values; 0)
APPEND TO ARRAY:C911($aT_attrs_values; "bold")
APPEND TO ARRAY:C911($aT_attrs_values; "italic")
APPEND TO ARRAY:C911($aT_attrs_values; "underline")
APPEND TO ARRAY:C911($aT_attrs_values; "line-through")

$vL_tt:=Size of array:C274($vP__T_currentObjects->)
For ($i; 1; $vL_tt)
	$vT_objectType:=""
	$vT_currentObject:=$vP__T_currentObjects->{$i}
	DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
	
	Case of 
		: ($vT_objectType="textArea")
			$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject)
			ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
			ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)
			For ($j; 1; $vL_countAttributes)
				DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject; $j; $aT_attributeNames{$j}; $aT_attributeValues{$j})
			End for 
			
			$vT_attributeName:="font-family"
			$vT_font:=""
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font)
			End if 
			If ($vT_font#$vT_font_face)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_font_face)
				$isOk:=True:C214
			End if 
			
			$vT_attributeName:="font-size"
			$vR_size:=0
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vR_size)
			End if 
			If ($vR_size#$vL_font_size)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vL_font_size)
				$isOk:=True:C214
			End if 
			
			
			$vT_attributeName:="fill"
			$vT_fontColour:=""
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_fontColour)
			End if 
			If ($vT_fontColour="") | ($vT_fontColour#$vT_font_colour)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_font_colour)
				$isOk:=True:C214
			End if 
			
			
			$vT_attributeName:="fill-opacity"
			$vR_fontOpacity:=-1
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vR_fontOpacity)
			End if 
			If ($vR_fontOpacity=-1) | ($vR_fontOpacity#$vL_font_opacity)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vL_font_opacity/100)
				$isOk:=True:C214
			End if 
			
			$vJ_storage_stuff:=wos__storage_stuff
			
			$vT_attributeName:="text-align"
			If (Find in array:C230($aT_attributeNames; $vT_attributeName)#-1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_attributeName; $vT_font_align_txt)
				$vL_fontAlign:=wox_max(0; $vJ_storage_stuff.at_text_align.indexOf($vT_font_align_txt))
				If ($vL_fontAlign#$vL_font_align)
					$vT_font_align_txt:=$vJ_storage_stuff.at_text_align[$vL_font_align]
					DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_font_align_txt)
					$isOk:=True:C214
				End if 
			End if 
			
			$tt_att:=Size of array:C274($aT_attrs_names)
			For ($vL_att; 1; $tt_att)
				$vL_idx:=$vL_att-1
				//If ($T_attr_mask{$vL_att})
				$vT_ChangedAttributeName:=$aT_attrs_names{$vL_att}
				$is_on:=($vL_font_style ?? $vL_idx)
				$vT_ChangedAttributeValue:=Choose:C955($is_on; $aT_attrs_values{$vL_att}; Choose:C955(($vL_att<3); "normal"; "none"))
				If (Find in array:C230($aT_attributeNames; $vT_ChangedAttributeName)#-1)
					DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; $vT_ChangedAttributeName; $vT_style_txt)
					If ($vT_style_txt#$vT_ChangedAttributeValue)
						DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_ChangedAttributeName; $vT_ChangedAttributeValue)
						$isOk:=True:C214
					End if 
				Else 
					DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_ChangedAttributeName; $vT_ChangedAttributeValue)
					$isOk:=True:C214
				End if 
				//End if
			End for 
			
	End case 
End for 

OBJECT SET FONT:C164($vP_textEditArea->; $vT_font_face)
OBJECT SET FONT SIZE:C165($vP_textEditArea->; $vL_font_size*$vR_scale)
OBJECT SET FONT STYLE:C166($vP_textEditArea->; $vL_font_style)

