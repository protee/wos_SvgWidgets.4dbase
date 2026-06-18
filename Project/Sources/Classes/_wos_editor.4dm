
Class extends _WIDGETS

Class constructor
	Super:C1705("j_editor")
	This:C1470.t_svg:=0
	// *
	// *****
	
	// *****
	// *
Function xml_dom_close()->$isOk : Boolean
	var $vT_domRef; $vT_xml_null : Text
	$vT_domRef:=String:C10(This:C1470.t_domRef)
	$isOk:=False:C215
	If (Length:C16($vT_domRef)#0)
		$vT_xml_null:=wos__storage_stuff().t_xml_null
		$isOk:=($vT_domRef#$vT_xml_null)
		If ($isOk)
			DOM CLOSE XML:C722($vT_domRef)
			This:C1470.t_domRef:=""
			$isOk:=True:C214
		End if 
	End if 
	
Function paper_fit($vR_paper_factor_WH : Real; $vP_paper_width : Pointer; $vP_paper_height : Pointer)
	var $is_byExcess : Boolean
	var $vL_wos_width; $vL_wos_height; $vL_paper_width; $vL_paper_height : Integer
	var $vR_wos_factor_WH : Real
	$is_byExcess:=($vR_paper_factor_WH<0)
	If ($is_byExcess)
		$vR_paper_factor_WH:=-$vR_paper_factor_WH
	End if 
	
	// Calculate real paper width based on widget
	This:C1470.get_canvas_wh(->$vL_wos_width; ->$vL_wos_height)
	$vR_wos_factor_WH:=$vL_wos_width/$vL_wos_height
	If ($is_byExcess)
		If ($vR_paper_factor_WH<$vR_wos_factor_WH)
			$vL_paper_width:=$vL_wos_width
			$vL_paper_height:=$vL_paper_width/$vR_paper_factor_WH
		Else 
			$vL_paper_height:=$vL_wos_height
			$vL_paper_width:=$vL_paper_height*$vR_paper_factor_WH
		End if 
	Else 
		If ($vR_paper_factor_WH<$vR_wos_factor_WH)
			$vL_paper_height:=$vL_wos_height
			$vL_paper_width:=$vL_paper_height*$vR_paper_factor_WH
		Else 
			$vL_paper_width:=$vL_wos_width
			$vL_paper_height:=$vL_paper_width/$vR_paper_factor_WH
		End if 
	End if 
	$vP_paper_width->:=$vL_paper_width
	$vP_paper_height->:=$vL_paper_height
	
	
Function paper_calculate($vL_paper_width : Integer; $vL_paper_height : Integer; $vR_margin_factor : Real; $vR_header_percent : Real)
	var $vL_margin; $vL_margin_left; $vL_margin_top; $vL_margin_right; $vL_margin_bottom; $vL_area_width; $vL_area_height : Integer
	var $vJ_paper; $vJ_margin : Object
	If (Count parameters:C259<4)
		$vR_margin_factor:=-1
	End if 
	If (Count parameters:C259<5)
		$vR_header_percent:=1
	End if 
	
	$vJ_paper:=This:C1470.j_paper
	$vJ_paper.l_width:=$vL_paper_width
	$vJ_paper.l_height:=$vL_paper_height
	
	// Margins ?
	If ($vR_margin_factor>=0)
		$vL_margin:=$vL_paper_width*$vR_margin_factor
		$vJ_margin:=This:C1470.j_margin
		$vJ_margin.l_left:=$vL_margin
		$vJ_margin.l_top:=$vL_margin
		$vJ_margin.l_right:=$vL_margin
		$vJ_margin.l_bottom:=$vL_margin
	End if 
	$vL_margin_left:=$vJ_margin.l_left
	$vL_margin_top:=$vJ_margin.l_top
	$vL_margin_right:=$vJ_margin.l_right
	$vL_margin_bottom:=$vJ_margin.l_bottom
	
	$vL_area_width:=$vL_paper_width-($vL_margin_left+$vL_margin_right)
	$vL_area_height:=$vL_paper_height-($vL_margin_top+$vL_margin_bottom)
	
	
Function get_widget_size($vP_vL_width : Pointer; $vP_vL_height : Pointer; $vT_widget : Text)  // Wrapper into subform
	//$vT_widget:=$vT_widget#"" ? $vT_widget : OBJECT Get name
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; Border None:K42:27)
	var $vJ_this : Object
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._get_widget_size($vP_vL_width; $vP_vL_height)))
	
