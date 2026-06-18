//%attributes = {"invisible":true,"lang":"en"}
// Project Method: x_send_onDataChange
//
// Parameter Type Description
// {$1} <L> -> Event to send if specified
//
// Description:
// Send "On Data Change" event, or other if specified
//
// Date        Init  Description
// ===================================================================
// 23/02/2021   OG   Initial version.


#DECLARE($vL_event : Integer)  // {#1} optionals 
If (Count parameters:C259<1)
	$vL_event:=On Data Change:K2:15
End if 

CALL SUBFORM CONTAINER:C1086($vL_event)





