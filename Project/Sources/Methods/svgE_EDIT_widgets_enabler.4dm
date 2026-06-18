//%attributes = {"invisible":true,"lang":"en"}

var $vT_objectType; $vT_wos_stroke; $vT_gws_widget : Text
var $is_text; $is_line; $is_rect; $is_circle; $is_polyline; $is_image; $is_marker; $is_join; $is_cap; $is_palettes; $is_fill; $is_stroke; $is_font; $is_all; $is_toolsOnTop; $is_palettesOnTop; $is_visibility; $is_visible; $is_enabled : Boolean
var $tt; $vL_widgets_margin; $vL_w; $vL_h; $vL_left; $vL_top; $vL_right; $vL_bottom; $y; $x; $i : Integer
var $vJ_ui; $vJ_widget; $vJ_edit : Object
If (Count parameters:C259>=1)
	$vT_objectType:=$1
Else 
	$vT_objectType:=""
End if 

$tt:=svgE_EDIT_inventory(->$is_text; ->$is_line; ->$is_rect; ->$is_circle; ->$is_polyline; ->$is_image)

$is_text:=$is_text | ($vT_objectType="TEXT@")
$is_line:=$is_line | ($vT_objectType="LINE@")
$is_rect:=$is_rect | ($vT_objectType="RECT@") | ($vT_objectType="ROUND@")
$is_circle:=$is_circle | ($vT_objectType="CIRCLE@")
$is_polyline:=$is_polyline | ($vT_objectType="FREELINE@")
$is_image:=$is_image | ($vT_objectType="IMG@")



// Stroke options
$is_marker:=$is_line | $is_polyline  // For option "marker"
$is_join:=$is_polyline | $is_rect  // For option "join"
$is_cap:=$is_line | $is_polyline | $is_circle | $is_rect  // For option "join"

