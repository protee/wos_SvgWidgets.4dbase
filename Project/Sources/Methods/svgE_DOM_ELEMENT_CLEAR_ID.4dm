//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Project method : DOM_ELEMENT_CLEAR_ID
// Database: 4D Labels
// ID[19376BF3C8E54830AD403BF30A69D26B]
// Created #25-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

var $1 : Text

var $vT_dom_node : Text
$vT_dom_node:=$1

ARRAY LONGINT:C221($aL_types; 0)
ARRAY TEXT:C222($aT_dom_childs; 0)
// ----------------------------------------------------
var $vT_id_txt : Text
xml_GET_ATTRIBUTE_BY_NAME($vT_dom_node; "id"; ->$vT_id_txt)

If (Length:C16($vT_id_txt)>0)
	DOM SET XML ATTRIBUTE:C866($vT_dom_node; "temp-id"; $vT_id_txt)  //keep id
	DOM REMOVE XML ATTRIBUTE:C1084($vT_dom_node; "id")
End if 

//also for child elements
var $x : Integer
DOM GET XML CHILD NODES:C1081($vT_dom_node; $aL_types; $aT_dom_childs)
Repeat 
	$x:=Find in array:C230($aL_types; XML ELEMENT:K45:20; $x+1)
	If ($x>0)
		svgE_DOM_ELEMENT_CLEAR_ID($aT_dom_childs{$x})  //----------- RECURSIVE
	End if 
Until ($x=-1)






