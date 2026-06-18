//%attributes = {"invisible":true,"lang":"en"}

SET DATABASE LOCALIZATION:C1104("en")

var $isOk : Boolean
$isOk:=(OK=1)
ALERT:C41(String:C10($isOk))

