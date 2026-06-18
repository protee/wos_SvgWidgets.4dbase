//%attributes = {"invisible":true,"lang":"en"}

// EXAMPLE 1
// BAD
var $vL_Index; $vL_NumRows : Integer
For ($vL_Index; 1; $vL_NumRows)
	(OBJECT Get pointer:C1124(Object named:K67:5; "ColourPic_Col"))->{$vL_Index}:=(OBJECT Get pointer:C1124(Object named:K67:5; "ColourPic_Col"))->{$vL_Index}*0
End for 

// GOOD : gain in speed and lisibility 
$vL_NumRows:=LISTBOX Get number of rows:C915(*; "LB_svgColours")
var $vP_LB_picture : Pointer
$vP_LB_picture:=OBJECT Get pointer:C1124(Object named:K67:5; "ColourPic_Col")
For ($vL_Index; 1; $vL_NumRows)
	$vP_LB_picture->{$vL_Index}:=$vP_LB_picture->{$vL_Index}*0
	//...
End for 


// EXAMPLE 2
// BAD
var $is_fullPageFg : Boolean
If ($is_fullPageFg)
	OBJECT SET VISIBLE:C603(*; "Protected_Rect"; True:C214)
	//...
Else 
	OBJECT SET VISIBLE:C603(*; "Protected_Rect"; False:C215)
	//...
End if 

// GOOD : gain in lisibility, code size
OBJECT SET VISIBLE:C603(*; "Protected_Rect"; $is_fullPageFg)
If ($is_fullPageFg)
	//...
Else 
	//...
End if 


// EXAMPLE 3
// BAD
var $vL_Left; $vL_Top; $vL_Right; $vL_Bottom : Integer
$vJ_widget.svgArea:=New object:C1471
$vJ_widget.svgArea.fullWidth:=$vL_Right-$vL_Left
$vJ_widget.svgArea.fullHeight:=$vL_Bottom-$vL_Top
$vJ_widget.svgArea.headerWidth:=535
$vJ_widget.svgArea.headerHeight:=130
$vJ_widget.svgArea.deltaWidth:=$vJ_widget.svgArea.fullWidth-$vJ_widget.svgArea.headerWidth
$vJ_widget.svgArea.deltaHeight:=$vJ_widget.svgArea.fullHeight-$vJ_widget.svgArea.headerHeight

// GOOD : gain in lisibility, code size
var $vJ_widget : Object
var $vJ_svgArea : Object
$vJ_svgArea:=New object:C1471
$vJ_widget.svgArea:=$vJ_svgArea
$vJ_svgArea.fullWidth:=$vL_Right-$vL_Left
$vJ_svgArea.fullHeight:=$vL_Bottom-$vL_Top
$vJ_svgArea.headerWidth:=535
$vJ_svgArea.headerHeight:=130
$vJ_svgArea.deltaWidth:=$vJ_svgArea.fullWidth-$vJ_svgArea.headerWidth
$vJ_svgArea.deltaHeight:=$vJ_svgArea.fullHeight-$vJ_svgArea.headerHeight

// EXAMPLE 4
// Before
var $vJ_FormData : Object
$vJ_FormData:=New object:C1471
$vJ_FormData.defaults:=New object:C1471
$vJ_FormData.defaults.clinicName:="The Very Good Medical Centre"
$vJ_FormData.defaults.addressLine1:="Suite 4, Level 1"
$vJ_FormData.defaults.addressLine2:="12 West Street"
$vJ_FormData.defaults.suburb:="Demoville"
$vJ_FormData.defaults.state:="QLD"
$vJ_FormData.defaults.postCode:="4132"
$vJ_FormData.defaults.phone:="07 3870 6542"

// GOOD : gain in lisibility, code size
var $vJ_FormData; $vJ_FormData_default : Object
$vJ_FormData:=New object:C1471
$vJ_FormData_default:=New object:C1471
$vJ_FormData.defaults:=$vJ_FormData_default
$vJ_FormData_default.clinicName:="The Very Good Medical Centre"
$vJ_FormData_default.addressLine1:="Suite 4, Level 1"
$vJ_FormData_default.addressLine2:="12 West Street"
$vJ_FormData_default.suburb:="Demoville"
$vJ_FormData_default.state:="QLD"
$vJ_FormData_default.postCode:="4132"
$vJ_FormData_default.phone:="07 3870 6542"

