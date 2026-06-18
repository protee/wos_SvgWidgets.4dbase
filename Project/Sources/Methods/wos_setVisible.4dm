//%attributes = {"shared":true,"lang":"en"}

#DECLARE($is_visible : Boolean; $vT_widgetName : Text)  // {#1} optionnals
If ($vT_widgetName="")
	$vT_widgetName:=OBJECT Get name:C1087(Object current:K67:2)
End if 

OBJECT SET VISIBLE:C603(*; $vT_widgetName; $is_visible)


