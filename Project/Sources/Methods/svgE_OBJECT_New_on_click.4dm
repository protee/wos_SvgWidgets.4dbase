//%attributes = {"invisible":true,"lang":"en"}

#DECLARE()->$isOk : Boolean

$isOk:=True:C214
$vT_domRef:=Form:C1466.t_domRef

svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom; $vL_font_size; $vL_font_opacity; $vL_font_style; $vL_font_align; $vL_stroke_opacity; $vL_stroke_width; $vL_stroke_marker; $vL_stroke_dash; $vL_stroke_join; $vL_stroke_cap; $vL_fill_opacity; $vL_tx; $vL_ty; $vL_sx; $vL_sy : Integer
var $vJ_canvas; $vJ_ui; $vJ_wos_text; $vJ_wos_stroke; $vJ_wos_fill; $vJ_storage_stuff : Object
var $vO_picture : Picture
var $vP_T_currentObjects : Pointer
var $vR_selection_fill_opacity; $vR_selection_stroke_opacity; $vR_selection_stroke_width; $vR_scale : Real
var $vT_domRef; $vT_tool; $vT_currentObject; $vT_font_face; $vT_font_colour; $vT_stroke_colour; $vT_fill_colour; $vT_font_align_txt; $vT_textGuideObject; $vT_markerStartId; $vT_markerStart; $vT_path; $vT_markerEndId; $vT_markerEnd : Text
$vL_zoom:=$vJ_canvas.l_zoom
$vT_tool:=$vJ_canvas.t_tool
$vT_currentObject:=$vJ_canvas.t_currentObject
//$textGuideObject:=$ob_canvas.textGuideObject

$vJ_ui:=wos__storage_prefs_ui
$vR_selection_fill_opacity:=$vJ_ui.selection_fill_opacity
$vR_selection_stroke_opacity:=$vJ_ui.selection_stroke_opacity
$vR_selection_stroke_width:=$vJ_ui.selection_stroke_width


$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")


$vR_scale:=$vL_zoom/100

// Widgets
$vJ_wos_text:=wos_getWidget("wos_text")
$vT_font_face:=$vJ_wos_text.t_face
$vL_font_size:=$vJ_wos_text.l_size
$vT_font_colour:=$vJ_wos_text.t_colour
$vL_font_opacity:=$vJ_wos_text.l_opacity
$vL_font_style:=$vJ_wos_text.l_style
$vL_font_align:=$vJ_wos_text.l_align

$vJ_wos_stroke:=wos_getWidget("wos_stroke")
$vT_stroke_colour:=$vJ_wos_stroke.t_colour
$vL_stroke_opacity:=$vJ_wos_stroke.l_opacity
$vL_stroke_width:=$vJ_wos_stroke.l_width
$vL_stroke_marker:=$vJ_wos_stroke.l_marker
$vL_stroke_dash:=$vJ_wos_stroke.l_dash
$vL_stroke_join:=$vJ_wos_stroke.l_join
$vL_stroke_cap:=$vJ_wos_stroke.l_cap

$vJ_wos_fill:=wos_getWidget("wos_fill")
$vL_fill_opacity:=$vJ_wos_fill.l_opacity
$vT_fill_colour:=$vJ_wos_fill.t_colour


$vL_tx:=MouseX/$vR_scale
$vL_ty:=MouseY/$vR_scale
$vL_sx:=1
$vL_sy:=1

$vJ_storage_stuff:=wos__storage_stuff()

