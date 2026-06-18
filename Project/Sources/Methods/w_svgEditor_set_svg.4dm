//%attributes = {"invisible":true,"lang":"en"}
// Project Method: _svgEditor_set_svg
//
// Parameter Type Description
//
//
// Description:
// $1 <T> -> Set the svg file in text
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.


#DECLARE($vT_svg : Text)
var $vT_dom_svg; $vT_viewBox; $vT_domRef; $vT_currentObject_old; $vT_objectType; $vT_currentObject; $vT_attributeName; $vT_attributeValue; $vT_nodeName; $vT_append; $vT_tbreak : Text
var $isOk; $is_history : Boolean
var $vC_co_viewbox : Collection
var $vL_area_width; $vL_area_height; $x1; $y1; $x2; $y2; $tt; $i; $vL_countAttributes; $ttx; $tty; $j; $vL_lenght; $tt_nodes; $vL_nodes; $vL_nodeType : Integer
var $vJ_canvas : Object
var $vP_canvas : Pointer
var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy; $vR_x; $vR_y; $vR_w; $vR_h : Real

$isOk:=False:C215
$is_history:=False:C215


If ($vT_svg="")
	// TO DO EMPTY DOM $ptr_canvas_data
	svgE_AREA_Init()
	svgE_OBJECT_reserved_update()
	
