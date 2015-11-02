ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMNameConvention.ms")
filein (ScriptPath+"RMRiggMath.ms")

fn RMCreateLegPoints OriginPoint  DirectionVector FrontVector  LegSize side=
(
	LegPointsArray=#()

	TransversalVector=normalize (cross DirectionVector FrontVector)
	FrontVector=normalize (cross TransversalVector DirectionVector)
	legPoint=point name:("Character01_"+side+"_leg_pnt_rfr") Box:on Cross:off size:(LegSize*.1) centermarker:on
	kneePoint =point name:("Character01_"+side+"_knee_pnt_rfr") Box:on Cross:off size:(LegSize*.1) centermarker:on
	anklePoint=point name:("Character01_"+side+"_ankle_pnt_rfr") Box:on Cross:off size:(LegSize*.1) centermarker:on
	ballPoint=point name:("Character01_"+side+"_ball_pnt_rfr") Box:on Cross:off size:(LegSize*.1) centermarker:on
	toePoint=point name:("Character01_"+side+"_toe_pnt_rfr") Box:on Cross:off size:(LegSize*.1) centermarker:on
	
	FootLimitBackPoint=point name:("Character01_"+side+"_footLimitBack_pnt_rfr") Box:off Cross:off size:(LegSize*.1) centermarker:on
	FootLimitLeftPoint =point name:("Character01_"+side+"_footLimitLeft_pnt_rfr") Box:off Cross:off size:(LegSize*.1) centermarker:on
	FootLimitRightPoint=point name:("Character01_"+side+"_footLimitRight_pnt_rfr") Box:off Cross:off size:(LegSize*.1) centermarker:on
	
	legPosition=OriginPoint 
	kneePosition=OriginPoint + DirectionVector* LegSize *.5+FrontVector*.05*LegSize
	anklePosition=OriginPoint+DirectionVector*LegSize
	ballPosition=anklePosition+FrontVector*.1*LegSize+DirectionVector* LegSize *.05
	toePosition=ballPosition+FrontVector*.1*LegSize
	
	FootLimitBackPosition=anklePosition+DirectionVector* LegSize *.05
	FootLimitLeftPosition=ballPosition+TransversalVector*.05*LegSize
	FootLimitRightPosition=ballPosition-TransversalVector*.05*LegSize
	
	
	RMObjLookXAtPoint legPoint (kneePosition-legPosition)
	RMObjLookXAtPoint kneePoint  (anklePosition-kneePosition)
	RMObjLookXAtPoint anklePoint  (ballPosition - anklePosition)
	RMObjLookXAtPoint ballPoint FrontVector
	RMObjLookXAtPoint toePoint  FrontVector
	
	RMObjLookXAtPoint FootLimitBackPoint FrontVector
	RMObjLookXAtPoint FootLimitLeftPoint FrontVector
	RMObjLookXAtPoint FootLimitRightPoint FrontVector
	
	legPoint.position=legPosition
	kneePoint.position=kneePosition
	anklePoint.position=anklePosition
	ballPoint .position=ballPosition
	toePoint.position=toePosition
	
	FootLimitBackPoint.position=FootLimitBackPosition
	FootLimitLeftPoint.position=FootLimitLeftPosition
	FootLimitRightPoint.position=FootLimitRightPosition
	
	anklePoint.parent=kneePoint
	kneePoint.parent=legPoint
	toePoint.parent=ballPoint
	ballPoint.parent=anklePoint
	
	FootLimitBackPoint.parent=ballPoint
	FootLimitLeftPoint.parent=ballPoint
	FootLimitRightPoint.parent=ballPoint
	
	return legPoint
	
)

--RMCreateLegPoints [30,0,0] [0,0,-1] [0,-1,0] 100 "LF"
--RMCreateLegPoints [-30,0,0] [0,0,-1] [0,-1,0] 100 "RH"