Function set_svg($vT_svg : Text; $vT_widget : Text)  // Wrapper into subform
	//$vT_widget:=$vT_widget#"" ? $vT_widget : OBJECT Get name
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; Border None:K42:27)
	var $vJ_this : Object
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._set_svg($vT_svg)))
	
Function get_svg($vT_widget : Text)->$vT_svg : Text  // Wrapper into subform
	//$vT_widget:=$vT_widget#"" ? $vT_widget : OBJECT Get name
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; Border None:K42:27)
	var $vJ_this : Object
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._get_svg()); $vT_svg)
	
	
Function _set_svg($vT_svg : Text)
	w_svgEditor_set_svg($vT_svg)
	
Function _get_svg()->$vT_svg : Text
	$vT_svg:=w_svgEditor_get_svg()
	
	
Function _load()
	//need this declaration for interpreted mode
	//the only process variable used in this entire application!
	var $vJ_paper : Object
	$vJ_paper:=Form:C1466.j_paper
	svgE_AREA_Init($vJ_paper.l_width; $vJ_paper.l_height)
	svgE_EDIT_shortcuts_update(False:C215)
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
			
		: ($vL_event_code=On Getting Focus:K2:7)
			svgE_EDIT_shortcuts_update()
			w_AREA_On_Getting_Focus()
			
		: ($vL_event_code=On Losing Focus:K2:8)
			svgE_EDIT_shortcuts_update(False:C215)
			
			
		: ($vL_event_code=On Timer:K2:25)
			This:C1470._on_timer()
			
			
		: ($vL_event_code=On Unload:K2:2)
			If (Form:C1466.is_domToClose)
				This:C1470.xml_dom_close()
			End if 
			
	End case 
	
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height : Integer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	var $is_toolsOnTop; $is_palettes; $is_palettesOnTop : Boolean
	var $vL_widgets_margin; $x1; $vL_view_width; $x2; $vL_y_top; $vL_y_area; $vL_yt; $vL_y_bottom; $vL_w_last; $vL_h_last; $xl; $vL_w; $vL_h; $vL_yb; $vL_view_height; $vL_paper_width; $vL_paper_height; $x; $y; $vL_canvas_width; $vL_canvas_height : Integer
	var $idx : Integer
	var $vJ_widget; $vJ_paper : Object
	var $vP_canvas : Pointer
	var $vT_wos_zoom; $vT_wos_rotate; $vT_wos_font; $vT_wos_stroke; $vT_wos_fill; $vT_layout : Text
	var $vT_widget : Text
	var $vC_at_widgets : Collection
	
	$is_toolsOnTop:=Form:C1466.is_toolsOnTop
	$is_palettes:=Form:C1466.is_palettes
	$is_palettesOnTop:=Form:C1466.is_palettesOnTop
	
	$vL_widgets_margin:=wos__storage_prefs_ui.widgets_margin
	
	//OBJECT GET COORDINATES(*;"wos_zoom";$left;$top;$right;$bottom)
	//$w:=$right-$left
	$x1:=$vL_width-265
	If ($is_palettes & (Not:C34($is_toolsOnTop & $is_palettesOnTop)))
		$vL_view_width:=$x1-$vL_widgets_margin
		$x2:=$x1
	Else 
		$x2:=$vL_width
		$vL_view_width:=$x2
	End if 
	
	
	
	// Those are drawn with an height of 85 px
	$vT_wos_zoom:="wos_zoom"
	$vT_wos_rotate:="wos_rotate"
	$vT_wos_font:="wos_text"
	$vT_wos_stroke:="wos_stroke"
	$vT_wos_fill:="wos_fill"
	
	$vJ_widget:=wos_getWidget($vT_wos_stroke)
	wox_vJ_overload(Form:C1466; $vJ_widget; "is_cap"; "is_marker"; "is_join")
	
	$vC_at_widgets:=New collection:C1472()
	$vC_at_widgets.push("wos_edits"; "wos_actions"; "wos_tools")
	$vL_y_top:=0
	$vL_y_area:=$vL_y_top
	If ($is_toolsOnTop)
		If ($is_palettes)
			$vC_at_widgets.push($vT_wos_zoom)
			If ($is_palettesOnTop)
				$vC_at_widgets.push($vT_wos_rotate)
				$vC_at_widgets.push($vT_wos_font)
				$vC_at_widgets.push($vT_wos_stroke)
				$vC_at_widgets.push($vT_wos_fill)
			End if 
		End if 
		$vT_layout:=$is_palettesOnTop ? "tight" : "basic"
		$vL_yt:=$vL_y_top
		$vL_y_bottom:=0
		$vL_w_last:=0
		$vL_h_last:=0
		$xl:=-$vL_widgets_margin
		$idx:=0
		For each ($vT_widget; $vC_at_widgets)
			$vJ_widget:=wos_getWidget($vT_widget)
			$vJ_widget.getSize($vT_layout; ->$vL_w; ->$vL_h)
			$vL_yb:=$vL_yt+$vL_h
			If ($vL_yb>=$vL_y_bottom)  //| (($vL_yt=$vL_y_top)&($vL_yb=$vL_y_bottom))
				$vL_yt:=$vL_y_top
				$vL_yb:=$vL_yt+$vL_h
				$xl:=$xl+$vL_w_last
			End if 
			OBJECT SET COORDINATES:C1248(*; $vT_widget; $xl; $vL_yt; $xl+$vL_w; $vL_yb)
			$vJ_widget.resize()
			$vJ_widget.redraw()
			If ($vL_yb>=$vL_y_bottom)  //| (($vL_yt=$vL_y_top)&($vL_yb=$vL_y_bottom))
				//If ($vL_w_last>0)
				$vL_y_bottom:=$vL_yb
				$vL_yt:=$vL_y_top
				$xl:=$xl+$vL_w+$vL_widgets_margin
				$vL_w_last:=0
			Else 
				$vL_w_last:=$vL_w
				$vL_yt:=$vL_yt+$vL_h
			End if 
		End for each 
		//$vL_y_area:=$h+$widgets_margin
		$vL_y_area:=wox_max($vL_y_area; $vL_yb)
		$vL_y_area:=$vL_y_area+$vL_widgets_margin
		$vC_at_widgets:=New collection:C1472()
	Else 
		$vL_y_area:=0
	End if 
	
	If (Not:C34($is_toolsOnTop & ($is_palettes & $is_palettesOnTop)))
		$vT_layout:="basic"
		$vC_at_widgets.push($vT_wos_zoom)
		If ($is_palettes)
			$vC_at_widgets.push($vT_wos_rotate; $vT_wos_font; $vT_wos_stroke; $vT_wos_fill)
		End if 
	End if 
	$vL_yt:=$vL_y_top
	For each ($vT_widget; $vC_at_widgets)
		$vJ_widget:=wos_getWidget($vT_widget)
		$vJ_widget.getSize($vT_layout; ->$vL_w; ->$vL_h)
		OBJECT SET COORDINATES:C1248(*; $vT_widget; $x1; $vL_yt; $x1+$vL_w; $vL_yt+$vL_h)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		$vL_yt:=$vL_yt+$vL_h+$vL_widgets_margin
	End for each 
	
	// Area position
	$vL_view_height:=$vL_height-$vL_y_area
	OBJECT SET COORDINATES:C1248(*; "bkg"; 0; $vL_y_area; $vL_view_width; $vL_y_area+$vL_view_height)
	
	$vJ_paper:=Form:C1466.j_paper
	$vL_paper_width:=$vJ_paper.l_width
	$vL_paper_height:=$vJ_paper.l_height
	$x:=wox_max(0; ($vL_view_width-$vL_paper_width)/2)
	$y:=wox_max(0; ($vL_view_height-$vL_paper_height)/2)+$vL_y_area
	$vL_canvas_width:=wox_min($vL_view_width; $vL_paper_width)
	$vL_canvas_height:=wox_min($vL_view_height; $vL_paper_height)
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	OBJECT SET COORDINATES:C1248($vP_canvas->; $x; $y; $x+$vL_canvas_width; $y+$vL_canvas_height)
	svgE_OBJECT_reserved_update($vL_canvas_width; $vL_canvas_height)
	svgE_EDIT_widgets_enabler()
	svgE_FORM_Size_validate()
	//OBJECT GET COORDINATES(*; "wos_text"; $vL_left; $vL_top; $vL_right; $vL_bottom)
	
	
