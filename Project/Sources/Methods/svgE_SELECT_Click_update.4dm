//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas; $vJ_polyline : Object
svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline)

var $vL_zoom; $vL_clickX; $vL_clickY : Integer
$vL_zoom:=$vJ_canvas.l_zoom
$vL_clickX:=$vJ_canvas.l_clickX
$vL_clickY:=$vJ_canvas.l_clickY
var $vT_currentSelectArea : Text
$vT_currentSelectArea:=$vJ_canvas.t_currentSelectArea
var $vT_tool : Text
$vT_tool:=$vJ_canvas.t_tool


var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vT_selection_fill; $vT_selection_stroke : Text
$vT_selection_fill:=$vJ_ui.selection_fill
$vT_selection_stroke:=$vJ_ui.selection_stroke
var $vR_selection_fill_opacity; $vR_selection_stroke_opacity; $vR_selection_stroke_width : Real
$vR_selection_fill_opacity:=$vJ_ui.selection_fill_opacity
$vR_selection_stroke_opacity:=$vJ_ui.selection_stroke_opacity
$vR_selection_stroke_width:=$vJ_ui.selection_stroke_width


var $vP_canvas; $vP_aT_currentObjects; $vP_aT_polylineHandles : Pointer
$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
$vP_aT_polylineHandles:=OBJECT Get pointer:C1124(Object named:K67:5; "T_polylineHandles")

var $vT_xml_null : Text
$vT_xml_null:=wos__storage_stuff.t_xml_null


var $vR_scale : Real
If ($vL_zoom=0)
	$vR_scale:=1
Else 
	$vR_scale:=$vL_zoom/100
End if 

var $isOk : Boolean
$isOk:=False:C215
SET TIMER:C645(0)

var $i; $vL_h : Integer

//delete any old selection rect

svgE_SELECT_Clear
$vJ_canvas.pasteOffsetX:=0
$vJ_canvas.pasteOffsetY:=0

