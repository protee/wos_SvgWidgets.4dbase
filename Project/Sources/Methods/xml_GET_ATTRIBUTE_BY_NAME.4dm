//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Project method : xml_GET_ATTRIBUTE_BY_NAME
// Database: 4D Labels
// ID[1DA6CCC62BC7451BA04319B54F3243AE]
// Created #3-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
var $2 : Text
var $3 : Pointer

var $vL_lon_i : Integer
var $vP__value : Pointer
var $vT_dom_ref; $vT_txt_; $vT_txt_attribute; $vT_txt_name : Text

$vT_dom_ref:=$1
$vT_txt_attribute:=$2
$vP__value:=$3

For ($vL_lon_i; 1; DOM Count XML attributes:C727($vT_dom_ref); 1)
	DOM GET XML ATTRIBUTE BY INDEX:C729($vT_dom_ref; $vL_lon_i; $vT_txt_name; $vT_txt_)
	If ($vT_txt_name=$vT_txt_attribute)
		DOM GET XML ATTRIBUTE BY NAME:C728($vT_dom_ref; $vT_txt_attribute; $vP__value->)
		$vL_lon_i:=MAXLONG:K35:2-1
	End if 
End for 

