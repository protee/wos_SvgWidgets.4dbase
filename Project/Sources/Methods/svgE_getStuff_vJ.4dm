//%attributes = {"invisible":true,"lang":"en"}

#DECLARE($vP_vJ_canvas : Pointer; $vP_vJ_polyline : Pointer; $vP_vJ_history : Pointer)->$vJ_stuff : Object  // {#2} optionals 

$vJ_stuff:=Form:C1466.j_stuff
If ($vP_vJ_canvas#Null:C1517)
	$vP_vJ_canvas->:=$vJ_stuff.j_canvas
End if 
If ($vP_vJ_polyline#Null:C1517)
	$vP_vJ_polyline->:=$vJ_stuff.j_polyline
End if 
If ($vP_vJ_history#Null:C1517)
	$vP_vJ_history->:=$vJ_stuff.j_history
End if 


