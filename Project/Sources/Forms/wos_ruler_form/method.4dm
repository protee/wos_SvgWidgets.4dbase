
var $is_changed; $isOk : Boolean
var $vL_event_code : Integer
var $vJ_wos_ruler : Object
var $vT_wos_ruler : Text
$vT_wos_ruler:="wos_ruler"

$vL_event_code:=Form event code:C388
Case of 
		//: ($evt=On Load)
		//: ($evt=On Data Change)
		//Form.date:=wog_getValue_date
		
		
	: ($vL_event_code=On Resize:K2:27)
		SET TIMER:C645(-1)
		
	: ($vL_event_code=On Timer:K2:25)
		SET TIMER:C645(0)
		$vJ_wos_ruler:=OBJECT Get value:C1743($vT_wos_ruler)
		$vJ_wos_ruler.resize()
		$vJ_wos_ruler.redraw()
		
		
	: ($vL_event_code=On Close Box:K2:21)  //| ($vL_event_code=On Deactivate)
		$vJ_wos_ruler:=OBJECT Get value:C1743($vT_wos_ruler)
		$is_changed:=(Form:C1466.l_value#$vJ_wos_ruler.l_value)
		$isOk:=$is_changed
		If ($isOk)
			Form:C1466.l_value:=$vJ_wos_ruler.l_value
			ACCEPT:C269
		Else 
			CANCEL:C270
		End if 
		
		
		//Else
		//TRACE
End case 

