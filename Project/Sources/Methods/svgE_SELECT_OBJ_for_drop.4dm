//%attributes = {"invisible":true,"lang":"en"}
var $0 : Boolean

var $vJ_canvas : Object
svgE_getStuff_vJ(->$vJ_canvas)
var $vL_zoom : Integer
$vL_zoom:=$vJ_canvas.l_zoom
var $vL_containerX; $vL_containerY : Integer
$vL_containerX:=$vJ_canvas.containerX
$vL_containerY:=$vJ_canvas.containerY
//$containerW:=$ob_canvas.containerW
//$containerH:=$ob_canvas.containerH


var $vR_scale : Real
$vR_scale:=$vL_zoom/100

var $isOk : Boolean
$isOk:=False:C215

//MouseX and MouseY are not updated for On Drop event

var $x; $y; $vL_b; $vL_l; $vL_b; $vL_r; $vL_t; $i : Integer
GET MOUSE:C468($x; $y; $vL_b)
OBJECT GET COORDINATES:C663(*; "Canvas"; $vL_l; $vL_t; $vL_r; $vL_b)
$x:=($x-$vL_l)/$vR_scale
$y:=($y-$vL_t)/$vR_scale

//If (Not(Is nil pointer(OBJECT Get pointer(Object subform container))))
//$x:=$x-($containerX/$scale)
//$y:=$y-($containerY/$scale)
//End if

$vJ_canvas.l_clickX:=$x
$vJ_canvas.l_clickY:=$y

//old method
var $vP_sourceObject : Pointer
var $vL_sourceElement; $vL_sourceProcess : Integer
_O_DRAG AND DROP PROPERTIES:C607($vP_sourceObject; $vL_sourceElement; $vL_sourceProcess)