Case of 
	: ($vT_tool="TEXT@")
		$vT_currentObject:=SVG_New_textArea($vT_domRef; "")
		$vJ_canvas.t_currentObject:=$vT_currentObject
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "x"; 0; "y"; 0; "fill"; $vT_font_colour; "font-size"; $vL_font_size; "font-family"; $vT_font_face; "id"; $vT_currentObject)
		If ($vL_font_style ?? 0)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "font-weight"; "bold")
		End if 
		If ($vL_font_style ?? 1)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "font-style"; "italic")
		End if 
		If ($vL_font_style ?? 2)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "text-decoration"; "underline")
		End if 
		$vT_font_align_txt:=$vJ_storage_stuff.at_text_align[$vL_font_align]
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "text-align"; $vT_font_align_txt)
		
		svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		//$vL_fill_opacity:=100
		
		//start new guide rect
		$vT_textGuideObject:=SVG_New_rect($vT_domRef; 0.5; 0.5; 1; 1; 0; 0; $vT_font_colour; $vT_font_colour; $vR_selection_stroke_width)
		$vJ_canvas.textGuideObject:=$vT_textGuideObject
		DOM SET XML ATTRIBUTE:C866($vT_textGuideObject; "fill-opacity"; $vR_selection_fill_opacity; "stroke-opacity"; $vR_selection_stroke_opacity; "id"; $vT_textGuideObject)
		svgE_OBJECT_set_transform($vT_textGuideObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
		SET TIMER:C645(1)
		
		
	: ($vT_tool="CIRCLE@")
		If (Shift down:C543)
			$vT_currentObject:=SVG_New_circle($vT_domRef; 0; 0; 1; $vT_stroke_colour; $vT_fill_colour; $vL_stroke_width)
			$vJ_canvas.t_currentObject:=$vT_currentObject
			SVG_SET_ID($vT_currentObject; $vT_currentObject)
			SVG_SET_OPACITY($vT_currentObject; $vL_fill_opacity; $vL_stroke_opacity)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-dasharray"; String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash))
			
			svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
			APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
			
		Else 
			$vT_currentObject:=SVG_New_ellipse($vT_domRef; 0; 0; 1; 1; $vT_stroke_colour; $vT_fill_colour; $vL_stroke_width)
			$vJ_canvas.t_currentObject:=$vT_currentObject
			SVG_SET_ID($vT_currentObject; $vT_currentObject)
			SVG_SET_OPACITY($vT_currentObject; $vL_fill_opacity; $vL_stroke_opacity)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-dasharray"; String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash))
			
			svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
			APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
			
		End if 
		SET TIMER:C645(1)
		
		
	: ($vT_tool="RECT@")
		$vT_currentObject:=SVG_New_rect($vT_domRef; 0; 0; 2; 2; 0; 0; $vT_stroke_colour; $vT_fill_colour; $vL_stroke_width)
		$vJ_canvas.t_currentObject:=$vT_currentObject
		SVG_SET_ID($vT_currentObject; $vT_currentObject)
		SVG_SET_OPACITY($vT_currentObject; $vL_fill_opacity; $vL_stroke_opacity)
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-linejoin"; $vJ_storage_stuff.at_stroke_linejoin[$vL_stroke_join])
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-dasharray"; String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash))
		
		svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		SET TIMER:C645(1)
		
		
	: ($vT_tool="ROUND@")
		$vT_currentObject:=SVG_New_rect($vT_domRef; 0; 0; 2; 2; 10; 10; $vT_stroke_colour; $vT_fill_colour; $vL_stroke_width)
		$vJ_canvas.t_currentObject:=$vT_currentObject
		SVG_SET_ID($vT_currentObject; $vT_currentObject)
		SVG_SET_OPACITY($vT_currentObject; $vL_fill_opacity; $vL_stroke_opacity)
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-linejoin"; $vJ_storage_stuff.at_stroke_linejoin[$vL_stroke_join])
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-dasharray"; String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash))
		
		svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		SET TIMER:C645(1)
		
		
	: ($vT_tool="LINE@")
		$vT_currentObject:=SVG_New_line($vT_domRef; 0; 0; 0; 0; $vT_stroke_colour; $vL_stroke_width)
		$vJ_canvas.t_currentObject:=$vT_currentObject
		SVG_SET_ID($vT_currentObject; $vT_currentObject)
		//SVG_SET_OPACITY ($currentObject;0;100)
		SVG_SET_OPACITY($vT_currentObject; 0; $vL_stroke_opacity)
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-dasharray"; String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash))
		SVG_SET_STROKE_LINECAP($vT_currentObject; $vJ_storage_stuff.at_stroke_linecap[$vL_stroke_cap])
		
		svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
		//$vL_fill_opacity:=100
		
		If ($vL_stroke_marker ?? 0)  // Left
			$vT_markerStartId:=$vT_currentObject+".marker.start"
			$vT_markerStart:=SVG_Define_marker($vT_domRef; $vT_markerStartId; 5; 3; 6; 6)
			DOM SET XML ATTRIBUTE:C866($vT_markerStart; "orient"; "auto"; "fill"; $vT_stroke_colour)
			$vT_path:=SVG_New_polygon($vT_markerStart; "5,1 1,3 5,5")
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-start"; "url(#"+$vT_markerStartId+")")
		End if 
		
		If ($vL_stroke_marker ?? 1)  // Right
			$vT_markerEndId:=$vT_currentObject+".marker.end"
			$vT_markerEnd:=SVG_Define_marker($vT_domRef; $vT_markerEndId; 1; 3; 6; 6)
			DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "orient"; "auto"; "fill"; $vT_stroke_colour)
			$vT_path:=SVG_New_polygon($vT_markerEnd; "1,1 1,5 5,3")
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-end"; "url(#"+$vT_markerEndId+")")
		End if 
		
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		SET TIMER:C645(1)
		
		
	: ($vT_tool="FREELINE@")
		$vT_currentObject:=SVG_New_polyline($vT_domRef; "0,0"; $vT_stroke_colour; $vT_fill_colour; $vL_stroke_width)
		$vJ_canvas.t_currentObject:=$vT_currentObject
		SVG_SET_ID($vT_currentObject; $vT_currentObject)
		//SVG_SET_OPACITY ($currentObject;0;100)
		SVG_SET_OPACITY($vT_currentObject; 0; $vL_stroke_opacity)
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-dasharray"; String:C10($vL_stroke_dash)+","+String:C10($vL_stroke_dash))
		DOM SET XML ATTRIBUTE:C866($vT_currentObject; "stroke-linejoin"; $vJ_storage_stuff.at_stroke_linejoin[$vL_stroke_join])
		//DOM SET XML ATTRIBUTE($currentObject;"stroke-linecap";<>T_stroke_linecap{$stroke_cap+1})
		SVG_SET_STROKE_LINECAP($vT_currentObject; $vJ_storage_stuff.at_stroke_linecap[$vL_stroke_cap])
		svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
		APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		
		//$vL_fill_opacity:=0
		
		If ($vL_stroke_marker ?? 0)  // left
			$vT_markerStartId:=$vT_currentObject+".marker.start"
			$vT_markerStart:=SVG_Define_marker($vT_domRef; $vT_markerStartId; 5; 3; 6; 6)
			DOM SET XML ATTRIBUTE:C866($vT_markerStart; "orient"; "auto"; "fill"; $vT_stroke_colour)
			$vT_path:=SVG_New_polygon($vT_markerStart; "5,1 1,3 5,5")
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-start"; "url(#"+$vT_markerStartId+")")
		End if 
		
		If ($vL_stroke_marker ?? 1)  // Right
			$vT_markerEndId:=$vT_currentObject+".marker.end"
			$vT_markerEnd:=SVG_Define_marker($vT_domRef; $vT_markerEndId; 1; 3; 6; 6)
			DOM SET XML ATTRIBUTE:C866($vT_markerEnd; "orient"; "auto"; "fill"; $vT_stroke_colour)
			$vT_path:=SVG_New_polygon($vT_markerEnd; "1,1 1,5 5,3")
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "marker-end"; "url(#"+$vT_markerEndId+")")
		End if 
		SET TIMER:C645(1)
		
		
	: ($vT_tool="IMG@")
		
		//C_OBJECT($ob_ui)
		//$ob_ui:=wos__storage_prefs_ui
		//$selection_fill:=$ob_ui.selection_fill
		//$selection_stroke:=$ob_ui.selection_stroke
		//C_REAL($selection_fill_opacity;$selection_stroke_opacity;$selection_stroke_width)
		//$selection_fill_opacity:=$ob_ui.selection_fill_opacity
		//$selection_stroke_opacity:=$ob_ui.selection_stroke_opacity
		//$selection_stroke_width:=$ob_ui.selection_stroke_width
		
		//  // Rect to be changed after, once the picture defined -> EDIT_picture
		//$currentObject:=SVG_New_rect ($domRef;0;0;0;0;0;0;$selection_stroke;$selection_fill;$selection_stroke_width)
		//$ob_canvas.t_currentObject:=$currentObject
		//DOM SET XML ATTRIBUTE($currentObject;"fill-opacity";$selection_fill_opacity;"stroke-opacity";$selection_stroke_opacity;"id";$currentObject)
		//svgE_OBJECT_set_transform ($currentObject;$vL_tx;$vL_ty;$vL_sx;$vL_sy)
		//APPEND TO ARRAY($vP_T_currentObjects->;$currentObject)
		//SET TIMER(1)
		
		$isOk:=OB Is defined:C1231($vJ_canvas; "picture")
		If ($isOk)
			If ($vL_fill_opacity<50)
				$vL_fill_opacity:=100
				$vJ_wos_fill.l_opacity:=$vL_fill_opacity
				$vJ_wos_fill.redraw()
			End if 
			
			$vO_picture:=$vJ_canvas.picture
			OB REMOVE:C1226($vJ_canvas; "picture")
			$vT_currentObject:=SVG_New_embedded_image($vT_domRef; $vO_picture; 0; 0)
			$vJ_canvas.t_currentObject:=$vT_currentObject
			SVG_SET_ID($vT_currentObject; $vT_currentObject)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "opacity"; $vL_fill_opacity/100)
			DOM SET XML ATTRIBUTE:C866($vT_currentObject; "width"; 0; "height"; 0)
			svgE_OBJECT_set_transform($vT_currentObject; $vL_tx; $vL_ty; $vL_sx; $vL_sy)
			APPEND TO ARRAY:C911($vP_T_currentObjects->; $vT_currentObject)
		End if 
		SET TIMER:C645(1)
		
		
	Else 
		$isOk:=False:C215
		
End case 

