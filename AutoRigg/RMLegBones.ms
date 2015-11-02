	
fn	RMRiggCreateLegBones leg knee ankle=(
	ArmArray=#(leg,knee,ankle)
	RiggBones=RMCreateBonesatPoints ArmArray
	ControlName=RMSetFromName leg.name 4 "ctr"
	ControlName=RMSetFromName ControlName 5 "IK"
	/*****************************************/
	
	Toe=undefined
	BackLimit=undefined
	LeftLimit=undefined
	RightLimit=undefined
	
	FootLimits=(ankle.children[1]).children
	for LimitPoint in FootLimits do
	(   print "Loop1"
		print LimitPoint
		if findString LimitPoint.name "toe" != undefined do 
			(	print "AsigneTOe"
				print LimitPoint
				Toe=LimitPoint)
		if findString LimitPoint.name "Back" != undefined do 
			(
			print "AsigneBack"
			print LimitPoint
			BackLimit=LimitPoint
			)
		if findString LimitPoint.name "Left" != undefined do 
			(
			print "AsigneLeft"
			print LimitPoint
			LeftLimit=LimitPoint
			)
		if findString LimitPoint.name "Right" != undefined do 
			(
			print "AsigneRight"
			print LimitPoint
			RightLimit=LimitPoint
			)
	)
	
	mergeMAXFile (ScriptPath+"Geometry\\FeetControlGeometry.max") #select
	FeetWidth=abs (distance LeftLimit.position RightLimit.position)
	FeetLenght=abs(distance BackLimit.position Toe.position)
	FeetHeight= abs(ankle.position.z-BackLimit.position.z)
	print "*****************************************************"
	print "*****************************************************"
	print FeetWidth
	print FeetLenght
	print FeetHeight
	
	selection[1].name=ControlName
	LimbControl=selection[1]
	LimbControl.position=ankle.position
	if (RMGetFromName LimbControl.name 2) == "RH" then 
			scale LimbControl [FeetWidth,FeetLenght,FeetHeight]
	else 
			scale LimbControl [-FeetWidth,FeetLenght,FeetHeight]
	ResetXForm LimbControl
	convertToSplineShape LimbControl
	RMAsigntoLayer "RiggControls" LimbControl
	RMCreateParentPoint LimbControl GuessName:True

	/************************************************************/
	--LimbControl=RMCreateCircularControl ankle name:ControlName JustTheControl:True
	
	LegOrigin=RMCreateParentPoint  RiggBones[1] GuessName:True
	
	LegControls=RMStretchyIK RiggBones[1] RiggBones[3] controlShape:LimbControl
	
	
	PoleVectorName=RMSetFromName LimbControl.name 3 "LegPoleVector"
	PoleVectorResetName=RMSetFromName LimbControl.name 3 "LegPoleVectorReset"
	PoleVectorResetName=RMSetFromName PoleVectorResetName 4 "pnt"
	StretchControlPoint=RMSetFromName PoleVectorResetName 3 "LegStretchControl"
	
	
	LegControls[1].name=StretchControlPoint
	LegControls[2].name=PoleVectorName
	
	(LegControls[2]).parent.name=PoleVectorResetName


	RMTwistBones RiggBones[1]
	LegTwistBones=RMTwistBones RiggBones[2]
	
	return #(LegOrigin,LimbControl,LegControls[2],RiggBones[3],LegTwistBones[2][2])
	)
	