Else 
	
	//need to create an instance of the picture to find objects by id
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "Canvas")
	$vT_dom_svg:=DOM Parse XML variable:C720($vT_svg)
	
	//SVG EXPORT TO PICTURE($vT_dom_svg;$vP_canvas->)
	//PICTURE PROPERTIES($picture;$area_width;$area_height)
	ON ERR CALL:C155("h_onError")
	$vL_area_width:=0
	DOM GET XML ATTRIBUTE BY NAME:C728($vT_dom_svg; "width"; $vL_area_width)
	DOM GET XML ATTRIBUTE BY NAME:C728($vT_dom_svg; "height"; $vL_area_height)
	ON ERR CALL:C155("")
	If ($vL_area_width=0)
		DOM GET XML ATTRIBUTE BY NAME:C728($vT_dom_svg; "viewBox"; $vT_viewBox)
		$vC_co_viewbox:=Split string:C1554($vT_viewBox; " "; sk trim spaces:K86:2)
		If ($vC_co_viewbox.length=4)
			$x1:=Num:C11($vC_co_viewbox[0]; ".")
			$y1:=Num:C11($vC_co_viewbox[1]; ".")
			$x2:=Num:C11($vC_co_viewbox[2]; ".")
			$y2:=Num:C11($vC_co_viewbox[3]; ".")
			$vL_area_width:=$x2-$x1
			$vL_area_height:=$y2-$y1
		End if 
	End if 
	
	svgE_AREA_Init()
	svgE_OBJECT_reserved_update()
	$isOk:=True:C214
	
	$vT_domRef:=Form:C1466.t_domRef
	svgE_getStuff_vJ(->$vJ_canvas)
	
	
	
	//copy objects to area one by one
	
	ARRAY TEXT:C222($aT_item_refs; 0)
	ARRAY TEXT:C222($aT_item_names; 0)
	ARRAY TEXT:C222($aT_item_ids; 0)
	SVG_ELEMENTS_TO_ARRAYS($vT_dom_svg; ->$aT_item_refs; ->$aT_item_names; ->$aT_item_ids)
	$tt:=Size of array:C274($aT_item_ids)
	$isOk:=($tt>0)
	
	//ARRAY TEXT($T_item_ids;0)
	//$isOk:=SVG Find element IDs by rect($vT_dom_svg;0;0;$area_width;$area_height;$T_item_ids)
	//$tt:=Size of array($T_item_ids)
	
	
	If ($isOk)
		For ($i; 1; $tt)
			//$object_id_old:=$T_item_ids{$i}
			//$object:=DOM Find XML element by ID($vT_dom_svg;$object_id_old)
			$vT_currentObject_old:=$aT_item_refs{$i}
			$vT_objectType:=svgE_OBJECT_Get_transform($vT_currentObject_old; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
			If ($vT_objectType="textArea") | ($vT_objectType="circle") | ($vT_objectType="ellipse") | ($vT_objectType="rect") | ($vT_objectType="line") | ($vT_objectType="polyline") | ($vT_objectType="image")
				$vT_currentObject:=DOM Create XML element:C865($vT_domRef; $vT_objectType)
				$vL_countAttributes:=DOM Count XML attributes:C727($vT_currentObject_old)
				//ARRAY TEXT($attributeNames;$vL_countAttributes)
				//ARRAY TEXT($attributeValues;$vL_countAttributes)
				$ttx:=0
				$tty:=0
				For ($j; 1; $vL_countAttributes)
					DOM GET XML ATTRIBUTE BY INDEX:C729($vT_currentObject_old; $j; $vT_attributeName; $vT_attributeValue)
					Case of 
						: ($vT_attributeName="transform")  //use dedicated method for this attribute
						: ($vT_attributeName="id")  //will set this later
						: ($vT_attributeName="points")  // Polyline points
							svgE_OBJECT_POLY_relativize(->$vT_attributeValue; ->$ttx; ->$tty; $vR_sx; $vR_sy; $vR_r)
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_attributeValue)
							$vR_cx:=0
							$vR_cy:=0
						: ($vT_attributeName="font-family")  // Remove unexpected ''
							$vL_lenght:=Length:C16($vT_attributeValue)
							If ($vT_attributeValue="'@'")
								$vT_attributeValue:=Substring:C12($vT_attributeValue; 2; $vL_lenght-2)
							End if 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_attributeValue)
							
						Else 
							DOM SET XML ATTRIBUTE:C866($vT_currentObject; $vT_attributeName; $vT_attributeValue)
					End case 
				End for 
				svgE_OBJECT_set_transform($vT_currentObject; $vR_tx-$ttx; $vR_ty-$tty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy)
				DOM SET XML ATTRIBUTE:C866($vT_currentObject; "id"; $vT_currentObject)
				
				//APPEND TO ARRAY($CanvasCurrentObjects->;$CanvasCurrentObject->)
				Case of 
					: ($vT_objectType="textArea")
						ARRAY LONGINT:C221($aL_nodeType; 0)
						ARRAY TEXT:C222($aT_nodeData; 0)
						DOM GET XML CHILD NODES:C1081($vT_currentObject_old; $aL_nodeType; $aT_nodeData)
						
						$vT_nodeName:=""
						$j:=0
						$tt_nodes:=Size of array:C274($aL_nodeType)
						For ($vL_nodes; 1; $tt_nodes)
							$vL_nodeType:=$aL_nodeType{$vL_nodes}
							Case of 
								: ($vL_nodeType=XML DATA:K45:12)
									If ($j=0)
										DOM SET XML ELEMENT VALUE:C868($vT_currentObject; $aT_nodeData{$vL_nodes})
										$j:=1
									Else 
										$vT_append:=DOM Append XML child node:C1080($vT_currentObject; XML DATA:K45:12; $aT_nodeData{$vL_nodes})
									End if 
									
								: ($vL_nodeType=XML ELEMENT:K45:20)
									DOM GET XML ELEMENT NAME:C730($aT_nodeData{$vL_nodes}; $vT_nodeName)
									If ($vT_nodeName="tbreak")
										$vT_tbreak:=DOM Create XML element:C865($vT_currentObject; "tbreak")
									End if 
							End case 
						End for 
						
						
					: ($vT_objectType="line") | ($vT_objectType="polyline")
						svgE_OBJECT_set_marker($vT_currentObject)  // $vT_currentObject
						
						//: ($objectType="circle")
						//: ($objectType="ellipse")
						//: ($objectType="rect")
						//: ($objectType="image")
				End case 
				
			End if 
		End for 
		DOM CLOSE XML:C722($vT_dom_svg)
	End if 
End if 

svgE_FORM_canvas_redraw()
svgE_HISTORY_Append()
GOTO OBJECT:C206(*; "Canvas")

