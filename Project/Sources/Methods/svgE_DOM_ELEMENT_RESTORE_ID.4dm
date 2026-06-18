//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Project method : DOM_ELEMENT_RESTORE_ID
// Database: 4D Labels
// ID[BFD1ECD6E9F849C1A75ADA588CA63BD6]
// Created #25-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text

var $vT_dom_node : Text
$vT_dom_node:=$1

var $vT_id_txt : Text
xml_GET_ATTRIBUTE_BY_NAME($vT_dom_node; "temp-id"; ->$vT_id_txt)

ARRAY LONGINT:C221($aL__types; 0)
ARRAY TEXT:C222($aT_childs; 0)
If (Length:C16($vT_id_txt)>0)
	DOM REMOVE XML ATTRIBUTE:C1084($vT_dom_node; "temp-id")
	DOM SET XML ATTRIBUTE:C866($vT_dom_node; "id"; $vT_id_txt)
End if 

//also for child elements
var $x : Integer
DOM GET XML CHILD NODES:C1081($vT_dom_node; $aL__types; $aT_childs)
Repeat 
	$x:=Find in array:C230($aL__types; XML ELEMENT:K45:20; $x+1)
	If ($x>0)
		svgE_DOM_ELEMENT_RESTORE_ID($aT_childs{$x})  //----------- RECURSIVE
	End if 
Until ($x=-1)





