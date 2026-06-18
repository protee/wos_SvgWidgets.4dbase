
ARRAY TEXT:C222($aT_widgets_name; 0)
ARRAY POINTER:C280($aP_widgets_ptr; 0)
y_getFormWidgets(->$aT_widgets_name; ->$aP_widgets_ptr)

var $vL_action; $vL_bottom; $vL_height; $vL_left; $vL_right; $vL_top; $vL_width : Integer
var $vP_widget : Pointer
$vL_action:=-1
If (x_btnPopup_choice(->$vL_action; ""; ->$aT_widgets_name))
	var $vO_img : Picture
	FORM SCREENSHOT:C940($vO_img)
	$vP_widget:=$aP_widgets_ptr{$vL_action+1}
	OBJECT GET COORDINATES:C663($vP_widget->; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
	TRANSFORM PICTURE:C988($vO_img; Crop:K61:7; $vL_left-1; $vL_top-1; $vL_width+2; $vL_height+2)
	//WRITE PICTURE FILE($path+$property+".png";$img)
	SET PICTURE TO PASTEBOARD:C521($vO_img)
End if 

