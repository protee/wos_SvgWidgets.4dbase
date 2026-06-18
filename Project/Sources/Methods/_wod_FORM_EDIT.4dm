//%attributes = {"shared":true,"lang":"en"}
// Project Method: wogd_FORM_EDIT
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 24/06/2022   OG   Initial version.

#DECLARE($vL_noTable : Integer; $vT_form : Text)

If ($vL_noTable=0)
	FORM EDIT:C1749($vT_form)
Else 
	var $vP_table : Pointer
	$vP_table:=Table:C252($vL_noTable)
	FORM EDIT:C1749($vP_table->; $vT_form)
End if 

