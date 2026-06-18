//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 05/04/16, 15:48:59
// ----------------------------------------------------
// Méthode : ogX_btn_toogleSet
// Description
// 
//
// Paramètres
// $1 <PTR> : sur bouton image
// $2 <TXT> : valeur du toogle entre "_" et "."
// ----------------------------------------------------

var $vP_button : Pointer
var $vT_value : Text
$vP_button:=$1
$vT_value:=$2

var $vT_btnFormat : Text
var $k1; $k2 : Integer
$vT_btnFormat:=OBJECT Get format:C894($vP_button->)
$k1:=Position:C15("_"; $vT_btnFormat)
$k2:=Position:C15("."; $vT_btnFormat)
If ($k1>0) & ($k2>0)
	
	OBJECT SET FORMAT:C236($vP_button->; Substring:C12($vT_btnFormat; 1; $k1)+$vT_value+Substring:C12($vT_btnFormat; $k2))
	
End if 




