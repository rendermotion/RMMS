ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMNameConvention.ms")

fn RenameSelection baseName  SideType ObjName chkCN ObjType Status=(
	ObjSel=selection as array
	NSObj=ObjSel.count
	for i=1 to NSObj do
	(
		NameArray=#()
		NameArray[1]=baseName
		NameArray[2]= case SideType  of (
			1:"MD"
			2:"LF"
			3:"RH"
			)
		if (chkCN == TRUE) then 
			if RMIsNameInFormat ObjSel[i] then
				NameArray[3]=RMGetFromName ObjSel[i].name 3
			else
				NameArray[3]=ObjSel[i].name
		else 
			NameArray[3]=ObjName
		NameArray[4]= case ObjType of (
			1:"msh"
			2:"ctr"
			3:"jnt"
			4:"shp"
			5:"grp"
			6:"pnt"
			)
	NameArray[5]=case Status of (
		1:"ful"
		2:"prx"
		3:"mph"
		4:"IK"
		5:"FK"
		6:"rbn"
		)
	Cuenta=NameArray.count

	NewName = RMstringArrayToString NameArray "_"
	NewName = RMUniqueName NewName
	ObjSel[i].name=NewName
	)
	
	)
fn  RenameApplyCharName baseName = 
	(
		for i in selection do
			(
				NewName=RMSetFromName i.name 1 baseName
			i.name =RMUniqueName NewName
			)
		)

fn  RenameApplyObjName ObjName = 
	(
		for i in selection do
			(
				NewName=RMSetFromName i.name 3 ObjName
			i.name =RMUniqueName NewName
			)
		)
fn RenameApplySideType SideType=
	(
		SideTypeTxt= case SideType  of (
			1:"MD"
			2:"LF"
			3:"RH"
			)
	for i in selection do
			(
				NewName=RMSetFromName i.name 2 SideTypeTxt
			i.name =RMUniqueName NewName
			)
	)
fn RenameApplyObjType ObjType=(
	ObjTypeTxt= case ObjType of (
			1:"msh"
			2:"ctr"
			3:"jnt"
			4:"shp"
			5:"grp"
			6:"pnt"
			)
	for i in selection do
			(
			NewName=RMSetFromName i.name 4 ObjTypeTxt
			i.name =RMUniqueName NewName
			)
)
fn RenameApplyObjStatus rdoStatus=(
	print rdoStatus
	rdoStatusTxt =case rdoStatus of (
		1:"ful"
		2:"prx"
		3:"mph"
		4:"IK"
		5:"FK"
		6:"rbn"
		)
	print rdoStatusTxt
	for i in selection do
			(
			NewName=RMSetFromName i.name 5 rdoStatusTxt
			i.name =RMUniqueName NewName
			)
	)
fn BaseNameFromScene = (
	if maxFileName != "" then (
		Tokens = filterString maxFileName "."
		BaseName=RMGetFromName Tokens[1] 1 
		)
	else  
		BaseName ="";
return BaseName
	)

rollout RenamerRollout "Rename Objects" width:512 height:216
(
	label lblMainName "Character/Obj Name" pos:[22,13] width:112 height:19
	edittext baseName "" pos:[132,9] width:122 height:17 text:(BaseNameFromScene()) 
	radiobuttons SideType "" pos:[138,44] width:127 height:16 labels:#("MD", "LF", "RH") default:1 columns:3
	label lblSideType "SideType" pos:[23,44] width:62 height:19
	label lblObjName "Object Name" pos:[22,76] width:112 height:19
	edittext ObjName "" pos:[128,72] width:122 height:17
	checkbox chkCN "Use Current Name" pos:[257,76] width:120 height:17 checked:true
	radiobuttons ObjType "" pos:[139,102] width:225 height:32 labels:#("msh Mesh", "ctr Control", "jnt Joint", "shp  shape", "grp  group", "pnt  point") default:1 columns:3
	label lblObjType "Object Type" pos:[24,102] width:62 height:19
	radiobuttons rdoStatus "" pos:[139,141] width:228 height:32 labels:#("ful Full", "prx Proxy", "mph Morph", "IK", "FK", "rbn Ribbon") default:1 columns:3
	label lblStatus "Object Status/System" pos:[20,142] width:112 height:32
	button Rename "Rename" pos:[16,184] width:224 height:24
	button btnObjName "Apply Char/Obj Name" pos:[368,8] width:120 height:24
	button btnSideType "Apply SideType" pos:[368,41] width:120 height:24
	button btnPartName "Apply Object Name" pos:[368,73] width:120 height:24
	button btnObjType "Apply Object Type" pos:[368,104] width:120 height:24
	button btnStatus "Apply Object Status" pos:[368,144] width:120 height:24
	
	on ObjName entered ObjText do
			RenameSelection baseName.text  SideType.state ObjText chkCN.checked ObjType.state rdoStatus.state
	on Rename pressed do 
		     RenameSelection baseName.text  SideType.state ObjName.text chkCN.checked ObjType.state rdoStatus.state
	on btnObjName pressed do 
		     RenameApplyCharName baseName.text
	on btnSideType pressed do 
		     RenameApplySideType SideType.state
	on btnPartName pressed do 
		     RenameApplyObjName ObjName.text
	on btnObjType pressed do 
		     RenameApplyObjType ObjType.state
	on btnStatus pressed do 
		     RenameApplyObjStatus rdoStatus.state
	
)
FloatWindow = newRolloutFloater "Rename Objects" 520 250
addRollout RenamerRollout FloatWindow

