// *****
// *
// Class: _wocs
// Olivier Grimbert — Protée sarl — 15/08/2024 14:18:11
//
// Description: 
//
// Date       | Who | Comment
// 15/08/2024 | OG  | Updated
// *
// *****

Class constructor($vT_widget : Text)
	If ($vT_widget#"")
		This:C1470._params($vT_widget)
	End if 
	//This.j_value:=New object
	This:C1470.t_property:=""
	This:C1470.p_value:=Null:C1517
	This:C1470.l_border:=Border None:K42:27
	This:C1470.t_widget:=""
	
	
Function _params($vT_widget : Text)
	var $vJ_widget : Object
	$vJ_widget:=wos__storage_widgets($vT_widget)
	
	var $vL_count_parameters : Integer
	$vL_count_parameters:=Count parameters:C259
	
	var $vC_entries : Collection
	$vC_entries:=OB Entries:C1720($vJ_widget)
	var $vT_key : Text
	var $vL_type : Integer
	var $vJ_item : Object
	var $vV_value : Variant
	For each ($vJ_item; $vC_entries)
		$vT_key:=$vJ_item.key
		$vV_value:=$vJ_item.value
		$vL_type:=Value type:C1509($vV_value)
		Case of 
			: ($vL_type=Is object:K8:27)
				This:C1470[$vT_key]:=OB Copy:C1225($vV_value; ck not shared:K85:35)
			: ($vL_type=Is collection:K8:32)
				This:C1470[$vT_key]:=$vV_value.copy(ck not shared:K85:35)
			Else 
				This:C1470[$vT_key]:=$vV_value
		End case 
	End for each 
	
	
	
	// *****
	// *
Function load($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; Border None:K42:27)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._load()))
	
	
Function resize($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; This:C1470.l_border)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._resize()))
	
	
Function redraw($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._redraw()))
	
	
Function unload($vT_widget : Text)  // Wrapper into subform
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	var $vJ_this : Object
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._unload()))
	
	
Function get_object_wh($vT_object : Text; $vP_width : Pointer; $vP_height : Pointer; $vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._get_object_wh($vT_object; $vP_width; $vP_height)))
	
	
Function get_canvas_wh($vP_width : Pointer; $vP_height : Pointer; $vT_widget : Text)  // Wrapper into subform
	This:C1470.get_object_wh("canvas"; $vP_width; $vP_height; $vT_widget)
	// *
	// *****
	
	
	// *****
	// *
Function set_widget_name($vT_widget : Text)
	// Set the widget instance name into the class, empty = OBJECT Get name, else $vT_widget
	$vT_widget:=$vT_widget="" ? OBJECT Get name:C1087 : $vT_widget
	This:C1470.t_widget:=$vT_widget
	
	
Function bind_to_property($vJ_value : Object; $vT_property : Text)
	This:C1470.j_value:=$vJ_value
	This:C1470.t_property:=$vT_property
	// *
	// *****
	
	
	// *****
	// *
