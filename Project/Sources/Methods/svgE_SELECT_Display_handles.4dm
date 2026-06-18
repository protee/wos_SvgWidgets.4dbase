//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vT_currentObject : Text
$vT_currentObject:=$1

var $vT_domRef : Text
$vT_domRef:=Form:C1466.t_domRef

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
//$currentObject:=$ob_canvas.t_currentObject

var $vJ_ui : Object
$vJ_ui:=wos__storage_prefs_ui
var $vR_handle_fill_opacity; $vR_handle_stroke_opacity; $vR_handle_stroke_width : Real
var $vT_handle_fill; $vT_handle_stroke : Text
$vT_handle_fill:=$vJ_ui.handle_fill
$vT_handle_stroke:=$vJ_ui.handle_stroke
$vR_handle_stroke_width:=$vJ_ui.handle_stroke_width
$vR_handle_fill_opacity:=$vJ_ui.handle_fill_opacity
$vR_handle_stroke_opacity:=$vJ_ui.handle_stroke_opacity


var $vL_handle_radius; $vL_handles_diameter : Integer
$vL_handle_radius:=$vJ_ui.handle_radius
$vL_handles_diameter:=$vL_handle_radius*2

var $isOk : Boolean
$isOk:=False:C215

If (Length:C16($vT_currentObject)#0)
	
	var $vT_xml_null : Text
	$vT_xml_null:=wos__storage_stuff.t_xml_null
	
	var $vT_rect : Text
	$vT_rect:=DOM Find XML element by ID:C1010($vT_domRef; $vT_currentObject+".select")
	If ($vT_rect#$vT_xml_null)
		var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy : Real
		var $vR_x; $vR_y; $vR_w; $vR_h : Real
		svgE_OBJECT_Get_transform($vT_rect; ->$vR_tx; ->$vR_ty; ->$vR_sx; ->$vR_sy; ->$vR_r; ->$vR_cx; ->$vR_cy; ->$vR_x; ->$vR_y; ->$vR_w; ->$vR_h)
		$vR_cx:=$vR_x+($vR_w/2)
		$vR_cy:=$vR_y+($vR_h/2)
		
		$vR_x:=-(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=-(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))-(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		var $vT_CanvasCurrentSelectTL; $vT_CanvasCurrentSelectTM : Text
		$vT_CanvasCurrentSelectTL:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTL; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".tl")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectTL; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=-(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		$vT_CanvasCurrentSelectTM:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTM; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".tm")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectTM; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))-(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		var $vT_CanvasCurrentSelectBL; $vT_CanvasCurrentSelectTR : Text
		$vT_CanvasCurrentSelectTR:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTR; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".tr")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectTR; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=-(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))-(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=-(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		$vT_CanvasCurrentSelectBL:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBL; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".bl")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectBL; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=-(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		var $vT_CanvasCurrentSelectBM; $vT_CanvasCurrentSelectBR : Text
		$vT_CanvasCurrentSelectBM:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBM; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".bm")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectBM; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))-(($vR_h/2)*Cos:C18((90-$vR_r)*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+(($vR_h/2)*Sin:C17((90-$vR_r)*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		$vT_CanvasCurrentSelectBR:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBR; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".br")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectBR; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=-(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=-(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		var $vT_CanvasCurrentSelectML; $vT_CanvasCurrentSelectMR : Text
		$vT_CanvasCurrentSelectML:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectML; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".ml")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectML; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vR_x:=(($vR_w/2)*Cos:C18($vR_r*Degree:K30:2))+$vR_cx-$vL_handle_radius
		$vR_y:=(($vR_w/2)*Sin:C17($vR_r*Degree:K30:2))+$vR_cy-$vL_handle_radius
		$vR_x:=Num:C11(String:C10($vR_x))  //remove e
		$vR_y:=Num:C11(String:C10($vR_y))  //remove e
		$vT_CanvasCurrentSelectMR:=SVG_New_rect($vT_domRef; $vR_x; $vR_y; $vL_handles_diameter; $vL_handles_diameter; 0; 0; $vT_handle_stroke; $vT_handle_fill; $vR_handle_stroke_width)
		DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectMR; "fill-opacity"; $vR_handle_fill_opacity; "stroke-opacity"; $vR_handle_stroke_opacity; "id"; $vT_currentObject+".mr")
		svgE_OBJECT_set_transform($vT_CanvasCurrentSelectMR; $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_x+$vL_handle_radius; $vR_y+$vL_handle_radius)
		
		$vJ_canvas.currentHandleObject:=$vT_currentObject
		$vJ_canvas.currentHandle:=""
		
		var $vT_objectType : Text
		DOM GET XML ELEMENT NAME:C730($vT_currentObject; $vT_objectType)
		
		Case of 
			: ($vT_objectType="line")
				var $vR_x1; $vR_x2; $vR_y1; $vR_y2 : Real
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "x1"; $vR_x1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "x2"; $vR_x2)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "y1"; $vR_y1)
				DOM GET XML ATTRIBUTE BY NAME:C728($vT_currentObject; "y2"; $vR_y2)
				
				Case of 
					: ($vR_x2>0) & ($vR_y2>0)  // +,+ : x,y is top left
						
					: ($vR_x2>0) & ($vR_y2<0)  // +,- : x,y is bottom left
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTL; "id"; $vT_currentObject+".bl")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBL; "id"; $vT_currentObject+".tl")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTM; "id"; $vT_currentObject+".bm")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBM; "id"; $vT_currentObject+".tm")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTR; "id"; $vT_currentObject+".br")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBR; "id"; $vT_currentObject+".tr")
						
					: ($vR_x2<0) & ($vR_y2>0)  // -,+ : x,y is top right
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTL; "id"; $vT_currentObject+".tr")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTR; "id"; $vT_currentObject+".tl")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectML; "id"; $vT_currentObject+".mr")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectMR; "id"; $vT_currentObject+".ml")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBL; "id"; $vT_currentObject+".br")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBR; "id"; $vT_currentObject+".bl")
						
					: ($vR_x2<0) & ($vR_y2<0)  // -,- : x,y is bottom right
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTL; "id"; $vT_currentObject+".br")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTR; "id"; $vT_currentObject+".bl")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectTM; "id"; $vT_currentObject+".bm")
						
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBM; "id"; $vT_currentObject+".tm")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBL; "id"; $vT_currentObject+".tr")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectBR; "id"; $vT_currentObject+".tl")
						
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectML; "id"; $vT_currentObject+".mr")
						DOM SET XML ATTRIBUTE:C866($vT_CanvasCurrentSelectMR; "id"; $vT_currentObject+".ml")
				End case 
				
		End case 
		
		$isOk:=True:C214
		
	End if 
End if 

$0:=$isOk

