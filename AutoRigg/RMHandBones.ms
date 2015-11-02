
fn AddHandAttributes HandControl=(
	caMano=attributes HandParam(
		parameters PMano rollout:CtrlMano
			(
			Pinky type:#float ui:DedoMeniqueSP
			Pinky1 type:#float ui:DedoMenique1SP

			Ring type:#float ui:DedoAnularSP
			Ring1 type:#float ui:DedoAnular1SP
	
			Middle type:#float ui:DedoMedioSP
			Middle1 type:#float ui:DedoMedio1SP

			Index type:#float ui:DedoIndiceSP
			Index1 type:#float ui:DedoIndice1SP

			Thumb type:#float ui:DedoPulgarSP
			Thumb1 type:#float ui:DedoPulgar1SP
			ThumbSplit type:#float ui:DedoPulgarSplitSP
			
			Cup  type:#float ui:CupSP
			Split  type:#float ui:SplitSP
			)
		Rollout CtrlMano "Control Dedos"
			(
			spinner DedoMeniqueSP "pikyRoot" offset:[0,0] range:[-10,90,0]
			spinner DedoMenique1SP "piky" offset:[0,0] range:[-10,90,0]
			spinner DedoAnularSP "ring" offset:[0,0] range:[-10,90,0]
			spinner DedoAnular1SP "ringroot" offset:[0,0] range:[-10,90,0]
			spinner DedoMedioSP "middle" offset:[0,0] range:[-10,90,0]
			spinner DedoMedio1SP "middleRoot" offset:[0,0] range:[-10,90,0]
			spinner DedoIndiceSP "index" offset:[0,0] range:[-10,90,0]
			spinner DedoIndice1SP "indexRoot" offset:[0,0] range:[-10,90,0]
			
			spinner DedoPulgarSP "thumb" offset:[0,0] range:[-10,90,0]
			spinner DedoPulgar1SP "thumbRoot" offset:[0,0] range:[-10,90,0]
			spinner DedoPulgarSplitSP "thumbSplit" offset:[0,0] range:[-45,90,0]
				
			spinner CupSP "Cup" offset:[0,0] range:[-10,90,0]
			spinner SplitSP "split" offset:[0,0] range:[-90,90,0]
			
			button Reset "reset"

			on Reset pressed do (
			Pinky=0
			Pinky1=0
			Ring=0
			Ring1=0
	
			Middle =0
			Middle1=0

			Index=0
			Index1=0

			Thumb=0
			Thumb1=0
			Cup=0
			Split=0
				)
			)
	)
	AttributeHolder=EmptyModifier()
	addModifier HandControl AttributeHolder
	custAttributes.add HandControl.modifiers[#Attribute_Holder] caMano
)
	
fn RMRiggFingerBones FingerStart ControlShape Finger:""=(
	FingerPointArray=RMGetHierarchyAsArray FingerStart
	FingerBoneArray=RMCreateBonesatPoints FingerPointArray
	
	RMAsigntoLayer "SkinedBones" FingerBoneArray AvoidNub:TRUE
	
	FingerStartPoint = RMCreateParentPoint #(FingerBoneArray[1])
	
	FingerStartPoint[1].name=RMsetFromName FingerBoneArray[1].name 4 "pnt"
	
	if findString FingerStart.name "Pinky" != undefined do 
		(
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Pinky] FingerBoneArray[1].rotation.controller[#Y_Rotation] "degtorad Pinky"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Pinky1] FingerBoneArray[2].rotation.controller[#Y_Rotation] "degtorad Pinky1"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Pinky1] FingerBoneArray[3].rotation.controller[#Y_Rotation] "degtorad Pinky1"
			
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Split] FingerBoneArray[1].rotation.controller[#Z_Rotation] "degtorad Split"
		)
	if findString FingerStart.name "Index" != undefined do 
		(
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Index] FingerBoneArray[1].rotation.controller[#Y_Rotation] "degtorad Index"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Index1] FingerBoneArray[2].rotation.controller[#Y_Rotation] "degtorad Index1"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Index1] FingerBoneArray[3].rotation.controller[#Y_Rotation] "degtorad Index1"
			
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Split] FingerBoneArray[1].rotation.controller[#Z_Rotation] "-degtorad Split"
		)
	if findString FingerStart.name "Ring" != undefined do 
		(
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Ring] FingerBoneArray[1].rotation.controller[#Y_Rotation] "degtorad Ring"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Ring1] FingerBoneArray[2].rotation.controller[#Y_Rotation] "degtorad Ring1"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Ring1] FingerBoneArray[3].rotation.controller[#Y_Rotation] "degtorad Ring1"
			
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Split] FingerBoneArray[1].rotation.controller[#Z_Rotation] "degtorad (Split/2)"
		)
	if findString FingerStart.name "Middle" != undefined do 
		(
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Middle] FingerBoneArray[1].rotation.controller[#Y_Rotation] "degtorad Middle"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Middle1] FingerBoneArray[2].rotation.controller[#Y_Rotation] "degtorad Middle1"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Middle1] FingerBoneArray[3].rotation.controller[#Y_Rotation] "degtorad Middle1"
		)
	if findString FingerStart.name "Thumb" != undefined do 
		(
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Thumb] FingerBoneArray[2].rotation.controller[#Y_Rotation] "degtorad Thumb"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Thumb1] FingerBoneArray[3].rotation.controller[#Y_Rotation] "degtorad Thumb1"
			paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#ThumbSplit] FingerBoneArray[1].rotation.controller[#Z_Rotation] "degtorad ThumbSplit"
			
			CupPointName=RMSetFromName FingerStart.name 3 "CupPoint"
			
			CupPoint=RMcreateChildPoint  #(FingerStart.parent) name:CupPointName
			
			CupPoint.position=FingerStartPoint[1].position
			FingerStartPoint[1].parent=CupPoint
			if (RMGetFromName CupPointName 2)=="RH" then 
				paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Cup] CupPoint.rotation.controller[#X_Rotation] "-degtorad Cup"
			else 
				paramWire.connect ControlShape.modifiers[#Attribute_Holder].HandParam[#Cup] CupPoint.rotation.controller[#X_Rotation] "degtorad Cup"
			CupPoint.parent=undefined
			return CupPoint
		)
	return FingerStartPoint[1]
	)
	
fn RMRiggHandBones PalmNode=(
	--PalmControl=RMCreateCircularControl PalmNode
	ControlName=RMSetFromName PalmNode.name 4 "ctrl"
	
	mergeMAXFile (ScriptPath+"Geometry\\HandControlGeometry.max") #select
	selection[1].name=ControlName
	PalmControl=selection[1]

	SizeReference=(PalmNode.parent).parent
	
	HandWidth=(distance PalmNode.position SizeReference.position)
	HandLenght=HandWidth
	HandHeight= HandWidth/5
	
	if (RMGetFromName PalmNode.name 2) == "RH" then 
		scale PalmControl [-HandWidth,-HandLenght,HandHeight]
	else 
		scale PalmControl [-HandWidth,HandLenght,HandHeight]
	
	ResetXForm PalmControl
	convertToSplineShape PalmControl
	
	RMAsigntoLayer "RiggControls" PalmControl
	
	PalmControl.transform=PalmNode.transform
	FullHandControl=RMCreateParentPoint PalmControl GuessName:True

	AddHandAttributes PalmControl
	FingerNodes=PalmNode.children
	StartFingers=#()
	for i in  FingerNodes do 
		append StartFingers (RMRiggFingerBones i PalmControl)
	
	PointName=RMSetFromName PalmNode.name 4 "pnt"
	PointName=RMSetFromName PointName 3 "FullHandBones"
	FullHandPoint=RMCreateChildPoint PalmNode Parented:False name:PointName
	
	for i in StartFingers do
		i.parent=FullHandPoint
		
	return #(FullHandControl , FullHandPoint)
	
)
