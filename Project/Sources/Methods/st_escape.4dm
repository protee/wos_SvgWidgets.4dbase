//%attributes = {"invisible":true,"lang":"en"}

var $txt : Text
$txt:=$1

// '&' is converted to &amp;
// '<' is converted to &lt;
// '>' is converted to &gt;

$txt:=Replace string:C233($txt; "&"; "&amp;")
$txt:=Replace string:C233($txt; "<"; "&lt;")
$txt:=Replace string:C233($txt; ">"; "&gt;")

$0:=$txt




