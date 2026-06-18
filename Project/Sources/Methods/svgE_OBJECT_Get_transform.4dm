//%attributes = {"invisible":true,"lang":"en"}
var $1; $0 : Text
var ${2} : Pointer

var $vT_object; $vT_objectType; $vT_points : Text
var $vL_countParameters : Integer

$vT_object:=$1
$vL_countParameters:=Count parameters:C259

var $vL_countAttributes; $j; $vL_p : Integer
$vL_countAttributes:=DOM Count XML attributes:C727($vT_object)
ARRAY TEXT:C222($aT_attributeNames; $vL_countAttributes)
ARRAY TEXT:C222($aT_attributeValues; $vL_countAttributes)

For ($j; 1; $vL_countAttributes)
	DOM GET XML ATTRIBUTE BY INDEX:C729($vT_object; $j; $aT_attributeNames{$j}; $aT_attributeValues{$j})
End for 

var $vR_tx; $vR_ty; $vR_sx; $vR_sy; $vR_r; $vR_cx; $vR_cy; $vR_rx; $vR_ry; $vR_cr; $vR_x1; $vR_x2; $vR_y1; $vR_y2; $vR_rtx; $vR_rty : Real
$vR_tx:=0
$vR_ty:=0
$vR_sx:=1
$vR_sy:=1

