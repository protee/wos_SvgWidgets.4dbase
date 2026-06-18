//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vP_aT_answer : Pointer)->$vL_count : Integer
var $vP_aT_currentObjects : Pointer

$vP_aT_currentObjects:=OBJECT Get pointer:C1124(Object named:K67:5; "T_currentObjects")
If ($vP_aT_answer#Null:C1517)  //populated with the DOM references if passed
	$vP_aT_answer->:=$vP_aT_currentObjects
End if 
$vL_count:=Size of array:C274($vP_aT_currentObjects->)

