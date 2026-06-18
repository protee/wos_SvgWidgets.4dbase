//%attributes = {"invisible":true,"lang":"en"}

If (False:C215)
	var $vT_domRef : Text
	$vT_domRef:=Form:C1466.t_domRef
	
	var $vP_canvas; $vP_T_currentObjects; $vP_lb_aO_svg_icons; $vP_lb_aT_svg_ids; $vP_LB_svg_objects : Pointer
	$vP_LB_svg_objects:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_svg_objects")
	$vP_lb_aO_svg_icons:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_svg_icons")
	$vP_lb_aT_svg_ids:=OBJECT Get pointer:C1124(Object named:K67:5; "lb_svg_ids")
	
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
	$vP_T_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
	
	
	var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
	var $vR_x; $vR_y; $vR_w; $vR_h; $vR_s; $vR_s : Real
	var $vR_scale : Real
	
	var $vT_id; $vT_textData : Text
	var $vO_objectImage : Picture
	var $vT_markerStartId; $vT_markerEndId; $vT_markerStart; $vT_markerEnd : Text
	
	If ($vP_lb_aO_svg_icons#Null:C1517)
		ARRAY PICTURE:C279($vP_lb_aO_svg_icons->; 0)
		ARRAY TEXT:C222($vP_lb_aT_svg_ids->; 0)
		LISTBOX SELECT ROW:C912($vP_LB_svg_objects->; 0; lk remove from selection:K53:3)
		
		var $vL_height : Integer
		var $vT_svgObject : Text
		$vL_height:=LISTBOX Get rows height:C836($vP_LB_svg_objects->)
		
		ARRAY LONGINT:C221($aL_pos; 0)
		ARRAY LONGINT:C221($aL_len; 0)
		
		var $vT_xml_null : Text
		$vT_xml_null:=wos__storage_stuff.t_xml_null
		
		$vT_svgObject:=DOM Get first child XML element:C723($vT_domRef)
		
		While (OK=1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_svgObject; "id"; $vT_id)
			If ($vT_id=$vT_svgObject)
				
				var $vT_defs; $vT_object; $vT_objectType; $vT_svg : Text
				$vT_objectType:=svgE_OBJECT_Get_transform($vT_svgObject; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h; ->$vR_s)
				
				$vT_svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
				$vT_defs:=DOM Create XML element:C865($vT_svg; "defs"; "id"; "4D")  //place holder
				
				Case of 
					: ($vT_objectType="line") | ($vT_objectType="polyline")
						DOM SET XML ATTRIBUTE:C866($vT_svg; "width"; Abs:C99($vR_w)+($vR_s*10); "height"; Abs:C99($vR_h)+($vR_s*10))
						$vT_object:=DOM Append XML element:C1082($vT_svg; $vT_svgObject)
						If ($vR_w<0)
							$vR_tx:=-($vR_w/2)+($vR_s*5)
						Else 
							$vR_tx:=($vR_w/2)+($vR_s*5)
						End if 
						If ($vR_h<0)
							$vR_ty:=-($vR_h/2)+($vR_s*5)
						Else 
							$vR_ty:=($vR_h/2)+($vR_s*5)
						End if 
						svgE_OBJECT_set_transform($vT_object; $vR_tx; $vR_ty; 1; 1; 0; 0; 0)
						
						SVG GET ATTRIBUTE:C1056($vP_canvas->; $vT_svgObject; "marker-start"; $vT_markerStartId)
						If ($vT_markerStartId#"inherit")
							If (Match regex:C1019("url\\(#(.+)\\)"; $vT_markerStartId; 1; $aL_pos; $aL_len))
								$vT_markerStartId:=Substring:C12($vT_markerStartId; $aL_pos{1}; $aL_len{1})
								$vT_markerStart:=DOM Find XML element by ID:C1010($vT_svgObject; $vT_markerStartId)
								If ($vT_markerStart#$vT_xml_null)
									$vT_markerStart:=DOM Append XML element:C1082($vT_defs; $vT_markerStart)
								End if 
							End if 
						End if 
						
						SVG GET ATTRIBUTE:C1056($vP_canvas->; $vT_svgObject; "marker-end"; $vT_markerEndId)
						If ($vT_markerEndId#"inherit")
							If (Match regex:C1019("url\\(#(.+)\\)"; $vT_markerEndId; 1; $aL_pos; $aL_len))
								$vT_markerEndId:=Substring:C12($vT_markerEndId; $aL_pos{1}; $aL_len{1})
								$vT_markerEnd:=DOM Find XML element by ID:C1010($vT_svgObject; $vT_markerEndId)
								If ($vT_markerEnd#$vT_xml_null)
									$vT_markerEnd:=DOM Append XML element:C1082($vT_defs; $vT_markerEnd)
								End if 
							End if 
						End if 
						
						SVG EXPORT TO PICTURE:C1017($vT_svg; $vO_objectImage)
						PICTURE PROPERTIES:C457($vO_objectImage; $vR_w; $vR_h)
						If ($vR_w>$vR_h)
							$vR_scale:=($vL_height)/($vR_w)
						Else 
							$vR_scale:=($vL_height)/($vR_h)
						End if 
						TRANSFORM PICTURE:C988($vO_objectImage; Scale:K61:2; $vR_scale; $vR_scale)
						APPEND TO ARRAY:C911($vP_lb_aO_svg_icons->; $vO_objectImage)
						APPEND TO ARRAY:C911($vP_lb_aT_svg_ids->; $vT_svgObject)
						
						If (Find in array:C230($vP_T_currentObjects->; $vT_svgObject)#-1)
							LISTBOX SELECT ROW:C912($vP_LB_svg_objects->; Size of array:C274($vP_lb_aO_svg_icons->); lk add to selection:K53:2)
						End if 
						
					: ($vT_objectType="textArea")
						SVG GET ATTRIBUTE:C1056($vP_canvas->; $vT_svgObject; "4D-text"; $vT_textData)
						DOM SET XML ATTRIBUTE:C866($vT_svg; "width"; $vL_height; "height"; $vL_height)
						$vT_object:=DOM Append XML element:C1082($vT_svg; $vT_svgObject)
						DOM SET XML ATTRIBUTE:C866($vT_object; "x"; 0; "y"; 0; "width"; $vL_height; "height"; $vL_height; "font-size"; 11)
						svgE_OBJECT_set_transform($vT_object; 0.5; 0.5; 1; 1; 0; 0; 0)
						
						SVG EXPORT TO PICTURE:C1017($vT_svg; $vO_objectImage)
						$vT_textData:=Replace string:C233($vT_textData; Char:C90(Carriage return:K15:38); ""; *)
						$vT_textData:=Replace string:C233($vT_textData; Char:C90(Line feed:K15:40); ""; *)
						$vT_textData:=Substring:C12($vT_textData; 1; 60)
						SVG SET ATTRIBUTE:C1055($vO_objectImage; $vT_svgObject; "4D-text"; $vT_textData)
						
						APPEND TO ARRAY:C911($vP_lb_aO_svg_icons->; $vO_objectImage)
						APPEND TO ARRAY:C911($vP_lb_aT_svg_ids->; $vT_svgObject)
						
						If (Find in array:C230($vP_T_currentObjects->; $vT_svgObject)#-1)
							LISTBOX SELECT ROW:C912($vP_LB_svg_objects->; Size of array:C274($vP_lb_aO_svg_icons->); lk add to selection:K53:2)
						End if 
						
					: ($vT_objectType="rect") | ($vT_objectType="image") | ($vT_objectType="ellipse") | ($vT_objectType="circle")
						DOM SET XML ATTRIBUTE:C866($vT_svg; "width"; $vR_w+($vR_s*2); "height"; $vR_h+($vR_s*2))
						$vT_object:=DOM Append XML element:C1082($vT_svg; $vT_svgObject)
						svgE_OBJECT_set_transform($vT_object; -$vR_x+$vR_s; -$vR_y+$vR_s; $vR_sx; $vR_sy; 0; 0; 0)
						SVG EXPORT TO PICTURE:C1017($vT_svg; $vO_objectImage)
						If ($vR_w>$vR_h)
							$vR_scale:=($vL_height)/($vR_w+($vR_s*2))
						Else 
							$vR_scale:=($vL_height)/($vR_h+($vR_s*2))
						End if 
						TRANSFORM PICTURE:C988($vO_objectImage; Scale:K61:2; $vR_scale; $vR_scale)
						APPEND TO ARRAY:C911($vP_lb_aO_svg_icons->; $vO_objectImage)
						APPEND TO ARRAY:C911($vP_lb_aT_svg_ids->; $vT_svgObject)
						If (Find in array:C230($vP_T_currentObjects->; $vT_svgObject)#-1)
							LISTBOX SELECT ROW:C912($vP_LB_svg_objects->; Size of array:C274($vP_lb_aO_svg_icons->); lk add to selection:K53:2)
						End if 
						
				End case 
				DOM CLOSE XML:C722($vT_svg)
			End if 
			$vT_svgObject:=DOM Get next sibling XML element:C724($vT_svgObject)
		End while 
	End if 
End if 