Function _redraw()
	var $vP_canvas : Pointer
	var $is_editing : Boolean
	var $vC_at_key : Collection
	var $idx : Integer
	var $vJ_widget : Object
	var $vT_key; $vT_widget : Text
	$is_editing:=This:C1470.is_editing
	$vC_at_key:=New collection:C1472()
	$vC_at_key.push("tools"; "actions"; "edits")
	$idx:=0
	For each ($vT_key; $vC_at_key)
		$vT_widget:="wos_"+$vT_key
		$vJ_widget:=wos_getWidget($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		If ($idx=0)
			$vJ_widget.is_sticky:=This:C1470.is_sticky
		End if 
		$vJ_widget.redraw()
		$idx+=1
	End for each 
	
	//Form.svgOptionsSaved:=SVG_Get_options
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	$vP_canvas->:=SVG_Export_to_picture(This:C1470.t_domRef)
	
	
Function _on_timer()
	var $vX_currentSelection : Blob
	var $is_cursorOut; $isOk; $is_history : Boolean
	var $vL_clickX; $vL_clickY; $vL_oldX; $vL_oldY; $vL_historyIndex; $x; $y; $vL_b; $tt; $vL_size_1; $vL_size_2; $i : Integer
	var $vJ_canvas; $vJ_polyline; $vJ_history : Object
	var $vP_aT_currentObjects; $vP_T_historySelection : Pointer
	var $vT_currentObject; $vT_tool; $vT_currentObject_old : Text
	svgE_getStuff_vJ(->$vJ_canvas; ->$vJ_polyline; ->$vJ_history)
	$vL_clickX:=$vJ_canvas.l_clickX
	$vL_clickY:=$vJ_canvas.l_clickY
	$vL_oldX:=$vJ_canvas.l_oldX
	$vL_oldY:=$vJ_canvas.l_oldY
	$vT_currentObject:=$vJ_canvas.t_currentObject
	$vL_historyIndex:=$vJ_history.l_index
	$vT_tool:=$vJ_canvas.t_tool
	$is_cursorOut:=$vJ_canvas.is_cursorOut
	$vT_currentObject_old:=$vJ_canvas.t_currentObject_old
	
	$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
	$vP_T_historySelection:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_historySelection")
	
	GET MOUSE:C468($x; $y; $vL_b)
	If ($vL_b=0)  //button release event
		
		If ($vT_tool="SELECT")
			$isOk:=svgE_SELECT_OBJ_by_coordinates
			$isOk:=$isOk | svgE_OBJECT_Resize_validate
			$isOk:=$isOk | svgE_OBJECT_Transform_validate
			$tt:=Size of array:C274($vP_aT_currentObjects->)
			svgE_EDIT_ACTIONS_enabler
			svgE_EDIT_widgets_enabler
			
			If ($vL_historyIndex>=0)
				If ($vL_historyIndex<=Size of array:C274($vP_T_historySelection->))
					
					//recover previous selection
					PICTURE TO BLOB:C692($vP_T_historySelection->{$vL_historyIndex}; $vX_currentSelection; "private.4d.array.blob")
					ARRAY TEXT:C222($aT_temp; 0)
					BLOB TO VARIABLE:C533($vX_currentSelection; $aT_temp)
					$vL_size_1:=Size of array:C274($vP_aT_currentObjects->)
					$vL_size_2:=Size of array:C274($aT_temp)
					
					Case of 
						: ($vL_size_1#$vL_size_2)
							//the size of selection has changed
							$is_history:=True:C214
							
						Else 
							//the size of selection has not changed
							Case of 
								: ($vT_currentObject=$vT_currentObject_old)
									//same object is still current
									Case of 
										: ($vL_oldX#$vL_clickX)
											//current object has been moved
											$is_history:=True:C214
										: ($vL_oldY#$vL_clickY)
											//current object has been moved
											$is_history:=True:C214
										Else 
											$is_history:=False:C215
									End case 
									
								Else 
									//a different object is current
									SORT ARRAY:C229($vP_aT_currentObjects->)
									SORT ARRAY:C229($aT_temp)
									
									For ($i; 1; $vL_size_1)
										If ($vP_aT_currentObjects->{$i}#$aT_temp{$i})
											//a different object has been selected to change the current object
											$is_history:=True:C214
											$i:=$vL_size_1
										End if 
									End for 
									
							End case 
							
					End case 
					
				End if 
			End if 
			
		Else 
			If ($vT_currentObject#"")
				$isOk:=($vL_clickX#MouseX) | ($vL_clickY#MouseY)
				//If (Not($isOk))
				//$isOk:=(OB Is defined($ob_canvas;"picture"))  // Is there a Picture to drop?
				//If (Not($isOk))
				//  // => , delete selection rect
				//DOM REMOVE XML ELEMENT($currentObject)
				//ARRAY TEXT($ptr_T_currentObjects->;0)
				//$currentObject:=""
				//$ob_canvas.t_currentObject:=$currentObject
				//$isOk:=True
				//$is_history:=False
				//OB REMOVE($ob_canvas;"picture")
				
				//$tool:="SELECT"
				//x_maj_wos_tools($vT_tool; $vJ_canvas)
				//svgE_EDIT_widgets_enabler ($tool)
				//End if
				//End if
				
				If ($isOk)
					If ($vT_tool="@STICKY")
						//$isOk:=$isOk | svgE_EDIT_picture
						$isOk:=$isOk | svgE_OBJECT_polyine_validate
						$isOk:=$isOk | svgE_SELECT_OBJ_none
						$is_history:=True:C214
						
					Else 
						Case of 
								//: ($tool="IMG")
								//$isOk:=svgE_EDIT_picture
								// NOW MANAGED DIRECTLY IN "svgE_OBJECT_New_on_click"
								
							: ($vT_tool="TEXT")
								$isOk:=svgE_EDIT_Text
						End case 
						
						//$isOk:=$isOk | OBJECT_img_validate
						$isOk:=$isOk | svgE_OBJECT_polyine_validate
						$isOk:=$isOk | svgE_SELECT_OBJ_by_reference($vT_currentObject)
						$isOk:=$isOk | svgE_SELECT_Display_handles($vT_currentObject)
						
						$vT_tool:="SELECT"
						x_maj_wos_tools($vT_tool; $vJ_canvas)
						$is_history:=$isOk
						
					End if 
					//$historyShouldUpdate:=$is_canvas_shouldUpdate
				Else 
					// => , delete selection rect
					DOM REMOVE XML ELEMENT:C869($vT_currentObject)
					ARRAY TEXT:C222($vP_aT_currentObjects->; 0)
					$vJ_canvas.t_currentObject:=""
					$isOk:=True:C214
					$is_history:=False:C215
					
					$vT_tool:="SELECT"
					x_maj_wos_tools($vT_tool; $vJ_canvas)
					svgE_EDIT_widgets_enabler($vT_tool)
				End if 
			End if 
		End if 
		SET TIMER:C645(0)
		
	Else 
		//button is down; keep timer running
		If ($is_cursorOut)  //On Mouse Move
			svgE_MOUSE_Force_update
			$isOk:=svgE_SELECT_OBJ_for_mouseMove
		End if 
	End if 
	
	If ($isOk)
		svgE_EDIT_widgets_enabler  //($vT_tool)
		svgE_EDIT_shortcuts_update
		svgE_EDIT_ACTIONS_enabler
		svgE_FORM_canvas_redraw
		svgE_CURSOR_Update
	End if 
	
	If ($is_history)
		svgE_HISTORY_Append
	End if 
	
	
Function _get_widget_size($vP_vL_width : Pointer; $vP_vL_height : Pointer)
	var $is_toolsOnTop; $is_palettes; $is_palettesOnTop : Boolean
	var $vC_at_widgets : Collection
	var $vL_paper_width; $vL_paper_height; $vL_widgets_margin; $y; $xl; $x; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_w; $vL_h; $vL_width; $vL_height : Integer
	var $vJ_paper : Object
	var $vT_widget : Text
	$is_toolsOnTop:=This:C1470.is_toolsOnTop
	$is_palettes:=This:C1470.is_palettes
	$is_palettesOnTop:=This:C1470.is_palettesOnTop
	
	
	$vJ_paper:=This:C1470.j_paper
	$vL_paper_width:=$vJ_paper.l_width
	$vL_paper_height:=$vJ_paper.l_height
	$vL_widgets_margin:=wos__storage_prefs_ui().widgets_margin
	
	$vC_at_widgets:=New collection:C1472()
	$vC_at_widgets.push("wos_edits"; "wos_actions"; "wos_tools"; "wos_zoom")
	If ($is_toolsOnTop)
		$y:=0
		$xl:=0
		$x:=-$vL_widgets_margin
		For each ($vT_widget; $vC_at_widgets)
			OBJECT GET COORDINATES:C663(*; $vT_widget; $vL_left; $vL_top; $vL_right; $vL_bottom)
			$vL_w:=$vL_right-$vL_left
			$vL_h:=$vL_bottom-$vL_top
			$x:=$x+$vL_w+$vL_widgets_margin
			$y:=wox_max($y; $vL_bottom)
		End for each 
		$y:=$y+$vL_widgets_margin
		$vL_paper_height:=$vL_paper_height+$y
		$vC_at_widgets:=New collection:C1472()
	Else 
		$y:=0
		//$vL_paper_height:=$vL_paper_height+$widgets_margin
	End if 
	
	If ($is_palettes)
		$vC_at_widgets.push("wos_rotate"; "wos_fill"; "wos_stroke"; "wos_text")
		//OBJECT GET COORDINATES(*;$T_widgets{1};$vL_left;$vL_top;$vL_right;$vL_bottom)
		//$vL_w:=$vL_right-$vL_left
		
		$vL_paper_width:=$vL_paper_width+$vL_widgets_margin+265
		For each ($vT_widget; $vC_at_widgets)
			OBJECT GET COORDINATES:C663(*; $vT_widget; $vL_left; $vL_top; $vL_right; $vL_bottom)
			$vL_w:=$vL_right-$vL_left
			$vL_h:=$vL_bottom-$vL_top
			If ($is_palettesOnTop)
				$x:=wox_max($x; $vL_right)
			Else 
				$y:=wox_max($y; $vL_bottom)
			End if 
		End for each 
		
		If ($is_palettesOnTop)
			$x:=$x+$vL_widgets_margin
		Else 
			$y:=$y+$vL_widgets_margin
		End if 
	End if 
	
	$vL_width:=wox_max($vL_paper_width; $x)
	$vL_height:=wox_max($vL_paper_height; $y)
	$vP_vL_width->:=$vL_width
	$vP_vL_height->:=$vL_height
	
	