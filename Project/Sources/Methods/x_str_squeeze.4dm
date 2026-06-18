//%attributes = {"invisible":true,"lang":"en"}
//Project Method: MCSU_STR_Squeeze(InputString)->OutputString
//
//   Parameter         Type             Description
//   InputString       Text       ->    String to be "squeezed"
//   OutputString      Text       <-    "Squeezed" string
//
//Description:
//   Removes whitespace (eg. spaces, tabs, carriage returns) from the
//   beginning and end of the supplied string.
//   Compresses whitespace within the string to a single character.
//   The character chosen is the lowest index in the $aT_WhiteSpace
//   array, e.g. <>SP+<>CR+<>TB is replaced with <>CR
//
//Date               Init   Description
//================================================================================
//15/01/2003   JC   Initial version
//25/02/2003   JC   Cater for wildcard character (@) in strings
//05/12/2005   JC   Also remove line feeds.
//05/12/2005   JC   Also remove NULLs.
//10/12/2009   SS   DO NOT remove NULLs (thanks v11).
//15/12/2009   JC   Use Char(160) instead of Char(202) as non-breaking space.
//20/03/2012   JC   Make line feeds higher priority than spaces.
//04/06/2013   SH   Cater for wildcard character.

var $0; $vT_Output : Text
var $1; $vT_Input : Text

var $vL_CharIndex; $vL_LowestIndex; $vL_ArrayIndex : Integer
ARRAY TEXT:C222($aT_WhiteSpace; 5)
$aT_WhiteSpace{1}:=kCR
$aT_WhiteSpace{2}:=kTB
$aT_WhiteSpace{3}:=kLF
$aT_WhiteSpace{4}:=kSP
$aT_WhiteSpace{5}:=Char:C90(160)

$vT_Input:=$1
$vT_Output:=""

//Remove leading whitespace
While ((Find in array:C230($aT_WhiteSpace; Substring:C12($vT_Input; 1; 1))>0) & (Character code:C91(Substring:C12($vT_Input; 1; 1))#64))
	$vT_Input:=Substring:C12($vT_Input; 2)
End while 

//Remove trailing whitespace
While ((Find in array:C230($aT_WhiteSpace; Substring:C12($vT_Input; Length:C16($vT_Input)))>0) & (Character code:C91(Substring:C12($vT_Input; Length:C16($vT_Input)))#64))
	$vT_Input:=Substring:C12($vT_Input; 1; Length:C16($vT_Input)-1)
End while 

//Compress internal whitespace
For ($vL_CharIndex; 1; Length:C16($vT_Input))
	$vL_LowestIndex:=Find in array:C230($aT_WhiteSpace; $vT_Input[[$vL_CharIndex]])
	If (($vL_LowestIndex>0) & (Character code:C91($vT_Input[[$vL_CharIndex]])#64))
		$vL_ArrayIndex:=Find in array:C230($aT_WhiteSpace; Substring:C12($vT_Input; $vL_CharIndex+1; 1))
		While (($vL_ArrayIndex>0) & (Character code:C91($vT_Input[[$vL_CharIndex+1]])#64))  //Ignore if symbol was "@"
			If ($vL_ArrayIndex<$vL_LowestIndex)
				$vL_LowestIndex:=$vL_ArrayIndex
			End if 
			$vL_CharIndex:=$vL_CharIndex+1
			$vL_ArrayIndex:=Find in array:C230($aT_WhiteSpace; Substring:C12($vT_Input; $vL_CharIndex+1; 1))
		End while 
		$vT_Output:=$vT_Output+$aT_WhiteSpace{$vL_LowestIndex}
	Else 
		$vT_Output:=$vT_Output+$vT_Input[[$vL_CharIndex]]
	End if 
End for 

$0:=$vT_Output




