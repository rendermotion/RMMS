ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMNameConvention.ms")
filein (ScriptPath+"RMRiggMath.ms")

fn RMCreateHeadRefPoints Origin DirectionVector FrontVector HeadSize=
	(
		LegPointsArray=#()
		TransversalVector=normalize (cross DirectionVector FrontVector)
		FrontVector=normalize (cross TransversalVector DirectionVector)
		
		neckPoint=point name:"Character01_MD_neck_pnt_rfr" Box:on Cross:off size:(HeadSize*.1) centermarker:on
		headPoint =point name:"Character01_MD_head_pnt_rfr" Box:on Cross:off size:(HeadSize*.1) centermarker:on
		jawPoint=point name:"Character01_MD_jaw_pnt_rfr"  Box:on Cross:off size:(HeadSize*.1) centermarker:on
		headTipPoint=point name:"Character01_headTip_ball_pnt_rfr" Box:on Cross:off size:(HeadSize*.1) centermarker:on
		jawTipPoint=point name:"Character01_MD_JawTip_pnt_rfr" Box:on Cross:off size:(HeadSize*.1) centermarker:on
		
		neckPosition=Origin
		headPosition=Origin+DirectionVector*HeadSize*.8+FrontVector*.1*HeadSize
		headTipPosition=headPosition+DirectionVector*HeadSize*.5
		jawPosition=headPosition-DirectionVector*HeadSize*.25+FrontVector*.2*HeadSize
		jawTipPosition=headPosition-DirectionVector*HeadSize*.25+FrontVector*.5*HeadSize
		
		neckPoint.position=neckPosition
		headPoint.position=headPosition
		headTipPoint.position=headTipPosition
		jawPoint.position=jawPosition
		jawTipPoint.position=jawTipPosition
		
		RMObjLookXAtPoint  jawPoint (jawTipPoint.position-jawPoint.position)
		RMObjLookXAtPoint  jawTipPoint (jawTipPoint.position-jawPoint.position)
		RMObjLookXAtPoint  neckPoint (headPoint.position-neckPoint.position)
		RMObjLookXAtPoint  headPoint (headTipPoint.position-headPoint.position)
		RMObjLookXAtPoint  headTipPoint (headTipPoint.position-headPoint.position)
		
		headPoint.parent=neckPoint
		headTipPoint.parent=headPoint
		jawPoint.parent=headPoint
		jawTipPoint.parent=jawPoint
		return neckPoint
	)

--RMCreateHeadBones [0,0,0] [0,0,1] [0,-1,0] 10