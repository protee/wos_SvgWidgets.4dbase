//%attributes = {"shared":true,"lang":"en"}
// *****
// *
// Method: zen__prefs_get_path
// Olivier Grimbert — Protée sarl — 09/07/2024 17:33:04
//
// Description:
//
// Date       | Who | Comment
// 09/07/2024 | OG  | Updated
// *
// *****

#DECLARE($is_root : Boolean)->$c4Fo_prefs : 4D:C1709.Folder
$c4Fo_prefs:=wox_prefs_get_c4Fo(wos__storage_prefs; $is_root)