Function _get_object_wh($vT_object : Text; $vP_width : Pointer; $vP_height : Pointer)
	var $vL_bottom; $vL_left; $vL_right; $vL_top : Integer
	OBJECT GET COORDINATES:C663(*; $vT_object; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vP_width->:=$vL_right-$vL_left
	$vP_height->:=$vL_bottom-$vL_top
	
	
Function _get_widget_name($vT_widget_in : Text)->$vT_widget : Text
	// get widget name, from stored, input or from OBJECT Get name
	var $vT_widget_object : Text
	$vT_widget_object:=This:C1470.t_widget
	If ($vT_widget_in="")  // Not given
		If ($vT_widget_object#"")
			$vT_widget:=$vT_widget_object  // Get stored
		Else 
			$vT_widget:=OBJECT Get name:C1087  // Get from object and store
			This:C1470.t_widget:=$vT_widget
		End if 
	Else 
		$vT_widget:=$vT_widget_in  // use given and store
		This:C1470.t_widget:=$vT_widget
	End if 
	// *
	// *****
	
	
	
	// MARK: - External read/write - pointer or j_value.t_property -> j_widget.t_internal
	// *
Function _externalRead()  // Synch an internal property to a pointer, or an j_value.t_property
	var $vP_value : Pointer
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		var $vT_internal : Text
		$vT_internal:=This:C1470.t_internal
		If ($vT_internal#"")
			This:C1470[$vT_internal]:=$vP_value->
		End if 
	Else 
		var $vJ_value : Object
		$vJ_value:=This:C1470.j_value
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		If ($vJ_value#Null:C1517) && ($vT_property#"")
			$vT_internal:=This:C1470.t_internal
			$vT_internal:=$vT_internal#"" ? $vT_internal : $vT_property  // Use $vT_property if $vT_internal empty
			This:C1470[$vT_internal]:=$vJ_value[$vT_property]
		End if 
	End if 
	
	
Function _externalWrite()
	var $vT_property : Text
	var $vP_value : Pointer
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		var $vT_internal : Text
		$vT_internal:=This:C1470.t_internal
		If ($vT_internal#"")
			$vP_value->:=This:C1470[$vT_internal]
		End if 
	Else 
		var $vJ_value : Object
		$vJ_value:=This:C1470.j_value
		$vT_property:=This:C1470.t_property
		If ($vJ_value#Null:C1517) && ($vT_property#"")
			$vT_internal:=This:C1470.t_internal
			$vT_internal:=$vT_internal#"" ? $vT_internal : $vT_property  // Use $vT_property if $vT_internal empty
			$vJ_value[$vT_property]:=This:C1470[$vT_internal]
		End if 
	End if 
	// *
	// *****
	
	
	// MARK: - read write
	
	
	// ***** TEXT
	// *
Function _ext_read_t()->$vT_value : Text
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vT_value:=$vJ_value[$vT_property]
	Else 
		//$vV_value:=This.v_value
		//$vL_state:=(This.is_idle) ? $vV_value : Num($vV_value)
		$vT_value:=This:C1470.t_value
	End if 
	
	
Function _ext_write_t($vT_value : Text)
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	This:C1470.t_value:=$vT_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vJ_value[$vT_property]:=$vT_value
	End if 
	// *
	// *****
	
	
	
	// ***** INTEGER
	// *
Function _ext_read_l()->$vL_value : Integer
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vL_value:=$vJ_value[$vT_property]
	Else 
		//$vV_value:=This.v_value
		//$vL_state:=(This.is_idle) ? $vV_value : Num($vV_value)
		$vL_value:=This:C1470.l_value
	End if 
	
	
Function _ext_write_l($vL_value : Integer)
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	This:C1470.l_value:=$vL_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vJ_value[$vT_property]:=$vL_value
	End if 
	// *
	// *****
	
	
	
	// ***** DATE
	// *
Function _ext_read_d()->$vD_value : Date
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vD_value:=$vJ_value[$vT_property]
		This:C1470.d_value:=$vD_value
	Else 
		$vD_value:=This:C1470.d_value
	End if 
	
	
Function _ext_write_d($vD_value : Date)
	This:C1470.d_value:=$vD_value
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vJ_value[$vT_property]:=$vD_value
	End if 
	// *
	// *****
	
	
	
	// ***** TIME
	// *
Function _ext_read_h()->$vH_value : Time
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vH_value:=$vJ_value[$vT_property]
		This:C1470.h_value:=$vH_value
	Else 
		$vH_value:=This:C1470.h_value
	End if 
	
	
Function _ext_write_h($vH_value : Time)
	This:C1470.h_value:=$vH_value
	var $vJ_value : Object
	$vJ_value:=This:C1470.j_value
	If ($vJ_value#Null:C1517)
		var $vT_property : Text
		$vT_property:=This:C1470.t_property
		$vJ_value[$vT_property]:=$vH_value
	End if 
	// *
	// *****
	
	