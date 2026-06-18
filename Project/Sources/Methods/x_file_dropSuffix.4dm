//%attributes = {"invisible":true,"lang":"en"}
//Project Method: MCSU_FILE_DropSuffix(FileName) -> Name
//
//   Parameter        Type             Description
//   FileName         Text      ->     Name of the file for which to remove the
//                                     suffix.
//   Name             Text      <-     File name without the suffix.
//
//Description:
//   Removes the suffix from a file name.
//
//Date        Init  Description
//===============================================================================
//16/05/2006   JC   Initial version.
//20/03/2007   JC   Fix case where no '.' found and return full path as passed.
//16/04/2013   JC   Convert to use regex.

var $0 : Text
var $1; $vT_FileName : Text

ARRAY LONGINT:C221($aL_FoundPos; 0)
ARRAY LONGINT:C221($aL_FoundLen; 0)

$vT_FileName:=$1

If (Match regex:C1019(".*(\\.)[^\\"+Folder separator:K24:12+"]*$"; $vT_FileName; 1; $aL_FoundPos; $aL_FoundLen))
	$vT_FileName:=Substring:C12($vT_FileName; 1; $aL_FoundPos{Size of array:C274($aL_FoundPos)}-1)
End if 

$0:=$vT_FileName





