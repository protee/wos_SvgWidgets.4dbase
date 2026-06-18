//%attributes = {"shared":true,"lang":"en"}
// Project Method: wos_svgEdit_paper_calculate
//
// Parameter Type Description
//  $1  <OBJ> svgEditor object
//  $2  <LON> Paper width
//  $3  <LON> Paper height
// {$4} <REA> Margin factor: proportion of margin % Paper. -1 => no changes
// {$5} <REA> Header factor: proportion of header % Paper. Default 1.
// 
// Description:
// Will calculate all values for paper, margin, area, reserved, based on the given values.
// This is a easy setup for the trivial situations.
//
// Date        Init  Description
// ===================================================================
// 01/02/2021   OG   Initial version.


#DECLARE($vJ_wos_editor : Object; $vL_paper_width : Integer; $vL_paper_height : Integer; $vR_margin_factor : Real; $vR_header_percent : Real)  // {#4} optionnals
//var $4; $5 : Real
var $vL_margin; $vL_margin_left; $vL_margin_top; $vL_margin_right; $vL_margin_bottom; $vL_area_width; $vL_area_height : Integer
var $vJ_paper; $vJ_margin : Object
If (Count parameters:C259<4)
	$vR_margin_factor:=-1
End if 
If (Count parameters:C259<5)
	$vR_header_percent:=1
End if 

//var $vR_footer_percent; $6 : Real  // Percent of footer
//If (Count parameters>=6)
//$vR_footer_percent:=$6
//Else 
//$vR_footer_percent:=0
//End if 


$vJ_paper:=$vJ_wos_editor.j_paper
Use ($vJ_paper)
	$vJ_paper.l_width:=$vL_paper_width
	$vJ_paper.l_height:=$vL_paper_height
End use 

// Margins ?
If ($vR_margin_factor>=0)
	$vL_margin:=$vL_paper_width*$vR_margin_factor
	$vJ_margin:=$vJ_wos_editor.j_margin
	Use ($vJ_margin)
		$vJ_margin.l_left:=$vL_margin
		$vJ_margin.l_top:=$vL_margin
		$vJ_margin.l_right:=$vL_margin
		$vJ_margin.l_bottom:=$vL_margin
	End use 
End if 
$vL_margin_left:=$vJ_margin.l_left
$vL_margin_top:=$vJ_margin.l_top
$vL_margin_right:=$vJ_margin.l_right
$vL_margin_bottom:=$vJ_margin.l_bottom

$vL_area_width:=$vL_paper_width-($vL_margin_left+$vL_margin_right)
$vL_area_height:=$vL_paper_height-($vL_margin_top+$vL_margin_bottom)

