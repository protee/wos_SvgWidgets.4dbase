//%attributes = {"invisible":true,"lang":"en"}
// Project Method: __compiler_init_svg
//
// Parameter Type Description
//
//
// Description:
// All the initialization for the SVG module
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.

var $vJ_stuff : Object
$vJ_stuff:=New shared object:C1526
Use (Storage:C1525)
	Storage:C1525.j_stuff:=$vJ_stuff
End use 
Use ($vJ_stuff)
	
	$vJ_stuff.t_xml_null:="0"*32
	
	C_TEXT:C284($vT_reserved_name)
	$vT_reserved_name:=".reserved"  // All reserved types
	$vJ_stuff.t_reserved:=$vT_reserved_name
	$vJ_stuff.t_reserved_p:=$vT_reserved_name+"_p"  // Paper
	$vJ_stuff.t_reserved_m:=$vT_reserved_name+"_m"  // margins
	
	// Used svgE_EDIT_get_objects ; svgE_DOM_ELEMENT_MOVE
	$vJ_stuff.l_count_items_back:=3  // N there (and <def 4D>)
	
	x__storage_at_push($vJ_stuff; "at_text_align"; "left"; "center"; "right")
	// <>aT_stroke_marker
	x__storage_at_push($vJ_stuff; "at_stroke_marker"; "None"; "Start"; "End"; "Both")
	// <>aT_stroke_linejoin
	x__storage_at_push($vJ_stuff; "at_stroke_linejoin"; "Miter"; "Round"; "Bevel")
	// <>aT_stroke_linecap
	x__storage_at_push($vJ_stuff; "at_stroke_linecap"; "Butt"; "Round"; "Square")
	
	// <>aT_tools_labels
	x__storage_at_push($vJ_stuff; "at_tools_labels"; "SELECT"; "TEXT"; "LINE"; "RECT"; "ROUND"; "CIRCLE"; "FREELINE"; "IMG")
	// TODO "POLYLINE";"POLYGON"
	
	var $vJ_menu : Object
	
	$vJ_menu:=New object:C1471
	$vJ_menu.t_label:="Text align"
	$vJ_menu.t_icn:=""
	x__storage_at_lbl_push($vJ_menu; "left"; "center"; "right")
	$vJ_stuff.j_menu_text_align:=OB Copy:C1225($vJ_menu; ck shared:K85:29; $vJ_stuff)
	
	$vJ_menu:=New object:C1471
	$vJ_menu.t_label:="Text style"
	$vJ_menu.t_icn:=""
	x__storage_at_lbl_push($vJ_menu; "Bold"; "Italic"; "Underline"; "Strike")
	$vJ_stuff.j_menu_text_style:=OB Copy:C1225($vJ_menu; ck shared:K85:29; $vJ_stuff)
	
	
	$vJ_menu:=New object:C1471
	$vJ_menu.t_label:="Stroke marker"
	$vJ_menu.t_icn:="images/marker/marker"
	x__storage_at_lbl_push($vJ_menu; "None"; "Start"; "End"; "Both")
	$vJ_stuff.j_menu_stroke_marker:=OB Copy:C1225($vJ_menu; ck shared:K85:29; $vJ_stuff)
	
	$vJ_menu:=New object:C1471
	$vJ_menu.t_label:="Stroke line join"
	$vJ_menu.t_icn:="images/join/join"
	x__storage_at_lbl_push($vJ_menu; "Miter"; "Round"; "Bevel")
	$vJ_stuff.j_menu_stroke_linejoin:=OB Copy:C1225($vJ_menu; ck shared:K85:29; $vJ_stuff)
	
	$vJ_menu:=New object:C1471
	$vJ_menu.t_label:="Stroke line cap"
	$vJ_menu.t_icn:="images/cap/cap"
	x__storage_at_lbl_push($vJ_menu; "Butt"; "Round"; "Square")
	$vJ_stuff.j_menu_stroke_linecap:=OB Copy:C1225($vJ_menu; ck shared:K85:29; $vJ_stuff)
	
	
	$vJ_menu:=New object:C1471
	$vJ_menu.t_label:="Tools"
	$vJ_menu.t_icn:="images/svg_tools/"
	x__storage_at_lbl_push($vJ_menu; "Select"; "Text"; "Line"; "Rect"; "Round"; "Circle"; "Freeline"; "Image")
	$vJ_stuff.j_menu_tools:=OB Copy:C1225($vJ_menu; ck shared:K85:29; $vJ_stuff)
	
End use 

var $vL_SVGOptions : Integer
$vL_SVGOptions:=SVG_Get_options
$vL_SVGOptions:=$vL_SVGOptions ?+ 5  //Create more readable code
$vL_SVGOptions:=$vL_SVGOptions ?- 6  //Beep when an error occurs
$vL_SVGOptions:=$vL_SVGOptions ?+ 11  //Set shape-rendering='crispEdges' as default
SVG_SET_OPTIONS($vL_SVGOptions)




