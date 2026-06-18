//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Project method : DEBUG_EXPORT_CANVAS
// Database: 4D Labels
// ID[0C31D8C5974648448A56DC18ED0A9D13]
// Created #21-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

var $vL_count_parameters : Integer
var $vT_path_export; $vT_dom_hdl; $vT_file_name; $vT_groutine : Text


// ----------------------------------------------------
// Initialisations
$vT_groutine:=$1
$vT_dom_hdl:=$2

$vL_count_parameters:=Count parameters:C259
If ($vL_count_parameters>=3)
	$vT_file_name:=$3
End if 

$vT_path_export:=System folder:C487(Desktop:K41:16)+"genieWidgets_DEV"+Folder separator:K24:12
CREATE FOLDER:C475($vT_path_export; *)

Case of 
		
	: (Is compiled mode:C492)
		//NOTHING MORE TO DO
		
	: (Test path name:C476($vT_path_export)#Is a folder:K24:2)
		//NOTHING MORE TO DO
		
	: ($vT_groutine="dom")
		If (Length:C16($vT_file_name)>0)
			DOM EXPORT TO FILE:C862($vT_dom_hdl; $vT_path_export+$vT_file_name)
		Else 
			DOM EXPORT TO FILE:C862($vT_dom_hdl; $vT_path_export+"dom.xml")
		End if 
		
	: ($vT_groutine="canvas")
		If (Length:C16($vT_file_name)>0)
			DOM EXPORT TO FILE:C862($vT_dom_hdl; $vT_path_export+$vT_file_name)
		Else 
			DOM EXPORT TO FILE:C862($vT_dom_hdl; $vT_path_export+"image.svg")
		End if 
		
	Else 
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$vT_groutine+"\"")
		
End case 





