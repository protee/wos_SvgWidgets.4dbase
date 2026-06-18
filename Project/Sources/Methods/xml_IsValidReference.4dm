//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Project method : xml_IsValidReference
// ID[0A18547EC8AD4F96B4C9EC4933FAA1A3]
// Created #30-6-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
//If (False)
//var xml_IsValidReference; $0 : Boolean
//var xml_IsValidReference; $1 : Text
//End if 

var $is_valid : Boolean
var $vL_count_parameters : Integer
var $vT_reference : Text


// ----------------------------------------------------
// Initialisations
$vL_count_parameters:=Count parameters:C259
If (Asserted:C1132($vL_count_parameters>=1; "Missing parameter"))
	$vT_reference:=$1
Else 
	ABORT:C156
End if 

$is_valid:=Match regex:C1019("(?mi-s)^(?!^0*$)(?:[0-9A-F]{16}){1,2}$"; $vT_reference; 1)
$0:=$is_valid






