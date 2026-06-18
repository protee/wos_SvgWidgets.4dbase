//%attributes = {"invisible":true,"lang":"en"}


#DECLARE($vP__object : Pointer; $vP__width : Pointer; $vP__height : Pointer; $vL_scale : Integer)  // {#4} optionals 
var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height : Integer

OBJECT GET COORDINATES:C663($vP__object->; $vL_left; $vL_top; $vL_right; $vL_bottom)
$vL_width:=$vL_right-$vL_left
$vL_height:=$vL_bottom-$vL_top
If ($vL_scale#0)
	If ($vL_scale#1)
		$vL_width:=$vL_width*$vL_scale
		$vL_height:=$vL_height*$vL_scale
	End if 
End if 
$vP__width->:=$vL_width
$vP__height->:=$vL_height

