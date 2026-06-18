//%attributes = {"invisible":true,"lang":"en"}

var $1 : Text
var ${2} : Real

var $vT_transform : Text
$vT_transform:=""

var $vL_countParameters : Integer
$vL_countParameters:=Count parameters:C259
If ($vL_countParameters>=3)  // Translate
	If ($2#0) | ($3#0)
		var $vT_sx; $vT_sy; $vT_tx; $vT_ty : Text
		$vT_tx:=String:C10($2; "&xml")
		$vT_ty:=String:C10($3; "&xml")
		$vT_transform:=$vT_transform+"translate("+$vT_tx+","+$vT_ty+")"
	End if 
	
	If ($vL_countParameters>=5)  // Scale
		If ($4#1) | ($5#1)
			$vT_sx:=String:C10($4; "&xml")
			$vT_sy:=String:C10($5; "&xml")
			$vT_transform:=$vT_transform+" scale("+$vT_sx+","+$vT_sy+")"
		End if 
		
		If ($vL_countParameters>=8)  // Rotate
			If ($6#0)
				var $vT_cx; $vT_cy; $vT_r : Text
				$vT_r:=String:C10($6; "&xml")
				$vT_cx:=String:C10($7; "&xml")
				$vT_cy:=String:C10($8; "&xml")
				$vT_transform:=$vT_transform+" rotate("+$vT_r+","+$vT_cx+","+$vT_cy+")"
			End if 
		End if 
	End if 
	
	If (Length:C16($vT_transform)#0)
		DOM SET XML ATTRIBUTE:C866($1; "transform"; $vT_transform)
	End if 
End if 

