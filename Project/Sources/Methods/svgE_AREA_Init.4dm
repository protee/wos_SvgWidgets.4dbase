//%attributes = {"invisible":true,"lang":"en"}


#DECLARE($vL_width : Integer; $vL_height : Integer)->$isOk : Boolean  // {#2} optionals
var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_zoom; $vL_options; $vL_opacity : Integer
var $vJ_stuff; $vJ_canvas; $vJ_polyline; $vJ_history; $vJ_widget; $vJ_storage_stuff : Object
var $vP_aT_currentObjects; $vP_textEditArea : Pointer
var $vT_tool; $vT_wos_widget; $vT_domRef; $vT_defs; $vT_reserved_name_p; $vT_reserved_name_m; $vT_reservedObject : Text
If (Count parameters:C259<2)
	OBJECT GET COORDINATES:C663(*; "Canvas"; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
End if 

$isOk:=True:C214

$vJ_stuff:=New object:C1471  // Used for local stuff
Form:C1466.j_stuff:=$vJ_stuff
$vJ_canvas:=New object:C1471
$vJ_stuff.j_canvas:=$vJ_canvas
$vJ_polyline:=New object:C1471
$vJ_stuff.j_polyline:=$vJ_polyline
$vJ_history:=New object:C1471
$vJ_stuff.j_history:=$vJ_history

$vT_tool:="SELECT"
$vJ_canvas.t_tool:=$vT_tool
$vT_wos_widget:="wos_tools"
$vJ_widget:=wos_getWidget($vT_wos_widget)
$vJ_widget.t_value:=$vT_tool
$vJ_widget.redraw()
svgE_EDIT_widgets_enabler()  //($vT_tool)

$vL_zoom:=100
$vJ_canvas.l_zoom:=$vL_zoom
$vT_wos_widget:="wos_zoom"
$vJ_widget:=wos_getWidget($vT_wos_widget)
$vJ_widget.l_value:=$vL_zoom
$vJ_widget.redraw()

$vJ_canvas.t_currentSelectArea:=""
$vJ_canvas.t_editTextObject:=""

svgE_SELECT_OBJ_none()
w_AREA_On_Unload()
svgE_HISTORY_Clear()

$vL_options:=SVG_Get_options
$vL_options:=$vL_options ?- 6
SVG_SET_OPTIONS($vL_options)

$vJ_canvas.defaultFontName:="Calibri"
$vJ_canvas.defaultFontSize:=24
$vJ_canvas.moveOffset:=10

$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
ARRAY TEXT:C222($vP_aT_currentObjects->; 0)

$vJ_canvas.textGuideObject:=""

$vJ_canvas.reservedObject:=""
$vJ_canvas.t_currentObject:=""
$vJ_canvas.t_currentObject_old:=""
$vJ_canvas.currentHandleObject:=""
$vJ_canvas.currentHandle:=""
$vP_textEditArea:=OBJECT Get pointer:C1124(Object named:K67:5; "TextEditArea")
$vJ_canvas.ptr_text:=$vP_textEditArea
OBJECT MOVE:C664($vP_textEditArea->; 0; 0; 0; 0; *)
OBJECT MOVE:C664(*; "TextEditAreaFrame"; 0; 0; 0; 0; *)

$vJ_canvas.l_zoom:=100
$vJ_canvas.l_opacity:=10

$vJ_canvas.l_rotate:=0
$vJ_canvas.l_marker:=0
$vJ_canvas.l_lineWidth:=3

Form:C1466.is_modified:=False:C215
$vJ_canvas.pasteOffsetX:=0
$vJ_canvas.pasteOffsetY:=0
$vJ_canvas.moveOffset:=10


//$CanvasData->:=SVG_New ($Width->;$Height->)
$vT_domRef:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
DOM SET XML ATTRIBUTE:C866($vT_domRef; "width"; $vL_width; "height"; $vL_height)
$vT_defs:=DOM Create XML element:C865($vT_domRef; "defs"; "id"; "4D")  //place holder
Form:C1466.t_domRef:=$vT_domRef
//svgE_OBJECT_reserved_create

$vJ_storage_stuff:=wos__storage_stuff
$vT_reserved_name_p:=$vJ_storage_stuff.t_reserved_p
$vT_reserved_name_m:=$vJ_storage_stuff.t_reserved_m
$vT_reservedObject:=SVG_New_rect($vT_domRef; 0; 0; 1; 1; 0; 0; k_none; "white"; 1)
SVG_SET_ID($vT_reservedObject; $vT_reserved_name_p)
$vT_reservedObject:=SVG_New_rect($vT_domRef; 0; 0; 1; 1; 0; 0; "grey"; k_none; 1)
SVG_SET_ID($vT_reservedObject; $vT_reserved_name_m)
$vL_opacity:=40
SVG_SET_OPACITY($vT_reservedObject; $vL_opacity; $vL_opacity)
SVG_SET_TEXT_RENDERING($vT_reservedObject; "geometricPrecision")

