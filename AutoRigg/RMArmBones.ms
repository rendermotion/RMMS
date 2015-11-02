
fn RMRiggCreateArmBones clavicle shoulder elbow wrist=(
	ArmArray=#(clavicle,shoulder,elbow,wrist)
	RiggBones=RMCreateBonesatPoints ArmArray
	
	RMAsigntoLayer "SkinedBones" RiggBones[1]
	ControlName=RMSetFromName wrist.name 4 "ctr"
	ControlName=RMSetFromName ControlName 5 "IK"
	LimbControl=RMCreateRiggControl wrist name:ControlName JustTheControl:True
	ArmStretchControls=RMStretchyIK RiggBones[2] RiggBones[4] controlShape:LimbControl
	
	PoleVectorName=RMSetFromName LimbControl.name 3 "ArmPoleVector"
	PoleVectorResetName=RMSetFromName LimbControl.name 3 "ArmPoleVectorReset"
	PoleVectorResetName=RMSetFromName PoleVectorResetName 4 "pnt"
	StretchControlPoint=RMSetFromName PoleVectorResetName 3 "ArmStretchControl"
	
	ArmStretchControls[1].name=StretchControlPoint
	ArmStretchControls[2].name=PoleVectorName
	(ArmStretchControls[2]).parent.name=PoleVectorResetName
	
	
	RMTwistBones RiggBones[2]
	twistArmControls=RMTwistBones RiggBones[3]
	
	FullArmOrigin=RMCreateParentPoint RiggBones[1] GuessName:True
	
	mergeMAXFile (ScriptPath+"Geometry\\ClavicleControlGeometry.max") #select
	ClavicleControl=selection[1]
	ClavicleWidth=abs (distance RiggBones[1] RiggBones[2])

	ClavicleControl.position=RiggBones[1].position
	
	if (RMGetFromName clavicle.name 2)=="RH" then
			(in coordsys Local scale ClavicleControl [ClavicleWidth,ClavicleWidth,ClavicleWidth])
	else 
			(in coordsys Local scale ClavicleControl [-ClavicleWidth,ClavicleWidth,ClavicleWidth])
	
	--Checks if exist a parent on the bone otherwise aligns the clavicle to the bone 
	if clavicle.parent != undefined then
	(
		ClavicleOrigin=RMCreateChildPoint clavicle.parent parented:False
		ClavicleOrigin.position=clavicle.position
		NewClav=RMCreateBonesatPoints ClavicleOrigin BoneSize:RiggBones[1].height
		NewClav.name=RiggBones[1].name
		a=RiggBones[1]
		NewClav.parent=a.parent
		RiggBones[1]=NewClav
		FullArmOrigin=RMCreateParentPoint RiggBones[1] GuessName:True
		(a.children[1]).parent=NewClav
		delete a.parent
		delete a
	)
	else 
	(
		ClavicleOrigin=RMCreateChildPoint RiggBones[1] parented:False
	)
	
	ClavicleControl.parent=ClavicleOrigin
	ResetXForm ClavicleControl
	convertToSplineShape ClavicleControl 
	RMAsigntoLayer "RiggControls" ClavicleControl
	
	ClavicleName=RMSetFromName clavicle.name 4 "ctr"
	ClavicleName=RMSetFromName ClavicleName 5 "rig"
	ClavicleControl.name=ClavicleName
	
	ClavicleName=RMSetFromName ClavicleName 3 "ClavicleOrigin"
	ClavicleOrigin.name=ClavicleName
	
	WorldOriented=RMCreateChildPoint FullArmOrigin name:(uniqueName("WorldOriented")) parented:False
	TorsoOriented=RMCreateChildPoint FullArmOrigin name:(uniqueName("TorsoOriented"))  parented:False
	
	RMSpaceSwitcCreator FullArmOrigin TorsoOriented WorldOriented ClavicleControl
	
	RMCreateChainControl  #(RiggBones[1]) WireControl:ClavicleControl
		
	(LimbControl.parent).parent=ClavicleControl 
	
	RMParentConstraint     LimbControl  RiggBones[4]  Flag:2
	RMAsigntoLayer "SkinedBones" RiggBones[4]
	
	return #(LimbControl,FullArmOrigin,ClavicleControl,WorldOriented,TorsoOriented,ArmStretchControls[2],RiggBones[4],twistArmControls[2][2])
	
	)