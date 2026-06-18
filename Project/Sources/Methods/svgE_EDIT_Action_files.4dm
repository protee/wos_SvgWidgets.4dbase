//%attributes = {"invisible":true,"lang":"en"}


var $vT_action; $vT_answer; $vT_svg; $vT_domRef; $vT_dom; $vT_object : Text
var $tt; $i; $l : Integer
var $vP_canvas; $vP__T_currentObjects : Pointer
$vT_action:=$1

Case of 
		//: ($action="new")
		//svgE_AREA_Init
		//svgE_OBJECT_reserved_update
		
		//svgE_FORM_canvas_redraw
		//svgE_HISTORY_Append
		
		
	: ($vT_action="load")
		$vT_answer:=Select document:C905(1; x_svg_fileTypes; "Choose an svg file to load"; Use sheet window:K24:11)
		If (OK=1)
			$vT_svg:=Document to text:C1236(Document)
			w_svgEditor_set_svg($vT_svg)
		End if 
		
	: ($vT_action="save")
		$vT_answer:=Select document:C905(1; x_svg_fileTypes; "Save the svg file"; File name entry:K24:17+Use sheet window:K24:11)
		If (OK=1)
			$vT_svg:=w_svgEditor_get_svg
			TEXT TO DOCUMENT:C1237(Document; $vT_svg)
		End if 
		//ON ERR CALL("")
		
		//: ($vT_action="ReleaseNotes")
		//wos__releaseNotes_form(Not(Is compiled mode))
		
	: ($vT_action="rawDom")
		$vT_domRef:=Form:C1466.t_domRef
		svgE_DEBUG_EXPORT("dom"; $vT_domRef)
		
	: ($vT_action="rawCanvas")
		$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
		$vT_dom:=SVG_Open_picture($vP_canvas->)
		svgE_DEBUG_EXPORT("canvas"; $vT_dom)
		
	: ($vT_action="rawTest")
		ARRAY TEXT:C222($aT_item_refs; 0)
		ARRAY TEXT:C222($aT_item_names; 0)
		ARRAY TEXT:C222($aT_item_ids; 0)
		$tt:=svgE_EDIT_get_objects(->$aT_item_refs; ->$aT_item_names; ->$aT_item_ids)
		
		//$ptr_T_currentObjects:=OBJECT Get pointer(Object named;"T_currentObjects")
		//$tt:=Size of array($ptr_T_currentObjects->)
		$tt:=svgE_EDIT_SEL_Get_count(->$vP__T_currentObjects)
		For ($i; 1; $tt)
			$vT_object:=$vP__T_currentObjects->{$i}
			$l:=svgE_EDIT_OB_Get_level($vT_object; ->$aT_item_ids)
		End for 
		
		
	Else 
		ALERT:C41($vT_action)
		
End case 