If (Length:C16($vT_currentSelectArea)#0)
	DOM REMOVE XML ELEMENT:C869($vT_currentSelectArea)
	$vJ_canvas.t_currentSelectArea:=""
	svgE_FORM_canvas_redraw
End if 

//get the current object, highlighted or not
var $vT_currentObject : Text
$vT_currentObject:=SVG Find element ID by coordinates:C1054($vP_canvas->; $vL_clickX; $vL_clickY)
var $vT_reserved_name : Text
$vT_reserved_name:=wos__storage_stuff.t_reserved
If ($vT_currentObject=($vT_reserved_name+"@"))
	$vT_currentObject:=""
	$vJ_canvas.t_currentObject:=$vT_currentObject
End if 

//update selection
If ($vT_currentObject#"")
	$vJ_canvas.t_currentObject:=$vT_currentObject
	SET CURSOR:C469(9002)
	
	Case of 
		: ($vT_currentObject="@.point.@")
			ARRAY LONGINT:C221($aL_pos; 0)
			ARRAY LONGINT:C221($aL_len; 0)
			
			If (Match regex:C1019("(.+)\\.point\\.(\\d+)"; $vT_currentObject; 1; $aL_pos; $aL_len))
				$vP_aT_polylineHandles->:=Num:C11(Substring:C12($vT_currentObject; $aL_pos{2}; $aL_len{2}))
				$vT_currentObject:=Substring:C12($vT_currentObject; $aL_pos{1}; $aL_len{1})
				$vJ_canvas.t_currentObject:=$vT_currentObject
				$vJ_polyline.t_currentObject:=$vT_currentObject
			End if 
			
		: ($vT_currentObject="@.tl")
			$vJ_canvas.currentHandle:="tl"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".tl"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			
			//DOM GET XML ELEMENT NAME($vT_currentObject;$objectType)
			//If ($objectType="line")  //allow negative width and height for transform to work
			var $vT_rect : Text
			//$vT_rect:=DOM Find XML element by ID($domRef;$vT_currentObject+".select")
			//If ($vT_rect#$vT_xml_null)
			//C_REAL($x1;$x2;$y1;$y2)
			//DOM GET XML ATTRIBUTE BY NAME($vT_currentObject;"x1";$x1)
			//DOM GET XML ATTRIBUTE BY NAME($vT_currentObject;"y1";$y1)
			//DOM GET XML ATTRIBUTE BY NAME($vT_currentObject;"x2";$x2)
			//DOM GET XML ATTRIBUTE BY NAME($vT_currentObject;"y2";$y2)
			
			//Case of
			//: ($x2>0) & ($y2>0)  // +,+ : x,y is top left
			//$h:=Abs($y2-$y1)
			//$w:=Abs($x2-$x1)
			//$x:=$x1
			//$y:=$y1
			
			//: ($x2>0) & ($y2<0)  // +,- : x,y is bottom left
			//$h:=-Abs($y2-$y1)
			//$w:=Abs($x2-$x1)
			//$x:=$x1
			//$y:=$y2
			
			//: ($x2<0) & ($y2>0)  // -,+ : x,y is top right
			//$h:=Abs($y2-$y1)
			//$w:=-Abs($x2-$x1)
			//$x:=$x2
			//$y:=$y1
			
			//: ($x2<0) & ($y2<0)  // -,- : x,y is bottom right
			//$h:=-Abs($y2-$y1)
			//$w:=-Abs($x2-$x1)
			//$x:=$x2
			//$y:=$y2
			//End case
			// //DOM SET XML ATTRIBUTE($vT_rect;"x";$x;"y";$y;"width";$w;"height";$h)
			
			//End if
			//End if
			SET CURSOR:C469(9005)
			
		: ($vT_currentObject="@.tm")
			$vJ_canvas.currentHandle:="tm"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".tm"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9004)
			
		: ($vT_currentObject="@.tr")
			$vJ_canvas.currentHandle:="tr"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".tr"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9006)
			
		: ($vT_currentObject="@.bl")
			$vJ_canvas.currentHandle:="bl"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".bl"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9006)
			
		: ($vT_currentObject="@.bm")
			$vJ_canvas.currentHandle:="bm"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".bm"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9004)
			
		: ($vT_currentObject="@.br")
			$vJ_canvas.currentHandle:="br"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".br"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9005)
			
		: ($vT_currentObject="@.ml")
			$vJ_canvas.currentHandle:="ml"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".ml"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9003)
			
		: ($vT_currentObject="@.mr")
			$vJ_canvas.currentHandle:="mr"
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".mr"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			$vJ_canvas.currentHandleObject:=$vT_currentObject
			SET CURSOR:C469(9003)
			
		: ($vT_currentObject="@.select")  //already highlighted
			$vT_currentObject:=Replace string:C233($vT_currentObject; ".select"; "")
			$vJ_canvas.t_currentObject:=$vT_currentObject
			
			If (Shift down:C543)  //remove from selection
				$i:=Find in array:C230($vP_aT_currentObjects->; $vT_currentObject)
				If ($i#-1)
					DELETE FROM ARRAY:C228($vP_aT_currentObjects->; $i)
					$isOk:=$isOk | svgE_SELECT_Clear_selection($vT_currentObject)
					$vJ_canvas.t_currentObject_old:=$vT_currentObject
					$vT_currentObject:=""
					$vJ_canvas.t_currentObject:=$vT_currentObject
					SET TIMER:C645(1)  //prepare to record history on mouse up
				End if 
				
			Else 
				$vJ_canvas.currentHandleObject:=$vT_currentObject
				$vJ_canvas.t_currentObject_old:=$vT_currentObject
			End if 
			
		Else   //highlight it
			
			var $vB_cancelPolyLine : Boolean
			
			If (Size of array:C274($vP_aT_polylineHandles->)#0)
				$vB_cancelPolyLine:=True:C214
				For ($i; 1; Size of array:C274($vP_aT_polylineHandles->))
					DOM REMOVE XML ELEMENT:C869($vP_aT_polylineHandles->{$i})
				End for 
				$isOk:=True:C214
				ARRAY TEXT:C222($vP_aT_polylineHandles->; 0)
			End if 
			
			$i:=Find in array:C230($vP_aT_currentObjects->; $vT_currentObject)
			If ($i=-1)  //not in selection
				If (Shift down:C543)  //add to selection
					APPEND TO ARRAY:C911($vP_aT_currentObjects->; $vT_currentObject)
				Else   //replace selection
					var $tt : Integer
					var $vT_idx_currentObjects : Text
					$tt:=Size of array:C274($vP_aT_currentObjects->)
					For ($i; 1; $tt)
						$vT_rect:=DOM Find XML element by ID:C1010($vT_domRef; $vP_aT_currentObjects->{$i}+".select")
						If ($vT_rect#$vT_xml_null)
							DOM REMOVE XML ELEMENT:C869($vT_rect)
							$isOk:=True:C214
						End if 
						ARRAY TEXT:C222($aT_handles; 8)
						$vT_idx_currentObjects:=$vP_aT_currentObjects->{$i}
						$aT_handles{1}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".tl")
						$aT_handles{2}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".tm")
						$aT_handles{3}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".tr")
						$aT_handles{4}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".ml")
						$aT_handles{5}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".mr")
						$aT_handles{6}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".bl")
						$aT_handles{7}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".bm")
						$aT_handles{8}:=DOM Find XML element by ID:C1010($vT_domRef; $vT_idx_currentObjects+".br")
						For ($vL_h; 1; 8)
							If ($aT_handles{$vL_h}#$vT_xml_null)
								DOM REMOVE XML ELEMENT:C869($aT_handles{$vL_h})
								$isOk:=True:C214
							End if 
						End for 
					End for 
					ARRAY TEXT:C222($vP_aT_currentObjects->; 1)
					$vP_aT_currentObjects->{1}:=$vT_currentObject
				End if 
				$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
				$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
				
			Else   //already in selection
				If ($vB_cancelPolyLine)
					$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
					$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
				End if 
			End if 
			SET CURSOR:C469(9002)
	End case 
	
	
Else   //clicked in an empty area
	
	
	$tt:=Size of array:C274($vP_aT_currentObjects->)
	For ($i; 1; $tt)
		$vT_idx_currentObjects:=$vP_aT_currentObjects->{$i}
		svgE_SELECT_Clear_selection($vT_idx_currentObjects)
	End for 
	
	
	For ($i; 1; Size of array:C274($vP_aT_polylineHandles->))
		DOM REMOVE XML ELEMENT:C869($vP_aT_polylineHandles->{$i})
	End for 
	
	ARRAY TEXT:C222($vP_aT_currentObjects->; 0)
	ARRAY TEXT:C222($vP_aT_polylineHandles->; 0)
	
	//start new selection rect $selection_fill_opacity;$selection_stroke_opacity;$selection_stroke_width
	$vT_currentSelectArea:=SVG_New_rect($vT_domRef; 0.5; 0.5; 1; 1; 0; 0; $vT_selection_stroke; $vT_selection_fill; $vR_selection_stroke_width)
	//$vT_currentSelectArea:=SVG_New_rect ($domRef;0;0;0;0;0;0;$vT_selection_stroke;$vT_selection_fill;$selection_stroke_width)
	DOM SET XML ATTRIBUTE:C866($vT_currentSelectArea; "fill-opacity"; $vR_selection_fill_opacity; "stroke-opacity"; $vR_selection_stroke_opacity; "id"; $vT_currentSelectArea)
	$vJ_canvas.t_currentSelectArea:=$vT_currentSelectArea
	
	var $vR_sx; $vR_sy; $vR_tx; $vR_ty : Real
	$vR_tx:=MouseX/$vR_scale
	$vR_ty:=MouseY/$vR_scale
	$vR_sx:=1
	$vR_sy:=1
	svgE_OBJECT_set_transform($vT_currentSelectArea; $vR_tx; $vR_ty; $vR_sx; $vR_sy)
	$isOk:=True:C214
	SET CURSOR:C469(0)
	
End if 

If (Length:C16($vJ_canvas.currentHandleObject)#0)  //a handle is clicked
	SET TIMER:C645(1)
End if 
If (Length:C16($vT_currentSelectArea)#0)  //new selection rect was created
	SET TIMER:C645(1)
End if 
If (Length:C16($vJ_polyline.t_currentObject)#0)  //a polyline handle is clicked
	SET TIMER:C645(1)
End if 
$0:=$isOk