If (Not:C34(Is nil pointer:C315($vP_sourceObject)))
	Case of 
		: (Type:C295($vP_sourceObject->)=Is longint:K8:6)  //list
			$isOk:=Is a list:C621($vP_sourceObject->)
			If ($isOk)
				$isOk:=False:C215
				ARRAY LONGINT:C221($aL_selectedItems; 0)
				var $vL_selectedItem : Integer
				$vL_selectedItem:=Selected list items:C379($vP_sourceObject->; $aL_selectedItems)
				$x:=$vJ_canvas.l_clickX
				$y:=$vJ_canvas.l_clickY
				
				For ($i; 1; Size of array:C274($aL_selectedItems))
					$vJ_canvas.l_clickX:=$x+(10*($i-1))
					$vJ_canvas.l_clickY:=$y+(10*($i-1))
					var $vT_dropText : Text
					var $vL_itemRef : Integer
					GET LIST ITEM:C378($vP_sourceObject->; $aL_selectedItems{$i}; $vL_itemRef; $vT_dropText)
					$isOk:=$isOk | svgE_DROP_Text($vT_dropText)
				End for 
				$vJ_canvas.l_clickX:=$x
				$vJ_canvas.l_clickY:=$y
			End if 
			
		: (Type:C295($vP_sourceObject->)=Text array:K8:16)  //scrollable area
			$isOk:=($vL_sourceElement<=Size of array:C274($vP_sourceObject->))
			If ($isOk)
				$isOk:=svgE_DROP_Text($vP_sourceObject->{$vL_sourceElement})
			End if 
			
		: (Type:C295($vP_sourceObject->)=Is text:K8:3)
			$isOk:=svgE_DROP_Text(ST Get plain text:C1092($vP_sourceObject->))
			
		: (Type:C295($vP_sourceObject->)=Is picture:K8:10)
			$isOk:=svgE_DROP_Image($vP_sourceObject->)
			
	End case 
	
	If (Not:C34($isOk))
		ARRAY TEXT:C222($aT_signatures; 0)
		ARRAY TEXT:C222($aT_types; 0)
		ARRAY TEXT:C222($aT_formats; 0)
		GET PASTEBOARD DATA TYPE:C958($aT_signatures; $aT_types; $aT_formats)
		
		Case of 
			: (Find in array:C230($aT_signatures; "com.4d.private.text.@")#-1)
				$isOk:=svgE_DROP_Text(Get text from pasteboard:C524)
				
			: (Find in array:C230($aT_signatures; "com.4d.private.picture.@")#-1)
				var $vO_dropImage : Picture
				GET PICTURE FROM PASTEBOARD:C522($vO_dropImage)
				$isOk:=svgE_DROP_Image($vO_dropImage)
				
			: (Find in array:C230($aT_signatures; "com.4d.private.file.url")#-1)
				$i:=1
				ARRAY PICTURE:C279($aO_aP_dropPictures; 0)
				var $vO_dropPicture : Picture
				Repeat 
					var $vT_file : Text
					$vT_file:=Get file from pasteboard:C976($i)
					If (Is picture file:C1113($vT_file))
						READ PICTURE FILE:C678($vT_file; $vO_dropPicture)
						APPEND TO ARRAY:C911($aO_aP_dropPictures; $vO_dropPicture)
					End if 
					$i:=$i+1
				Until (Length:C16($vT_file)=0)
				$x:=$vJ_canvas.l_clickX
				$y:=$vJ_canvas.l_clickY
				For ($i; 1; Size of array:C274($aO_aP_dropPictures))
					$vJ_canvas.l_clickX:=$x+(10*($i-1))
					$vJ_canvas.l_clickY:=$y+(10*($i-1))
					$isOk:=$isOk | svgE_DROP_Image($aO_aP_dropPictures{$i})
				End for 
				$vJ_canvas.l_clickX:=$x
				$vJ_canvas.l_clickY:=$y
		End case 
	End if 
	
	
Else   //external source
	
	ARRAY TEXT:C222($aT_signatures; 0)
	ARRAY TEXT:C222($aT_types; 0)
	ARRAY TEXT:C222($aT_formats; 0)
	GET PASTEBOARD DATA TYPE:C958($aT_signatures; $aT_types; $aT_formats)
	
	Case of 
		: (Find in array:C230($aT_signatures; "com.4d.private.text.@")#-1)
			$isOk:=svgE_DROP_Text(Get text from pasteboard:C524)
			
		: (Find in array:C230($aT_signatures; "com.4d.private.picture.@")#-1)
			var $vO_dropImage : Picture
			GET PICTURE FROM PASTEBOARD:C522($vO_dropImage)
			$isOk:=svgE_DROP_Image($vO_dropImage)
			
		: (Find in array:C230($aT_signatures; "com.4d.private.file.url")#-1)
			$i:=1
			ARRAY PICTURE:C279($aO_aP_dropPictures; 0)
			var $vO_dropPicture : Picture
			Repeat 
				$vT_file:=Get file from pasteboard:C976($i)
				If (Is picture file:C1113($vT_file))
					READ PICTURE FILE:C678($vT_file; $vO_dropPicture)
					APPEND TO ARRAY:C911($aO_aP_dropPictures; $vO_dropPicture)
				End if 
				$i:=$i+1
			Until (Length:C16($vT_file)=0)
			$x:=$vJ_canvas.l_clickX
			$y:=$vJ_canvas.l_clickY
			For ($i; 1; Size of array:C274($aO_aP_dropPictures))
				$vJ_canvas.l_clickX:=$x+(10*($i-1))
				$vJ_canvas.l_clickY:=$y+(10*($i-1))
				$isOk:=$isOk | svgE_DROP_Image($aO_aP_dropPictures{$i})
			End for 
			$vJ_canvas.l_clickX:=$x
			$vJ_canvas.l_clickY:=$y
			
	End case 
	
End if 

If ($isOk)
	$vJ_canvas.t_currentObject:=""
End if 

$0:=$isOk

