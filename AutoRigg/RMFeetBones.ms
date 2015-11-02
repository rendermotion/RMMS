fn RMAddFootAttributes FootControl=(
	caFoot=attributes FootParam(
		parameters PFoot rollout:CtrlFoot
			(
			FootRoll type:#float ui:FootRollSp  /********Rota el Pie Lateralmente**********/
			Toe type:#float ui:ToeSp   /********Mueve Los dedos  de forma independiente**********/
			Tip type:#float ui:TipSP
			BallRoll type:#float ui:BallRollSp
			Knee type:#float ui:KneeSp	
			)
		Rollout CtrlFoot "Control Dedos"
			(
			spinner FootRollSP "Roll" offset:[0,0] range:[-90,90,0]
			spinner ToeSP "Toe" offset:[0,0] range:[-90,90,0]
			spinner TipSP "Tip" offset:[0,0] range:[-90,90,0]
			spinner BallRollSP "Ball" offset:[0,0] range:[-90,90,0]
			spinner KneeSP "Knee" offset:[0,0] range:[-90,90,0]
			
			button Reset "reset"

			on Reset pressed do (
			)
			
			)
	)
	AttributeHolder=EmptyModifier()
	addModifier FootControl AttributeHolder
	custAttributes.add FootControl.modifiers[#Attribute_Holder] caFoot
)

fn RMRiggCreateFootBones AnklePoint FeetControl=(
	BallPoint=AnklePoint.children[1]
	FootLimits=BallPoint.children
	
	Toe=undefined
	BackLimit=undefined
	LeftLimit=undefined
	RightLimit=undefined
	
	for LimitPoint in FootLimits do
	(	if findString LimitPoint.name "toe" != undefined do 
			(	
				Toe=LimitPoint)
		if findString LimitPoint.name "Back" != undefined do 
			(
			BackLimit=LimitPoint
			)
		if findString LimitPoint.name "Left" != undefined do 
			(
			LeftLimit=LimitPoint
			)
		if findString LimitPoint.name "Right" != undefined do 
			(
			RightLimit=LimitPoint
			)
	)
	
	
	FeetPointArray=#(AnklePoint,BallPoint,Toe)

	FeetBonesArray=RMCreateBonesatPoints FeetPointArray
	
	
	RMAsigntoLayer "SkinedBones" FeetBonesArray AvoidNub:TRUE
	
	IKArray=RMAddIktoBones FeetBonesArray
	
	AnkleBonePoint=RMCreateParentPoint #(FeetBonesArray[1]) GuessName:True --SameOrientation:False
	

	ObjNames=RMSetFromName AnklePoint.name 5 "rig"
	BallRotationPoint=RMCreateChildPoint BallPoint Parented:FALSE name:(RMSetFromName ObjNames 3 "BallRotationPoint")
	print BallRotationPoint
    IKOrientationPoint= RMCreateChildPoint BallRotationPoint Parented:False Name:"PoleVector"
	
	IKOrientationPoint.position=RightLimit.position
	IKArray[1].transform.controller.VHTarget =IKOrientationPoint
	IKArray[2].transform.controller.VHTarget =IKOrientationPoint
	
	
	
	AnkleBonePoint.parent = BallRotationPoint
	ToeRotationPoint=RMCreateChildPoint BallPoint Parented:FALSE name:(RMSetFromName ObjNames 3 "ToeRotationPoint")
	IKArray[2].parent=ToeRotationPoint
	TipRotationPoint=RMCreateChildPoint Toe Parented:FALSE name:(RMSetFromName ObjNames 3 "TipRotationPoint")
	
	IKOrientationPoint.parent=TipRotationPoint
	
	ToeRotationPoint.parent=TipRotationPoint
	IKArray[1].parent=TipRotationPoint
	BallRotationPoint.parent=TipRotationPoint
	
	TapRotationPoint=RMCreateChildPoint BackLimit Parented:FALSE name:(RMSetFromName ObjNames 3 "TapRotationPoint")
	TipRotationPoint.parent=TapRotationPoint
	RollRotationLeftPoint=RMCreateChildPoint LeftLimit Parented:FALSE name:(RMSetFromName ObjNames 3 "RollLeftRotationPoint")
	RollRotationRightPoint=RMCreateChildPoint RightLimit Parented:FALSE name:(RMSetFromName ObjNames 3 "RollRightRotationPoint")
	TapRotationPoint.parent=RollRotationRightPoint
	RollRotationRightPoint.parent=RollRotationLeftPoint
	
	FullFeet=RMCreateParentPoint RollRotationLeftPoint GuessName:True parented:False
	RollRotationLeftPoint.parent=undefined
	
	(FeetControl.children[1]).parent=BallRotationPoint
	
	RMParentConstraint FeetControl FullFeet
	
	RollRotationLeftPoint.parent=FullFeet
	
	RMAddFootAttributes FeetControl
	
	paramWire.connect FeetControl.modifiers[#Attribute_Holder].FootParam[#FootRoll] RollRotationRightPoint.rotation.controller[#X_Rotation] "if FootRoll<=0 then degtoRad FootRoll else 0"
	paramWire.connect FeetControl.modifiers[#Attribute_Holder].FootParam[#FootRoll] RollRotationLeftPoint.rotation.controller[#X_Rotation] "if FootRoll>0 then degtoRad FootRoll else 0"
	
	paramWire.connect FeetControl.modifiers[#Attribute_Holder].FootParam[#BallRoll] TapRotationPoint.rotation.controller[#Y_Rotation] "if BallRoll<=0 then degtoRad BallRoll else 0"
	paramWire.connect FeetControl.modifiers[#Attribute_Holder].FootParam[#BallRoll] BallRotationPoint.rotation.controller[#Y_Rotation] "if BallRoll>0 then degtoRad BallRoll else 0"
	
	
	paramWire.connect FeetControl.modifiers[#Attribute_Holder].FootParam[#Toe] ToeRotationPoint.rotation.controller[#Y_Rotation] "degtoRad Toe"
	paramWire.connect FeetControl.modifiers[#Attribute_Holder].FootParam[#Tip] TipRotationPoint.rotation.controller[#Y_Rotation] "degtoRad Tip"

	return #(FeetControl,FullFeet)
	
)