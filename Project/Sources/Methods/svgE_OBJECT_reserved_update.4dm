//%attributes = {"invisible":true,"lang":"en"}

var $vL_canvas_width; $vL_canvas_height : Integer
var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_paper_width; $vL_paper_height; $vL_margin_left; $vL_margin_top; $vL_margin_right; $vL_margin_bottom; $vL_area_left; $vL_area_top; $vL_area_width; $vL_area_height : Integer
var $vJ_canvas; $vJ_ui; $vJ_widget; $vJ_stuff; $vJ_paper; $vJ_margin : Object
var $vP_canvas : Pointer
var $vT_domRef; $vT_paper_fillColour; $vT_margins_strokeColour; $vT_margins_fillColour; $vT_xml_null; $vT_reserved_name_p; $vT_reserved_name_m; $vT_reservedObject : Text
If (Count parameters:C259>=2)
	$vL_canvas_width:=$1
	$vL_canvas_height:=$2
Else 
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_canvas_width:=$vL_right-$vL_left
	$vL_canvas_height:=$vL_bottom-$vL_top
End if 


$vT_domRef:=Form:C1466.t_domRef

svgE_getStuff_vJ(->$vJ_canvas)


// Colors
$vJ_ui:=wos__storage_prefs_ui()
$vT_paper_fillColour:=$vJ_ui.t_paper_fillColour
$vT_margins_strokeColour:=$vJ_ui.t_margins_strokeColour
$vT_margins_fillColour:=$vJ_ui.t_margins_fillColour

$vJ_widget:=Form:C1466
$vJ_stuff:=wos__storage_stuff()
$vT_xml_null:=$vJ_stuff.t_xml_null
$vT_reserved_name_p:=$vJ_stuff.t_reserved_p
$vT_reserved_name_m:=$vJ_stuff.t_reserved_m

$vJ_paper:=$vJ_widget.j_paper
$vL_paper_width:=$vJ_paper.l_width
$vL_paper_height:=$vJ_paper.l_height
$vT_reservedObject:=DOM Find XML element by ID:C1010($vT_domRef; $vT_reserved_name_p)
If ($vT_reservedObject#$vT_xml_null)
	DOM SET XML ATTRIBUTE:C866($vT_reservedObject; "x"; 0; "y"; 0; "width"; $vL_paper_width; "height"; $vL_paper_height; "fill"; $vT_paper_fillColour)
End if 

$vT_domRef:=Form:C1466.t_domRef
//SVG_SET_DIMENSIONS ($domRef;$canvas_width;$canvas_height;"pt")
//SVG_SET_VIEWBOX ($domRef;0;0;$canvas_width;$canvas_height)
//SVG_SET_VIEWBOX ($domRef;0;0;$paper_width;$paper_height)

SVG_SET_DIMENSIONS($vT_domRef; $vL_paper_width; $vL_paper_height; "pt")
//SVG_SET_VIEWBOX ($domRef;0;0;$canvas_width;$canvas_height)

$vJ_margin:=$vJ_widget.j_margin
$vL_margin_left:=$vJ_margin.l_left
$vL_margin_top:=$vJ_margin.l_top
$vL_margin_right:=$vJ_margin.l_right
$vL_margin_bottom:=$vJ_margin.l_bottom
$vL_area_left:=$vL_margin_left
$vL_area_top:=$vL_margin_top
$vL_area_width:=$vL_paper_width-($vL_margin_left+$vL_margin_right)
$vL_area_height:=$vL_paper_height-($vL_margin_top+$vL_margin_bottom)

$vT_reservedObject:=DOM Find XML element by ID:C1010($vT_domRef; $vT_reserved_name_m)
If ($vT_reservedObject#$vT_xml_null)
	DOM SET XML ATTRIBUTE:C866($vT_reservedObject; "x"; $vL_area_left; "y"; $vL_area_top; "width"; $vL_area_width; "height"; $vL_area_height; "stroke"; $vT_margins_strokeColour; "fill"; $vT_margins_fillColour)
End if 

