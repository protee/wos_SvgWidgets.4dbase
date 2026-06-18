//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 15/04/16, 11:27:17
// ----------------------------------------------------
// Méthode : ogX_imgPopup_val
// Description
//
//
// Paramètres
// ----------------------------------------------------
// Entrée $1 : evenement formulaire
// $2 <PTR> : champ/var valeur num | possible sur nil !
// $3 <PTR> : bouton image
// ${4} <STR> : nom icons
// ${5} <COL> : Collection "label", "menu", "is_valid"
// ${6} <TXT> : text for idle item on last state

// $0 : vrai si Write

#DECLARE($vL_event_code : Integer; $vP_field : Pointer; $vP_btn : Pointer; $vT_subPath_icon : Text; $vC_menu : Collection; $vJ_app : Object)->$isOk : Boolean
var $isNilField; $isNilBtn; $isField; $isModif; $is_separator; $is_valid : Boolean
var $k; $idx : Integer
var $vJ_menu_item : Object
var $vT_value_menu; $vT_path_icon; $vT_refMenu; $vT_label; $vT_menu; $vT_answerMenu : Text
var $vT_prefix1 : Text
var $c4Fu_method : 4D:C1709.Function

$isOk:=False:C215
$isNilField:=Is nil pointer:C315($vP_field)
$isNilBtn:=Is nil pointer:C315($vP_btn)

Case of 
	: ($vL_event_code=On Load:K2:1)
		If ($isNilField)
			$vT_value_menu:=""
		Else 
			$vT_value_menu:=$vP_field->
		End if 
		If (Not:C34($isNilBtn))
			x__btn_toggleSetTxt($vP_btn; $vT_value_menu)
		End if 
		
		
	: ($vL_event_code=On Clicked:K2:4)
		$isField:=Not:C34(Is a variable:C294($vP_field))
		$isModif:=True:C214
		Case of 
			: ($isNilField)
				If (Not:C34($isNilBtn))
					$vT_value_menu:=x__btn_toggleReadTxt($vP_btn)
				Else 
					$vT_value_menu:=""
				End if 
				
			: ($isNilBtn)
				$vT_value_menu:=$vP_field->
			Else 
				If ($vP_field->="")
					$vT_value_menu:=""
				Else 
					$vT_value_menu:=x__btn_toggleReadTxt($vP_btn)
				End if 
		End case 
		
		$vT_path_icon:="path:/RESOURCES/"+$vT_subPath_icon
		$vT_refMenu:=Create menu:C408
		
		// *****
		// *
		$vT_prefix1:="woxPop."
		wox_4dPop_menu_header($vT_prefix1; $vJ_app; $vT_refMenu)
		// *
		// *****
		
		For each ($vJ_menu_item; $vC_menu)
			$vT_label:=$vJ_menu_item.t_label
			$is_separator:=($vT_label="")
			$vT_label:=$is_separator ? "-" : $vT_label
			If ($is_separator)
				APPEND MENU ITEM:C411($vT_refMenu; $vT_label)
				
			Else 
				$is_valid:=$vJ_menu_item.is_valid
				$c4Fu_method:=$vJ_menu_item.fu_method
				If ($c4Fu_method#Null:C1517)
					$c4Fu_method.call(Null:C1517; $vT_refMenu; $vJ_menu_item)
				Else 
					$vT_menu:=$vJ_menu_item.t_menu
					APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
					SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; $vT_menu)
					SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_icon+$vT_menu+k_png_ext)
					If ($vT_value_menu=$vT_menu)
						SET MENU ITEM MARK:C208($vT_refMenu; -1; Char:C90(18))
					End if 
					If (Not:C34($is_valid))
						DISABLE MENU ITEM:C150($vT_refMenu; -1)
					End if 
				End if 
			End if 
		End for each 
		
		$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
		RELEASE MENU:C978($vT_refMenu)
		$isOk:=(""#$vT_answerMenu)
		If ($isOk)
			If ($isModif)
				If (Not:C34($isNilField))
					$vP_field->:=$vT_answerMenu
				End if 
				If (Not:C34($isNilBtn))
					// Added for specific menu like Locals, url...
					$k:=Position:C15("."; $vT_answerMenu)
					If ($k>0)
						$vT_answerMenu:=Substring:C12($vT_answerMenu; 1; $k-1)
					End if 
					$idx:=$vC_menu.findIndex(Formula:C1597($1.value.t_menu=$vT_answerMenu))  // Think to adapt in R6
					If ($idx>=0)
						$vT_value_menu:=$vC_menu[$idx].t_menu
						x__btn_toggleSetTxt($vP_btn; $vT_value_menu)
					End if 
				End if 
			Else 
				$isOk:=False:C215
				BEEP:C151
			End if 
		End if 
		
End case 

