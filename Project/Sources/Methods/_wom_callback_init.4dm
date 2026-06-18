//%attributes = {}

// DELETE ALL SPACES ICON'S FOLDERS

#DECLARE($vJ_dbf : Object; $vJ_build_options : Object)->$isOk : Boolean
$isOk:=True:C214

app_init  // Initialize values
wox_vJ_overload(wos__storage_prefs; $vJ_build_options; "t_name"; "t_version")

