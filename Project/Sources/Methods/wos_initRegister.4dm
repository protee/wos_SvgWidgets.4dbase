//%attributes = {"shared":true,"lang":"en"}

#DECLARE($vT_host_name : Text; $vT_serial : Text; $is_send : Boolean)->$is_serial_ok : Boolean
If (Count parameters:C259<3)
	$is_send:=Is compiled mode:C492  //|| True  // Send rapport if ogTools compiled
End if 

wok_init()
wox_initRegister()

var $vJ_prefs : Object
$vJ_prefs:=wos__storage_prefs

// ***** FIRST INITIALIZE
// *
$is_initialization:=($vJ_prefs=Null:C1517) || Shift down:C543
If ($is_initialization)
	var $vJ_woc_widget : Object
	var $is_initialization; $isOk : Boolean
	
	// ***** WOC
	// *
	$isOk:=woc_initRegister()
	$vJ_woc_widget:=woc__storage_prefs()
	Use ($vJ_woc_widget)
		$vJ_woc_widget.l_space:=k_svg_space  // Default palette favorite
		$vJ_woc_widget.is_mosaic:=True:C214  // Default mosaic
		$vJ_woc_widget.is_popup:=False:C215  // Default Colour picker Form
	End use 
	$vJ_woc_widget:=woc__storage_widgets.j_colour
	Use ($vJ_woc_widget)
		$vJ_woc_widget.l_space:=k_svg_space  // Default palette favorite
	End use 
	$vJ_woc_widget:=woc__storage_widgets.j_colour_widget
	Use ($vJ_woc_widget)
		$vJ_woc_widget.l_space:=k_svg_space  // Default palette favorite
	End use 
	// *
	// *****
	
	$vJ_prefs:=New shared object:C1526
	Use (Storage:C1525)
		Storage:C1525.j_prefs:=$vJ_prefs
	End use 
	app_init()
	app_init_prefs()
	app_init_stuff()
	app_init_widgets()
End if 
// *
// *****

// ***** THEN REGISTRATION
// *
$is_serial_ok:=wok_license_register($vJ_prefs; $vT_host_name; $vT_serial; $is_send)
// *
// *****

