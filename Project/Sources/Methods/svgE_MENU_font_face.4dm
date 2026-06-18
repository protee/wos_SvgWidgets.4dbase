//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_MENU_FONT_FACE
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 03/03/2021   OG   Initial version.

#DECLARE($vT_refMenu : Text; $vT_font_face : Text)->$vT_refMenu_answer : Text
var $i : Integer
var $vT_font_face_cur : Text

ARRAY TEXT:C222($aT_fonts; 0)
FONT LIST:C460($aT_fonts; Favorite fonts:K80:2)
ARRAY TEXT:C222($aT_buffer; 0)
FONT LIST:C460($aT_buffer; Recent fonts:K80:3)
For ($i; 1; Size of array:C274($aT_buffer); 1)
	If (Find in array:C230($aT_fonts; $aT_buffer{$i})=-1)
		APPEND TO ARRAY:C911($aT_fonts; $aT_buffer{$i})
	End if 
End for 

//append current font if any
If ($vT_font_face#"-") & ($vT_font_face#"")  //not mixed
	If (Find in array:C230($aT_fonts; $vT_font_face)=-1)
		APPEND TO ARRAY:C911($aT_fonts; $vT_font_face)
	End if 
End if 
SORT ARRAY:C229($aT_fonts)

APPEND TO ARRAY:C911($aT_fonts; "-")
FONT LIST:C460($aT_buffer)
For ($i; 1; Size of array:C274($aT_buffer); 1)
	If (Find in array:C230($aT_fonts; $aT_buffer{$i})=-1)
		APPEND TO ARRAY:C911($aT_fonts; $aT_buffer{$i})
	End if 
End for 


//manage system font
//$x:=Find in array($aT_fonts;OBJECT Get font(*;"AutoFont"))
//If ($x>0)
//DELETE FROM ARRAY($aT_fonts;$x;1)
//INSERT IN ARRAY($aT_fonts;1;2)
//$aT_fonts{1}:=Get localized string("Menus_systemFont")
//$aT_fonts{2}:="-"
//End if 

// Menu
$vT_refMenu_answer:=Create menu:C408
For ($i; 1; Size of array:C274($aT_fonts); 1)
	$vT_font_face_cur:=$aT_fonts{$i}
	APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_font_face_cur)
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "font-face-"+$vT_font_face_cur)
	If ($vT_font_face_cur=$vT_font_face)
		SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
	End if 
End for 
If (Count menu items:C405($vT_refMenu_answer)>0)
	APPEND MENU ITEM:C411($vT_refMenu_answer; "-")
End if 
//APPEND MENU ITEM($vT_refMenu_face;"-")
//APPEND MENU ITEM($vT_refMenu_face;"Show Fonts")
//SET MENU ITEM PARAMETER($vT_refMenu_face;-1;"font-picker")

APPEND MENU ITEM:C411($vT_refMenu; "Face"; $vT_refMenu_answer)
RELEASE MENU:C978($vT_refMenu_answer)

