//%attributes = {}
// *****
// *
// Method: x_Get_localized_string
// Olivier Grimbert — Protée sarl — 07/02/2026 14:18:56
//
// Description: 
//
// Date       | Who | Comment
// 07/02/2026 | OG  | Updated
// *
// *****

#DECLARE($vL_tag : Integer; $vT_tag : Text)->$vT_answer : Text
var $vT_tag1 : Text

If ($vL_tag<0)
	$vT_answer:=$vT_tag
Else 
	$vT_tag1:=wox_localize_tag($vL_tag; $vT_tag)
	$vT_answer:=Get localized string:C991($vT_tag1)
	$vT_answer:=$vT_answer#"" ? $vT_answer : "‼️"+$vT_tag
End if 