$is_palettes:=Form:C1466.is_palettes
If ($is_palettes)
	$is_fill:=$is_rect | $is_circle | $is_polyline | $is_image
	$is_stroke:=$is_line | $is_rect | $is_circle | $is_polyline
	$is_font:=$is_text
	$is_all:=($tt#0)  //($vT_objectType#"")
Else 
	$is_fill:=False:C215
	$is_stroke:=False:C215
	$is_font:=False:C215
	$is_all:=False:C215
End if 


$vJ_ui:=wos__storage_prefs_ui
$vL_widgets_margin:=$vJ_ui.widgets_margin


//$wos_zoom:="wos_zoom"
//$wos_rotate:="wos_rotate"
//$wos_fill:="wos_fill"
$vT_wos_stroke:="wos_stroke"
//$wos_font:="wos_text"

$vJ_widget:=wos_getWidget($vT_wos_stroke)
$is_cap:=$is_cap & Form:C1466.is_cap
$is_marker:=$is_marker & Form:C1466.is_marker
$is_join:=$is_join & Form:C1466.is_join

$vJ_widget.is_cap:=$is_cap
$vJ_widget.is_marker:=$is_marker
$vJ_widget.is_join:=$is_join

// Patch for heigt depending on $is_cap | $is_marker | $is_join
$is_toolsOnTop:=Form:C1466.is_toolsOnTop
$is_palettesOnTop:=Form:C1466.is_palettesOnTop
If (Not:C34($is_toolsOnTop & $is_palettesOnTop))
	//wos_getSize("basic"; ->$vL_w; ->$vL_h; $vT_wos_stroke)
	$vJ_widget.getSize("basic"; ->$vL_w; ->$vL_h)
	OBJECT GET COORDINATES:C663(*; $vT_wos_stroke; $vL_left; $vL_top; $vL_right; $vL_bottom)
	OBJECT SET COORDINATES:C1248(*; $vT_wos_stroke; $vL_left; $vL_top; $vL_left+$vL_w; $vL_top+$vL_h)
	$vJ_widget.resize()
End if 


//
$is_visibility:=Form:C1466.is_visibility

$vJ_edit:=New object:C1471
$vJ_edit.is_editing:=True:C214

ARRAY TEXT:C222($aT_widgets; 0)
ARRAY BOOLEAN:C223($aB_widgets_enabled; 0)
APPEND TO ARRAY:C911($aT_widgets; "wos_zoom")
APPEND TO ARRAY:C911($aB_widgets_enabled; True:C214)
APPEND TO ARRAY:C911($aT_widgets; "wos_rotate")
APPEND TO ARRAY:C911($aB_widgets_enabled; $is_all)
APPEND TO ARRAY:C911($aT_widgets; "wos_text")
APPEND TO ARRAY:C911($aB_widgets_enabled; $is_font)
APPEND TO ARRAY:C911($aT_widgets; $vT_wos_stroke)
APPEND TO ARRAY:C911($aB_widgets_enabled; $is_stroke)
APPEND TO ARRAY:C911($aT_widgets; "wos_fill")
APPEND TO ARRAY:C911($aB_widgets_enabled; $is_fill)

$tt:=Size of array:C274($aT_widgets)
If ($is_toolsOnTop & $is_palettesOnTop)
	$y:=0
	$x:=0
	For ($i; 1; $tt)  // Horizontal stacking
		$vT_gws_widget:=$aT_widgets{$i}
		OBJECT GET COORDINATES:C663(*; $vT_gws_widget; $vL_left; $vL_top; $vL_right; $vL_bottom)
		If ($is_visibility)
			$is_visible:=$aB_widgets_enabled{$i}
			$is_enabled:=True:C214
		Else 
			$is_visible:=True:C214
			$is_enabled:=$aB_widgets_enabled{$i}
		End if 
		
		If ($i=1)  // All referenced to zoom
			If ($is_visible)
				$x:=$vL_right+$vL_widgets_margin  // After zoom
			Else 
				$x:=$vL_left+$vL_widgets_margin  // NC, always true... Keep it for later
			End if 
		Else 
			If ($i#2)
				If ($is_visible)  // Stack enabled widgets after first
					$vL_w:=$vL_right-$vL_left
					OBJECT SET COORDINATES:C1248(*; $vT_gws_widget; $x; $vL_top; $x+$vL_w; $vL_bottom)
					$x:=$x+$vL_w+$vL_widgets_margin
				End if 
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603(*; $vT_gws_widget; $is_visible)
		$vJ_widget:=wos_getWidget($vT_gws_widget)
		$vJ_widget.is_editing:=$is_enabled
		$vJ_widget.redraw()
	End for 
	
Else 
	$y:=0
	For ($i; 1; $tt)  // Vertical stacking
		$vT_gws_widget:=$aT_widgets{$i}
		OBJECT GET COORDINATES:C663(*; $vT_gws_widget; $vL_left; $vL_top; $vL_right; $vL_bottom)
		If ($is_visibility)
			$is_visible:=$aB_widgets_enabled{$i}
			$is_enabled:=True:C214
		Else 
			$is_visible:=True:C214
			$is_enabled:=$aB_widgets_enabled{$i}
		End if 
		
		If ($i=1)  // All referenced to zoom
			If ($is_visible)
				$y:=$vL_bottom+$vL_widgets_margin  // After zoom
			Else 
				$y:=$vL_top+$vL_widgets_margin  // NC, always true... Keep it for later
			End if 
		Else 
			If ($is_visible)  // Stack enabled widgets after first
				$vL_h:=$vL_bottom-$vL_top
				OBJECT SET COORDINATES:C1248(*; $vT_gws_widget; $vL_left; $y; $vL_right; $y+$vL_h)
				$y:=$y+$vL_h+$vL_widgets_margin
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603(*; $vT_gws_widget; $is_visible)
		$vJ_widget:=wos_getWidget($vT_gws_widget)
		$vJ_widget.is_editing:=$is_enabled
		$vJ_widget.redraw()
	End for 
End if 

