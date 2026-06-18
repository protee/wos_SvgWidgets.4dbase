
// ----------------------------------------------------
// Database Method - On Host Database Event
// Database: wok_Krolific
// Created 16-7-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Automatic management of the 4DPop palette
// ----------------------------------------------------

#DECLARE($vL_event_code : Integer)

Case of 
	: ($vL_event_code=On before host database startup:K74:3)
		If (Is compiled mode:C492)  // Define the global error handler
			ON ERR CALL:C155("x__onError"; ek global:K92:2)
		End if 
		wos_initRegister()
		
		
		//: ($vL_event_code=On after host database startup)
		//wok_init()
		
		
		//: ($vL_event_code=On before host database exit)
		
		//: ($vL_event_code=On after host database exit)
		
End case 

