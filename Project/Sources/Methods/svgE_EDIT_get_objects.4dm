//%attributes = {"invisible":true,"lang":"en"}


#DECLARE($vP_aT_item_refs : Pointer; $vP_aT_item_names : Pointer; $vP_aT_item_ids : Pointer; $is_cleaning : Boolean; $vP_T_currentObjects : Pointer)->$tt : Integer  // {#4} optionals 
var $is_ptr_current : Boolean
var $i; $vL_count_items_back; $tt_sel : Integer
var $vT_domRef; $vT_first_XML_Ref; $vT_item_name; $vT_item_id; $vT_next_XML_Ref : Text
$is_ptr_current:=($vP_T_currentObjects#Null:C1517)

$vT_domRef:=Form:C1466.t_domRef

ARRAY TEXT:C222($vP_aT_item_refs->; 0)
ARRAY TEXT:C222($vP_aT_item_names->; 0)
ARRAY TEXT:C222($vP_aT_item_ids->; 0)
$vT_first_XML_Ref:=DOM Get first child XML element:C723($vT_domRef; $vT_item_name)
If (OK=1)
	APPEND TO ARRAY:C911($vP_aT_item_refs->; $vT_first_XML_Ref)
	APPEND TO ARRAY:C911($vP_aT_item_names->; $vT_item_name)
	DOM GET XML ATTRIBUTE BY NAME:C728($vT_first_XML_Ref; "id"; $vT_item_id)
	APPEND TO ARRAY:C911($vP_aT_item_ids->; $vT_item_id)
End if 
$vT_next_XML_Ref:=$vT_first_XML_Ref
While (OK=1)
	$vT_next_XML_Ref:=DOM Get next sibling XML element:C724($vT_next_XML_Ref; $vT_item_name)
	If (OK=1)
		APPEND TO ARRAY:C911($vP_aT_item_refs->; $vT_next_XML_Ref)
		APPEND TO ARRAY:C911($vP_aT_item_names->; $vT_item_name)
		DOM GET XML ATTRIBUTE BY NAME:C728($vT_next_XML_Ref; "id"; $vT_item_id)
		APPEND TO ARRAY:C911($vP_aT_item_ids->; $vT_item_id)
	End if 
End while 

//SVG_ELEMENTS_TO_ARRAYS ($domRef;$ptr_T_item_refs;$ptr_T_item_names;$ptr_T_item_ids)
// Possible to use this command, but the first "<defs id="4D"/>" is not inside.
// So you must take it in account in <>count_items_back if you use this command


$tt:=Size of array:C274($vP_aT_item_refs->)
If ($is_cleaning)
	For ($i; $tt; 1; -1)
		If (Length:C16($vP_aT_item_ids->{$i})=32)  // $i found last clean object
			$tt:=$i
			$i:=0  // Out
		End if 
	End for 
	// To remove at end
	ARRAY TEXT:C222($vP_aT_item_refs->; $tt)
	ARRAY TEXT:C222($vP_aT_item_names->; $tt)
	ARRAY TEXT:C222($vP_aT_item_ids->; $tt)
	
	$vL_count_items_back:=wos__storage_stuff().l_count_items_back+1  // To remove at beginning
	DELETE FROM ARRAY:C228($vP_aT_item_refs->; 1; $vL_count_items_back)
	DELETE FROM ARRAY:C228($vP_aT_item_names->; 1; $vL_count_items_back)
	DELETE FROM ARRAY:C228($vP_aT_item_ids->; 1; $vL_count_items_back)
	$tt:=Size of array:C274($vP_aT_item_refs->)
End if 

If ($is_ptr_current)
	// Sort current from back to front
	$tt_sel:=Size of array:C274($vP_T_currentObjects->)
	ARRAY LONGINT:C221($aL_sort; $tt_sel)
	For ($i; 1; $tt_sel)
		$aL_sort{$i}:=Find in array:C230($vP_aT_item_refs->; $vP_T_currentObjects->{$i})
	End for 
	SORT ARRAY:C229($aL_sort; $vP_T_currentObjects->)
End if 

