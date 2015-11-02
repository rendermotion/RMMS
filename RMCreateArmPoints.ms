ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
fileIn  (ScriptPath+"RMCreateHandPoints.ms")

fn RMCreateArmPoints OrigenPoint DirectionVector ArmSize Side=(
	ArmPointsArray=#()
	upVector=[0,0,1]
	TransvesalVector=normalize (cross DirectionVector upVector)
	claviclePoint=point name:("Character01_"+side+"_clavicle_pnt_rfr") Box:on Cross:off size:(ArmSize*.1) centermarker:on
	shoulderPoint=point name:("Character01_"+side+"_shoulder_pnt_rfr") Box:on Cross:off size:(ArmSize*.1) centermarker:on
	elbowPoint =point name:("Character01_"+side+"_elbow_pnt_rfr") Box:on Cross:off size:(ArmSize*.1) centermarker:on
	wristPoint=point name:("Character01_"+side+"_wrist_pnt_rfr") Box:on Cross:off size:(ArmSize*.1) centermarker:on
	
	if Side=="RH" do
		elbowPosition=OrigenPoint +DirectionVector*ArmSize*.5+TransvesalVector*.05*ArmSize
	if Side=="LF" do
		elbowPosition=OrigenPoint +DirectionVector*ArmSize*.5-TransvesalVector*.05*ArmSize
	
	wristPosition=OrigenPoint+DirectionVector*ArmSize
	shoulderPosition=OrigenPoint
	claviclePosition=OrigenPoint-DirectionVector*ArmSize*.1-upVector*ArmSize*.1
	
	RMObjLookXAtPoint claviclePoint (shoulderPosition-claviclePosition)
	RMObjLookXAtPoint shoulderPoint (elbowPosition-shoulderPosition)
	RMObjLookXAtPoint elbowPoint  (wristPosition-elbowPosition)
	RMObjLookXAtPoint wristPoint  (wristPosition-elbowPosition)
	
	claviclePoint.position=claviclePosition
	shoulderPoint.position=OrigenPoint
	elbowPoint.position=elbowPosition
	wristPoint.position=wristPosition
	
	shoulderPoint.parent=claviclePoint
	wristPoint.parent=elbowPoint
	elbowPoint.parent=shoulderPoint
	
	Hand=RMcreateHandPoints wristPoint.position (wristPosition-elbowPosition) (ArmSize/3) Side
	Hand.Parent =	wristPoint
	return claviclePoint 
)

