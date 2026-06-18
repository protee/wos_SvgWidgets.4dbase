//%attributes = {}

var $vC_fu_launch : Collection

wos_initRegister
//DB_onStartup()

SET MENU BAR:C67(1)

$vC_fu_launch:=New collection:C1472()
$vC_fu_launch.push(Formula:C1597(wos_editor_demo); Formula:C1597(wos_widgets_mng); Null:C1517)
$vC_fu_launch.push(Formula:C1597(___test_header_p3); Formula:C1597(___test_wos_svgEditor))
$vC_fu_launch.push(Formula:C1597(___test_widgets))

wox_util_fu_menu_call($vC_fu_launch)


