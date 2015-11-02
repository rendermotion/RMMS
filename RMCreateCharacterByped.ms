ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMCreateHeadPoints.ms")
filein (ScriptPath+"RMCreateLegPoints.ms")
filein (ScriptPath+"RMCreateSpinePoints.ms")
filein (ScriptPath+"RMCreateArmPoints.ms")

fn CreateBipedCharacter	Size FrontVector UpVector=(
	HeadSize= Size/8
	TransversalVector=normalize (cross FrontVector UpVector)
	HeadAndNeckSize=HeadSize*1.2
	LegSize=HeadSize*4
	ArmSize=HeadSize*2.8
	SpineSize=HeadSize*2.8
	
	SpineOrigin=RMCreateSpinePoints [0, 0, HeadSize*4] [0, 0, 1] SpineSize
	
	NeckOrigin=RMCreateHeadRefPoints [0, 0, HeadSize*4+SpineSize] [0,0,1] [0,-1,0] HeadAndNeckSize
	NeckOrigin.parent=SpineOrigin[SpineOrigin.count-1]
		
	ArmOriginRH=RMCreateArmPoints ([0, 0, HeadSize*4+SpineSize]+TransversalVector*HeadSize ) TransversalVector ArmSize    "RH"
	ArmOriginLF=RMCreateArmPoints ([0, 0, HeadSize*4+SpineSize]-TransversalVector*HeadSize )  -TransversalVector  ArmSize    "LF"
	
	ArmOriginLF.parent=SpineOrigin[SpineOrigin.count-1]
	ArmOriginRH.parent=SpineOrigin[SpineOrigin.count-1]
	
	LegOriginRH=RMCreateLegPoints (SpineOrigin[1].position+TransversalVector* HeadSize/2) (UpVector*-1) FrontVector LegSize "RH"
	LegOriginLF=RMCreateLegPoints (SpineOrigin[1].position-TransversalVector*HeadSize /2)  (UpVector*-1) FrontVector LegSize "LF"
	
	LegOriginLF.parent=SpineOrigin[1]
	LegOriginRH.parent=SpineOrigin[1]
	
	return SpineOrigin[1]
)

fn RMSymTransform Obj01 Obj02=
(
	Obj01Position=in coordsys parent Obj01.position
	Obj01Position=Obj01Position*[1,-1,1]
	
	Obj01Rotation=in coordsys parent Obj01.rotation
	
	Obj02Rotation = quatToEuler Obj01Rotation
	
	Obj02Rotation.x_rotation=Obj02Rotation.x_rotation*-1
	Obj02Rotation.y_rotation=Obj02Rotation.y_rotation*1
	Obj02Rotation.z_rotation=Obj02Rotation.z_rotation*-1
	
	Obj02.rotation=eulerAngles 0 0 0
	
	in coordsys parent Obj02.rotation=Obj02Rotation
		
	in coordsys parent Obj02.position=Obj01Position
)

fn RMMirrorPositionPoints=(
	for i in selection do
		(
		objSide1=i
		if (RMGetFromName objSide1.name 2) == "RH" then
			(
			objOpositeSide=execute("$"+(RMSetFromName objSide1.name 2 "LF"))
			RMSymTransform objSide1 objOpositeSide
			)
		else
			if (RMGetFromName objSide1.name 2) == "LF" then
				(
				objOpositeSide=execute("$"+(RMSetFromName objSide1.name 2 "RH"))
				RMSymTransform objSide1 objOpositeSide
				)
			else
			print ("No OpositeSide for object " +objSide1.name)
		
		)
	)


