//%attributes = {"invisible":true,"lang":"en"}
// Project Method: svgE_SELECT_contextual_click
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 02/03/2021   OG   Initial version.

#DECLARE()->$isOk : Boolean

var $is_text; $is_line; $is_rect; $is_circle; $is_polyline; $is_image; $is_editable; $is_stroke; $is_marker; $is_cap; $is_join; $is_fill; $is_font; $is_all : Boolean
var $vL_count_selected; $vL_space; $vL_count_colors; $vL_zoom; $vL_color_idx; $vL_style; $vL_idx : Integer
var $vL_color : Integer
var $vJ_canvas; $vJ_wos_tools; $vJ_wos_zoom; $vJ_wos_rotate; $vJ_wos_fill; $vJ_wos_stroke; $vJ_wos_text; $vJ_space : Object
var $vP_textEditArea : Pointer
var $vT_wos_tools; $vT_wos_zoom; $vT_wos_rotate; $vT_wos_fill; $vT_wos_stroke; $vT_wos_text; $vT_refMenu; $vT_menu; $vT_tool; $vT_edit; $vT_colour; $vT_ColourName; $vT_ColourRGB : Text

svgE_getStuff_vJ(->$vJ_canvas)

$vL_count_selected:=svgE_EDIT_inventory(->$is_text; ->$is_line; ->$is_rect; ->$is_circle; ->$is_polyline; ->$is_image)

$is_editable:=x__get_editable()

$vT_wos_tools:="wos_tools"
$vT_wos_zoom:="wos_zoom"
$vT_wos_rotate:="wos_rotate"
$vT_wos_fill:="wos_fill"
$vT_wos_stroke:="wos_stroke"
$vT_wos_text:="wos_text"

$vJ_wos_tools:=wos_getWidget($vT_wos_tools)
$vJ_wos_zoom:=wos_getWidget($vT_wos_zoom)
$vJ_wos_rotate:=wos_getWidget($vT_wos_rotate)
$vJ_wos_fill:=wos_getWidget($vT_wos_fill)
$vJ_wos_stroke:=wos_getWidget($vT_wos_stroke)
$vJ_wos_text:=wos_getWidget($vT_wos_text)
$vL_space:=woc__storage_prefs.l_space

$vT_refMenu:=Create menu:C408()
If ($is_editable)
	svgE_MENU_tools($vT_refMenu; $vJ_wos_tools)
	svgE_MENU_edit($vT_refMenu)
End if 
svgE_MENU_zoom($vT_refMenu; $vJ_wos_zoom)
If (Form:C1466.is_spaces)
	woc_space_menu($vL_space; "space"; 0; $vT_refMenu)
