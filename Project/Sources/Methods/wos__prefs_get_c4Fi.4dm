//%attributes = {"shared":true,"lang":"en"}
// *****
// *
// Method: waz__prefs_get_c4Fi
// Olivier Grimbert — Protée sarl — 09/07/2024 17:33:04
//
// Description:
//
// Date       | Who | Comment
// 09/07/2024 | OG  | Updated
// *
// *****

#DECLARE($vT_form : Text; $is_root : Boolean)->$c4Fi_prefs : 4D:C1709.File
$c4Fi_prefs:=wox_prefs_get_c4Fi(wos__storage_prefs; $vT_form; $is_root)


