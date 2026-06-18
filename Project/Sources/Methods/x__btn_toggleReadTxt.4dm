//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 05/04/16, 15:45:54
// ----------------------------------------------------
// Méthode : ogX_btn_toogleRead
// Description
// 
//
// Paramètres
// $1 <PTR> : sur bouton image
// $0 <INT> : valeur du toogle
// ----------------------------------------------------

var $vP_button : Pointer
$vP_button:=$1
var $vT_value_txt : Text

var $vT_btnFormat : Text
If ($vP_button=Null:C1517)
	//TOOL_TraceIfNotCompiled 
	//TRACE
	$vT_value_txt:=""
Else 
	$vT_btnFormat:=OBJECT Get format:C894($vP_button->)
	var $k1; $k2 : Integer
	$k1:=Position:C15("_"; $vT_btnFormat)
	$k2:=Position:C15("."; $vT_btnFormat)
	If ($k1>0) & ($k2>0)
		$vT_value_txt:=Substring:C12($vT_btnFormat; $k1+1; $k2-$k1-1)
	End if 
End if 
$0:=$vT_value_txt