End if 
If ($is_editable)
	$is_stroke:=$is_line | $is_rect | $is_circle | $is_polyline
	// Stroke options
	$is_marker:=$is_line | $is_polyline  // For option "marker"
	$is_cap:=$is_line | $is_polyline | $is_circle | $is_rect  // For option "join"
	$is_join:=$is_polyline | $is_rect  // For option "join"
	
	$is_marker:=$is_marker & Form:C1466.is_marker
	$is_cap:=$is_cap & Form:C1466.is_cap
	$is_join:=$is_join & Form:C1466.is_join
	
	$is_fill:=$is_rect | $is_circle | $is_polyline | $is_image
	$is_font:=$is_text
	$is_all:=($vL_count_selected#0)  //($objectType#"")
	
	If ($vL_count_selected>0)  // For specifics
		APPEND MENU ITEM:C411($vT_refMenu; "-")
		svgE_MENU_rotate($vT_refMenu; $vJ_wos_rotate)
		If ($is_font)
			svgE_MENU_text($vT_refMenu; $vJ_wos_text; $vL_space)
		End if 
		If ($is_stroke)
			svgE_MENU_stroke($vT_refMenu; $vJ_wos_stroke; $is_marker; $is_cap; $is_join; $vL_space)
		End if 
		If ($is_fill)
			svgE_MENU_fill($vT_refMenu; $vJ_wos_fill; $vL_space)
		End if 
		If ($vL_count_selected>=1)
			APPEND MENU ITEM:C411($vT_refMenu; "-")
			svgE_MENU_layers($vT_refMenu)
			If ($vL_count_selected>=2)
				svgE_MENU_align($vT_refMenu)
				svgE_MENU_distribute($vT_refMenu)
			End if 
		End if 
	End if 
End if 


// *****
// *
$vT_menu:=Dynamic pop up menu:C1006($vT_refMenu)
RELEASE MENU:C978($vT_refMenu)
// *
// *****

$isOk:=$vT_menu#""
If ($isOk)
	//$vJ_space:=woc__storage_spaces[$vL_space-1]
	$vJ_space:=woc_sp_space_get($vL_space)
	$vL_count_colors:=$vJ_space.al_rgb.length
	
	Case of 
			// ***** TOOL
		: ($vT_menu="tool-@")
			$vT_tool:=Replace string:C233($vT_menu; "tool-"; ""; 1)
			$vJ_canvas.t_tool:=$vT_tool
			$vJ_wos_tools.t_value:=$vT_tool
			$vJ_wos_tools.redraw()
			If ($vT_tool#"SELECT")
				$isOk:=svgE_EDIT_Text_validate()
				$isOk:=$isOk | svgE_SELECT_OBJ_none()
				svgE_EDIT_widgets_enabler($vT_tool)
				If ($isOk)
					svgE_FORM_canvas_redraw()
					svgE_HISTORY_Append()
				End if 
			End if 
			
			
			// ***** EDIT
			
		: ($vT_menu="edit-@")
			$vT_edit:=Replace string:C233($vT_menu; "edit-"; ""; 1)
			Case of 
				: ($vT_edit="Undo")
					svgE_ACTION_undo()
					
				: ($vT_edit="Redo")
					svgE_ACTION_redo()
					
				: ($vT_edit="Cut")
					svgE_ACTION_cut()
					
				: ($vT_edit="Copy")
					svgE_ACTION_copy()
					
				: ($vT_edit="Paste")
					svgE_ACTION_paste()
					
				: ($vT_edit="Clear")
					svgE_ACTION_delete()
					
				: ($vT_edit="Select All")
					svgE_ACTION_selectAll()
			End case 
			
			
			// ***** ZOOM
			
		: ($vT_menu="zoom-@")
			$vL_zoom:=Num:C11(Replace string:C233($vT_menu; "zoom-"; ""; 1))
			$vJ_wos_zoom.l_value:=$vL_zoom
			$vJ_canvas.l_zoom:=$vL_zoom
			$vJ_wos_zoom.redraw()
			svgE_SELECT_zoom_update()
			
			
			// ***** SPACE
		: ($vT_menu="space-@")
			Use (woc__storage_prefs())
				woc__storage_prefs.l_space:=Num:C11(Replace string:C233($vT_menu; "space-"; ""))
			End use 
			
			
			// ***** ROTATE
		: ($vT_menu="rotate-@")
			$vJ_wos_rotate.l_value:=Num:C11(Replace string:C233($vT_menu; "rotate-"; ""; 1))
			$vJ_wos_rotate.redraw()
			$isOk:=svgE_OBJECT_set_rotation()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
			
			// ***** FILL
		: ($vT_menu="fill-color-@")
			$vL_color_idx:=Num:C11(Replace string:C233($vT_menu; "fill-color-"; ""; 1))
			Case of 
				: ($vL_color_idx=$vL_count_colors)
					$vT_colour:="none"
					
				: ($vL_color_idx=($vL_count_colors+1))
					//$vT_Colour:=woc_rgbTxtFromRGB(Select RGB color($vJ_fill.color))
					$vT_colour:=woc_rgb_to_html(Select RGB color:C956($vJ_wos_fill.t_colour))
					woc_sp_colourToColours($vT_colour; ->$vT_ColourName; ->$vT_ColourRGB; k_svg_space)
					$vT_colour:=woc_sp_coloursToColour($vT_ColourName; $vT_ColourRGB; k_svg_space)
					
				Else 
					$vL_color:=woc_sp_color_from_index($vL_color_idx; $vL_space)
					$vT_colour:=woc_sp_color_to_svg($vL_color)
					woc_sp_colourToColours($vT_colour; ->$vT_ColourName; ->$vT_ColourRGB; k_svg_space)
					$vT_colour:=woc_sp_coloursToColour($vT_ColourName; $vT_ColourRGB; k_svg_space)
			End case 
			$vJ_wos_fill.t_colour:=$vT_colour
			$vJ_wos_fill.redraw()
			$isOk:=svgE_OBJECT_set_fill()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="fill-opacity-@")
			$vJ_wos_fill.l_opacity:=Num:C11(Replace string:C233($vT_menu; "fill-opacity-"; ""; 1))
			$vJ_wos_fill.redraw()
			$isOk:=svgE_OBJECT_set_fill()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
			// ***** STROKE
		: ($vT_menu="stroke-color-@")
			$vL_color_idx:=Num:C11(Replace string:C233($vT_menu; "stroke-color-"; ""; 1))
			Case of 
				: ($vL_color_idx=$vL_count_colors)
					$vT_colour:="none"
					
				: ($vL_color_idx=($vL_count_colors+1))
					//$vT_Colour:=woc_rgbTxtFromRGB(Select RGB color($vJ_stroke.color))
					$vT_colour:=woc_rgb_to_html(Select RGB color:C956($vJ_wos_stroke.t_colour))
					woc_sp_colourToColours($vT_colour; ->$vT_ColourName; ->$vT_ColourRGB; k_svg_space)
					$vT_colour:=woc_sp_coloursToColour($vT_ColourName; $vT_ColourRGB; k_svg_space)
				Else 
					//$vT_colour:=woc_rgb_to_html($vJ_space.colorRGB[$vL_colour_idx])
					$vL_color:=woc_sp_color_from_index($vL_color_idx; $vL_space)
					$vT_colour:=woc_sp_color_to_svg($vL_color)
					woc_sp_colourToColours($vT_colour; ->$vT_ColourName; ->$vT_ColourRGB; k_svg_space)
					$vT_colour:=woc_sp_coloursToColour($vT_ColourName; $vT_ColourRGB; k_svg_space)
			End case 
			$vJ_wos_stroke.t_colour:=$vT_colour
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="stroke-opacity-@")
			$vJ_wos_stroke.l_opacity:=Num:C11(Replace string:C233($vT_menu; "stroke-opacity-"; ""; 1))
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="width-@")
			$vJ_wos_stroke.l_width:=Num:C11(Replace string:C233($vT_menu; "width-"; ""; 1))
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="dash-@")
			$vJ_wos_stroke.l_dash:=Num:C11(Replace string:C233($vT_menu; "dash-"; ""; 1))
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="marker-@")
			$vJ_wos_stroke.l_marker:=Num:C11(Replace string:C233($vT_menu; "marker-"; ""; 1))
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="cap-@")
			$vJ_wos_stroke.l_cap:=Num:C11(Replace string:C233($vT_menu; "cap-"; ""; 1))
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
		: ($vT_menu="join-@")
			$vJ_wos_stroke.l_join:=Num:C11(Replace string:C233($vT_menu; "join-"; ""; 1))
			$vJ_wos_stroke.redraw()
			$isOk:=svgE_OBJECT_set_stroke()
			If ($isOk)
				svgE_FORM_canvas_redraw()
				svgE_HISTORY_Append()
			End if 
			
			
			// ***** FONT
			
		: ($vT_menu="font-@")
			$vT_menu:=Replace string:C233($vT_menu; "font-"; ""; 1)
			Case of 
				: ($vT_menu="picker")
					$vP_textEditArea:=$vJ_canvas.ptr_text
					GOTO OBJECT:C206($vP_textEditArea->)
					OPEN FONT PICKER:C1303
					
					
				: ($vT_menu="face-@")
					$vT_menu:=Replace string:C233($vT_menu; "face-"; ""; 1)
					If ($vT_menu="picker")
						BEEP:C151
					Else 
						ARRAY TEXT:C222($aT_fonts; 0)
						FONT LIST:C460($aT_fonts; Recent fonts:K80:3)
						APPEND TO ARRAY:C911($aT_fonts; $vT_menu)
						SET RECENT FONTS:C1305($aT_fonts)
						$vJ_wos_text.t_face:=$vT_menu
						$vJ_wos_text.redraw()
						$isOk:=svgE_OBJECT_set_text()
						If ($isOk)
							svgE_FORM_canvas_redraw()
							svgE_HISTORY_Append()
						End if 
					End if 
					
				: ($vT_menu="size-@")
					$vJ_wos_text.l_size:=Num:C11(Replace string:C233($vT_menu; "size-"; ""; 1))
					$vJ_wos_text.redraw()
					$isOk:=svgE_OBJECT_set_text()
					If ($isOk)
						svgE_FORM_canvas_redraw()
						svgE_HISTORY_Append()
					End if 
					
				: ($vT_menu="color-@")
					$vL_color_idx:=Num:C11(Replace string:C233($vT_menu; "color-"; ""; 1))
					Case of 
						: ($vL_color_idx=$vL_count_colors)
							$vT_colour:="none"
							
						: ($vL_color_idx=($vL_count_colors+1))
							//$vT_Colour:=woc_rgbTxtFromRGB(Select RGB color($vJ_stroke.color))
							$vT_colour:=woc_rgb_to_html(Select RGB color:C956($vJ_wos_stroke.t_colour))
							woc_sp_colourToColours($vT_colour; ->$vT_ColourName; ->$vT_ColourRGB; k_svg_space)
							$vT_colour:=woc_sp_coloursToColour($vT_ColourName; $vT_ColourRGB; k_svg_space)
						Else 
							//$vT_colour:=woc_rgb_to_html($vJ_space.colorRGB[$vL_colour_idx])
							$vL_color:=woc_sp_color_from_index($vL_color_idx; $vL_space)
							$vT_colour:=woc_sp_color_to_svg($vL_color)
							woc_sp_colourToColours($vT_colour; ->$vT_ColourName; ->$vT_ColourRGB; k_svg_space)
							$vT_colour:=woc_sp_coloursToColour($vT_ColourName; $vT_ColourRGB; k_svg_space)
					End case 
					$vJ_wos_text.t_colour:=$vT_colour
					$vJ_wos_text.redraw()
					$isOk:=svgE_OBJECT_set_text()
					If ($isOk)
						svgE_FORM_canvas_redraw()
						svgE_HISTORY_Append()
					End if 
					
				: ($vT_menu="opacity-@")
					$vJ_wos_text.l_opacity:=Num:C11(Replace string:C233($vT_menu; "opacity-"; ""; 1))
					$vJ_wos_text.redraw()
					$isOk:=svgE_OBJECT_set_text()
					If ($isOk)
						svgE_FORM_canvas_redraw()
						svgE_HISTORY_Append()
					End if 
					
				: ($vT_menu="style-@")
					$vL_style:=$vJ_wos_text.style
					$vL_idx:=Num:C11(Replace string:C233($vT_menu; "style-"; ""; 1))
					If ($vL_style ?? $vL_idx)
						$vJ_wos_text.l_style:=$vL_style ?- $vL_idx
					Else 
						$vJ_wos_text.l_style:=$vL_style ?+ $vL_idx
					End if 
					$vJ_wos_text.redraw()
					$isOk:=svgE_OBJECT_set_text()
					If ($isOk)
						svgE_FORM_canvas_redraw()
						svgE_HISTORY_Append()
					End if 
					
				: ($vT_menu="align-@")
					$vJ_wos_text.l_align:=Num:C11(Replace string:C233($vT_menu; "align-"; ""; 1))
					$vJ_wos_text.redraw()
					$isOk:=svgE_OBJECT_set_text()
					If ($isOk)
						svgE_FORM_canvas_redraw()
						svgE_HISTORY_Append()
					End if 
					
					
			End case 
			
		Else 
			$isOk:=w_svgEditor_actions($vT_menu)  // Level, Align, Distribute
			
	End case 
End if 
