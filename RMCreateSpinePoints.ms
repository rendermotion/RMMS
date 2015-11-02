ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMNameConvention.ms")

fn RMCreateSpinePoints Origin DirectionVector SpineLength=
	(
		DirectionVector=normalize DirectionVector
		numberOfSpineBones=5
		spinePointArray=#()
		for spinePointCount=1 to numberOfSpineBones do
			(
			append spinePointArray (point name:(RMUniqueName "Character01_MD_Spine_pnt_rfr") size:(SpineLength/10))
			spinePointArray[spinePointCount].position=(Origin+(DirectionVector*((SpineLength/numberOfSpineBones)*spinePointCount)))
			RMObjLookXAtPoint spinePointArray[spinePointCount]  (DirectionVector)
			if (spinePointCount>1) do
				spinePointArray[spinePointCount].parent=spinePointArray[spinePointCount-1]
			)
		append spinePointArray (point name:(RMUniqueName "Character01_MD_Pelvis_pnt_rfr") size:(SpineLength/10))
		spinePointArray[spinePointArray.count].position=Origin
		RMObjLookXAtPoint spinePointArray[spinePointArray.count]  (DirectionVector*-1)
		spinePointArray[spinePointArray.count].parent=spinePointArray[1]
		RotacionEuler=eulerangles 90 0 0
		in coordsys local rotate spinePointArray[1] RotacionEuler
		
		return spinePointArray
	)

--RMCreateSpinePoints [0, 0, 0] [0, 0, 1] 100