$vR_r:=0
$vR_rtx:=0
$vR_rty:=0
ARRAY LONGINT:C221($aL_pos; 0)
ARRAY LONGINT:C221($aL_len; 0)
If (Find in array:C230($aT_attributeNames; "transform")#-1)
	var $vT_transform : Text
	DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "transform"; $vT_transform)
	If (Match regex:C1019("translate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
		$vR_tx:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
		$vR_ty:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
	End if 
	If (Match regex:C1019("scale\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
		$vR_sx:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
		$vR_sy:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
	End if 
	If (Match regex:C1019("rotate\\((-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+),(-?(?:\\d|\\.)+)\\)"; $vT_transform; 1; $aL_pos; $aL_len))
		$vR_r:=Num:C11(Substring:C12($vT_transform; $aL_pos{1}; $aL_len{1}); ".")
		$vR_rtx:=Num:C11(Substring:C12($vT_transform; $aL_pos{2}; $aL_len{2}); ".")
		$vR_rty:=Num:C11(Substring:C12($vT_transform; $aL_pos{3}; $aL_len{3}); ".")
	End if 
End if 

var $vR_x; $vR_y; $vR_w; $vR_h; $vR_s : Real
$vR_x:=0
$vR_y:=0
$vR_w:=0
$vR_h:=0
$vR_s:=1

DOM GET XML ELEMENT NAME:C730($vT_object; $vT_objectType)
Case of 
	: ($vT_objectType="polyline")
		If (Find in array:C230($aT_attributeNames; "points")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "points"; $vT_points)
			ARRAY REAL:C219($aR_relative_x; 0)
			ARRAY REAL:C219($aR_relative_y; 0)
			ARRAY REAL:C219($aR_absolute_x; 0)
			ARRAY REAL:C219($aR_absolute_y; 0)
			
			$vL_p:=1
			While (Match regex:C1019("(-?(?:\\d|\\.)+)[,\\s](-?(?:\\d|\\.)+)"; $vT_points; $vL_p; $aL_pos; $aL_len))
				$vR_x:=Num:C11(Substring:C12($vT_points; $aL_pos{1}; $aL_len{1}); ".")
				$vR_y:=Num:C11(Substring:C12($vT_points; $aL_pos{2}; $aL_len{2}); ".")
				APPEND TO ARRAY:C911($aR_relative_x; $vR_x)
				APPEND TO ARRAY:C911($aR_relative_y; $vR_y)
				$vL_p:=$aL_pos{2}+$aL_len{2}
			End while 
			
			COPY ARRAY:C226($aR_relative_x; $aR_absolute_x)
			COPY ARRAY:C226($aR_relative_y; $aR_absolute_y)
			SORT ARRAY:C229($aR_relative_x)
			SORT ARRAY:C229($aR_relative_y)
			
			If (Size of array:C274($aR_relative_x)#0)
				$vR_x1:=$aR_relative_x{1}
				$vR_y1:=$aR_relative_y{1}
				$vR_x2:=$aR_relative_x{Size of array:C274($aR_relative_x)}
				$vR_y2:=$aR_relative_y{Size of array:C274($aR_relative_y)}
			Else 
				$vR_x1:=0
				$vR_y1:=0
				$vR_x2:=0
				$vR_y2:=0
			End if 
		End if 
		
		$vR_x:=$vR_x1
		$vR_y:=$vR_y1
		
		$vR_w:=($vR_x2-$vR_x1)  //*$vR_sx
		$vR_h:=($vR_y2-$vR_y1)  //*$vR_sy
		
		$vR_cx:=$vR_rtx
		$vR_cy:=$vR_rty
		
		If ($vL_countParameters>14)
			If (Not:C34(Is nil pointer:C315($14)))
				COPY ARRAY:C226($aR_absolute_x; $14->)
			End if 
			
			If (Not:C34(Is nil pointer:C315($15)))
				COPY ARRAY:C226($aR_absolute_y; $15->)
			End if 
		End if 
		
	: ($vT_objectType="line")
		If (Find in array:C230($aT_attributeNames; "x1")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "x1"; $vR_x1)
		End if 
		If (Find in array:C230($aT_attributeNames; "y1")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "y1"; $vR_y1)
		End if 
		If (Find in array:C230($aT_attributeNames; "x2")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "x2"; $vR_x2)
		End if 
		If (Find in array:C230($aT_attributeNames; "y2")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "y2"; $vR_y2)
		End if 
		$vR_x:=$vR_x1
		$vR_y:=$vR_y1
		$vR_w:=$vR_x2-$vR_x1  //important: we'll keep track of negative (illegal) width and height
		$vR_h:=$vR_y2-$vR_y1
		$vR_cx:=$vR_rtx
		$vR_cy:=$vR_rty
		
		
	: ($vT_objectType="circle")
		If (Find in array:C230($aT_attributeNames; "r")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "r"; $vR_cr)
		End if 
		If (Find in array:C230($aT_attributeNames; "cx")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "cx"; $vR_cx)
		End if 
		If (Find in array:C230($aT_attributeNames; "cy")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "cy"; $vR_cy)
		End if 
		$vR_x:=$vR_cx-$vR_cr
		$vR_y:=$vR_cy-$vR_cr
		$vR_w:=$vR_cr*2
		$vR_h:=$vR_cr*2
		$vR_cx:=$vR_rtx
		$vR_cy:=$vR_rty
		
		
	: ($vT_objectType="ellipse")
		If (Find in array:C230($aT_attributeNames; "rx")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "rx"; $vR_rx)
		End if 
		If (Find in array:C230($aT_attributeNames; "ry")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "ry"; $vR_ry)
		End if 
		If (Find in array:C230($aT_attributeNames; "cx")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "cx"; $vR_cx)
		End if 
		If (Find in array:C230($aT_attributeNames; "cy")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "cy"; $vR_cy)
		End if 
		
		$vR_x:=$vR_cx-$vR_rx
		$vR_y:=$vR_cy-$vR_ry
		$vR_w:=$vR_rx*2
		$vR_h:=$vR_ry*2
		$vR_cx:=$vR_rtx
		$vR_cy:=$vR_rty
		
		
	: ($vT_objectType="rect") | ($vT_objectType="image") | ($vT_objectType="textArea")
		var $vR_x; $vR_y; $vR_w; $vR_h : Real
		If (Find in array:C230($aT_attributeNames; "x")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "x"; $vR_x)
		End if 
		If (Find in array:C230($aT_attributeNames; "y")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "y"; $vR_y)
		End if 
		If (Find in array:C230($aT_attributeNames; "width")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "width"; $vR_w)
		End if 
		If (Find in array:C230($aT_attributeNames; "height")#-1)
			DOM GET XML ATTRIBUTE BY NAME:C728($vT_object; "height"; $vR_h)
		End if 
		$vR_cx:=$vR_rtx
		$vR_cy:=$vR_rty
		
End case 

$2->:=$vR_tx
$3->:=$vR_ty
$4->:=$vR_sx
$5->:=$vR_sy
$6->:=$vR_r
$7->:=$vR_cx
$8->:=$vR_cy
$9->:=$vR_x
$10->:=$vR_y
$11->:=$vR_w
$12->:=$vR_h

If ($vL_countParameters>12)
	If (Not:C34(Is nil pointer:C315($13)))
		// //If ($objectType="rect")
		//If (Find in array($attributeNames;"stroke-width")#-1) // OG => always stroke = 1
		//DOM GET XML ATTRIBUTE BY NAME($object;"stroke-width";$s)
		//End if 
		// //End if 
		$13->:=$vR_s
	End if 
End if 

$0:=$vT_objectType

