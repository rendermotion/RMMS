ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"

fileIn  (ScriptPath+"RMNameConvention.ms")
fileIn  (ScriptPath+"RMRiggMath.ms")

fn RMcreateFingerPoints FingerOrigin DirectionVector FingerLength FingerName=(
	fingerPointsArray=#()
	for n=1 to 4 do 
		(
			append fingerPointsArray (point name:(FingerName+(n as string)) Box:on Cross:off size:(FingerLength*.3) centermarker:on)
			RMObjLookXAtPoint fingerPointsArray[n] DirectionVector
				
			if (n>1) do 
				fingerPointsArray[n].parent=fingerPointsArray[n-1]
		)
	fingerPointsArray[1].position=FingerOrigin
	DirectionVector=normalize (DirectionVector)
	fingerPointsArray[2].position=FingerOrigin+(DirectionVector*.5*FingerLength)
	fingerPointsArray[3].position=FingerOrigin+(DirectionVector*.75*FingerLength)
	fingerPointsArray[4].position=FingerOrigin+(DirectionVector*FingerLength)
	return fingerPointsArray
	)

fn RMcreateHandPoints OriginPoint DirectionVector HandSize Side=
	(
	DirectionVector=normalize DirectionVector
	TransvesalVector=normalize (cross DirectionVector [0,0,1])
	FingersOrigin=OriginPoint +(DirectionVector*.5*HandSize)
	FingerLenght=.5*HandSize
	Middle=RMcreateFingerPoints  FingersOrigin DirectionVector  FingerLenght "Middle"
	fistLenght=(.5*HandSize)*.8
	distanceBetwenFingers=fistLenght/3
	
	Palm=(point name:("Characte01_"+Side+"_Palm_pnt_rfr") Box:on Cross:off size:(HandSize*.4) centermarker:on)
		
	RMObjLookXAtPoint Palm DirectionVector
		
	Palm.position=OriginPoint 
	if Side=="RH" then
		(
		Ring=RMcreateFingerPoints  (FingersOrigin+(TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.9) "Ring"
		Pinky=RMcreateFingerPoints  (FingersOrigin+(TransvesalVector*distanceBetwenFingers*2)) DirectionVector  (FingerLenght*.6) "Pinky"
		Index=RMcreateFingerPoints  (FingersOrigin - (TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.8) "Index"
		Thumb=RMcreateFingerPoints  (OriginPoint - (TransvesalVector*distanceBetwenFingers)+DirectionVector*.5*.25) (DirectionVector-TransvesalVector)  FingerLenght "Thumb"
		)
	else
		(
		Ring=RMcreateFingerPoints  (FingersOrigin-(TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.9) "Ring"
		Pinky=RMcreateFingerPoints  (FingersOrigin-(TransvesalVector*distanceBetwenFingers*2)) DirectionVector  (FingerLenght*.6) "Pinky"
		Index=RMcreateFingerPoints  (FingersOrigin + (TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.8) "Index"
		Thumb=RMcreateFingerPoints  (OriginPoint +(TransvesalVector*distanceBetwenFingers)+DirectionVector*.5*.25) (DirectionVector + TransvesalVector)  FingerLenght "Thumb"
		)
		
		Middle[1].parent=Palm
		Ring[1].parent=Palm
		Pinky[1].parent=Palm
		Index[1].parent=Palm
		Thumb[1].parent=Palm
	
		RMRenamer Middle ("Characte01_"+Side+"_Middle_pnt_rfr")
		RMRenamer Ring ("Characte01_"+Side+"_Ring_pnt_rfr")
		RMRenamer Pinky ("Characte01_"+Side+"_Pinky_pnt_rfr")
		RMRenamer Index ("Characte01_"+Side+"_Index_pnt_rfr")
		RMRenamer Thumb ("Characte01_"+Side+"_Thumb_pnt_rfr")
		Return Palm
	)
/*
RMcreateHandPoints [1,1,1] [1,0,0] 100 "LF"
RMcreateHandPoints [-1,1,1] [-1,0,0] 100 "RH"
*/
	fn RMcreateToesPoints OriginPoint DirectionVector ToesSize Side=
	(
	DirectionVector=normalize DirectionVector
	TransvesalVector=normalize (cross DirectionVector [0,0,1])
	FingersOrigin=OriginPoint +(DirectionVector*.5*ToesSize )
	FingerLenght=.5*ToesSize 
	Middle=RMcreateFingerPoints  FingersOrigin DirectionVector  FingerLenght "Middle"
	fistLenght=(.5*ToesSize )*.8
	distanceBetwenFingers=fistLenght/3
	
	Palm=(point name:("Characte01_"+Side+"_Palm_pnt_rfr") Box:on Cross:off size:(ToesSize *.4) centermarker:on)
		
	RMObjLookXAtPoint Palm DirectionVector
		
	Palm.position=OriginPoint 
	if Side=="RH" then
		(
		Ring=RMcreateFingerPoints  (FingersOrigin+(TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.9) "Ring"
		Pinky=RMcreateFingerPoints  (FingersOrigin+(TransvesalVector*distanceBetwenFingers*2)) DirectionVector  (FingerLenght*.6) "Pinky"
		Index=RMcreateFingerPoints  (FingersOrigin - (TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.8) "Index"
		Thumb=RMcreateFingerPoints  (OriginPoint - (TransvesalVector*distanceBetwenFingers)+DirectionVector*.5*.25) (DirectionVector-TransvesalVector)  FingerLenght "Thumb"
		)
	else
		(
		Ring=RMcreateFingerPoints  (FingersOrigin-(TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.9) "Ring"
		Pinky=RMcreateFingerPoints  (FingersOrigin-(TransvesalVector*distanceBetwenFingers*2)) DirectionVector  (FingerLenght*.6) "Pinky"
		Index=RMcreateFingerPoints  (FingersOrigin + (TransvesalVector*distanceBetwenFingers)) DirectionVector  (FingerLenght*.8) "Index"
		Thumb=RMcreateFingerPoints  (OriginPoint +(TransvesalVector*distanceBetwenFingers)+DirectionVector*.5*.25) (DirectionVector + TransvesalVector)  FingerLenght "Thumb"
		)
		
		Middle[1].parent=Palm
		Ring[1].parent=Palm
		Pinky[1].parent=Palm
		Index[1].parent=Palm
		Thumb[1].parent=Palm
	
		RMRenamer Middle ("Characte01_"+Side+"_ToeMiddle_pnt_rfr")
		RMRenamer Ring ("Characte01_"+Side+"_ToeRing_pnt_rfr")
		RMRenamer Pinky ("Characte01_"+Side+"_ToePinky_pnt_rfr")
		RMRenamer Index ("Characte01_"+Side+"_ToeIndex_pnt_rfr")
		RMRenamer Thumb ("Characte01_"+Side+"_ToeThumb_pnt_rfr")
		Return Palm
	)
	
	
	
	
	
	
	
	
	
	
	
	