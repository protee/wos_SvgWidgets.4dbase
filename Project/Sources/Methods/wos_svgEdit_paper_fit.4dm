//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_svgEdit_paper_fit
//
// Parameter Type Description
//  $1  <REA> Paper_factor_WH: proportion width/height
//  $2  <PTR> Pointer to paper width
//  $3  <PTR> Pointer to paper height
// {$4} <TXT> Widget name, default current widget
//
// Description:
// Will calculate paper width and height, based on widget canvas size.
// Mode Min if paper_factor_WH >0 ; Max if paper_factor_WH <0
//
// Date        Init  Description
// ===================================================================
// 11/02/2021   OG   Initial version.


#DECLARE($vR_paper_factor_WH : Real; $vP_paper_width : Pointer; $vP_paper_height : Pointer; $vT_widgetName : Text)  // {#4} optionnals
//var $1 : Real
// Proportion of the paper W/H
var $is_byExcess : Boolean
var $vL_wos_width; $vL_wos_height; $vL_paper_width; $vL_paper_height : Integer
var $vJ_wos_editor : Object
var $vR_wos_factor_WH : Real
If ($vT_widgetName="")
	$vT_widgetName:=OBJECT Get name:C1087(Object current:K67:2)
End if 
$vJ_wos_editor:=wos_getWidget($vT_widgetName)

$is_byExcess:=($vR_paper_factor_WH<0)
If ($is_byExcess)
	$vR_paper_factor_WH:=-$vR_paper_factor_WH
End if 

// Calculate real paper width based on widget
//wos_svgEdit_get_canvasSize(->$vL_wos_width; ->$vL_wos_height; $vT_widgetName)
$vJ_wos_editor.get_canvas_wh(->$vL_wos_width; ->$vL_wos_height; $vT_widgetName)
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

