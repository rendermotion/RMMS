ScriptPath="D:\\Development\\RMMS\\"
filein (ScriptPath+"RMRiggTools.ms")
filein (ScriptPath+"RMRiggAdvancedTools.ms")


rollout BoneToolsRollout "BoneTools" width:350 height:120
(
	button BnsAtPntsButton "Create Bones At Points" pos:[4,3] width:152 height:23
	
	on BnsAtPntsButton pressed do 
	(
		RMCreateBonesatPoints (selection as array)
	)
)

rollout UtilitiesRollout "Utilities" width:350 height:120
(
	button CreateLineAtPointsButton "Create Line At Hierarchy" pos:[4,3] width:152 height:23
	
	button CreatePoleVector "Pole Vector" pos:[6,35] width:148 height:27
	
	on CreateLineAtPointsButton pressed do
	(
		RMCreateLineAtHierarchy (selection as array) TRUE
	)
	on CreatePoleVector pressed do
	(
		Arreglo = selection as array 
		if Arreglo.count==3 do
			RMGetPoleVectorPoint Arreglo
	)
	
	
	
)
rollout ControlsRollout "Controls" width:350 height:120
(
	button CreateCircularControlButton "Create CircularControl" pos:[4,3] width:152 height:23
	
	
on CreateCircularControlButton pressed do 
	(
		controlRadius=10
		for i in selection do 
			RMCreateRiggControl i
	)
	
)
rollout HierarchyRollout "Hierarchy" width:350 height:120
(
	button ParentConstraintButton "Parent Constraint" pos:[4,3] width:152 height:23
	
	button AttachBetwenPointsButton "Attach" pos:[258,25] width:70 height:33
	
	button ParentPointButton "Parent Point Same Transform" pos:[4,30] width:152 height:23
	
	button ParentPointPositionButton "Parent Point Same Pos Only" pos:[4,60] width:152 height:23
	
	groupBox AttachGroup "Attach Between Points" pos:[165,3] width:170 height:68
	
	checkbox PositionChkBox "Position" pos:[172,24] width:69 height:17 checked:true
	checkbox OrientationChkBox "Orientation" pos:[172,45] width:78 height:17 checked:true
	
	--RMCreateParentPoint
	on ParentPointButton pressed do
	(
		RMCreateParentPoint (selection as Array)
	)
	
	on ParentPointButton pressed do
	(
		RMCreateParentPoint (selection as Array) SameOrientation:False
	)
	
	on ParentConstraintButton pressed do
	(
		SelectedObjects=selection as Array
		if SelectedObjects.count>=1 do
			for i =1 to  (SelectedObjects.count-1) do 
				RMParentConstraint SelectedObjects[SelectedObjects.count] SelectedObjects[i]
	)
	on AttachBetwenPointsButton pressed do
	(
	 SelectedObjects=selection as Array
		if SelectedObjects.count==3 do
		(
			if (PositionChkBox.checked==TRUE and OrientationChkBox.checked==FALSE) do
				RMAttachToPoints SelectedObjects[2] SelectedObjects[3] SelectedObjects[1] flag:1
			if (PositionChkBox.checked==FALSE and OrientationChkBox.checked==TRUE) do
				RMAttachToPoints SelectedObjects[2] SelectedObjects[3] SelectedObjects[1] flag:2
			if (PositionChkBox.checked==TRUE and OrientationChkBox.checked==TRUE) do 
				RMAttachToPoints SelectedObjects[2] SelectedObjects[3] SelectedObjects[1] flag:3
		)
	)
)

rollout GeometryResetRollout "Geometry" width:350 height:120
	(
		button ResetTransformMatrixButton "Reset TM" pos:[4,3] width:152 height:23
		button ResetTo0Button "Reset To 0" pos:[4,30] width:152 height:23
		
	on ResetTransformMatrixButton pressed do 
		(
			RMResetTransformMatrix (selection as array) KeepPosition:True
		)
	on ResetTo0Button pressed do 
		(
			RMResetTransformMatrix (selection as array) KeepPosition:False
		)
		
	)

rollout LigaParam "LinkRotation" width:273 height:111
(
	checkbox chkX "X" pos:[9,30] width:41 height:18 checked:true
	checkbox chkY "Y" pos:[50,30] width:29 height:18 checked:true
	checkbox chkZ "Z" pos:[86,30] width:30 height:17 checked:true

	label lbl1 "LinkAxis" pos:[15,11] width:54 height:17 
 
 
	button btn1 "Link" pos:[12,51] width:70 height:34 
 
 
	checkbox chkCC "Create Controller" pos:[118,28] width:106 height:21 checked:true
	spinner spnRad "Radius     :" pos:[123,53] width:101 height:16 range:[0,100,2]
	spinner spnThick "Thickness:" pos:[123,72] width:101 height:16 range:[0,100,1.1]

	on btn1 pressed do
	( if chkCC.checked==False then
		(
			theVar=selection[2]
			b=selection[1]
		)
		else 
		( 
			theVar=selection[1]
			b=RMCreateRiggControl selection[1] radius:spnRad.value Nombre:"control" Thickness:spnThick.value
			--(b.parent).parent=a.parent
		)
		
		if (chkX.checked==true) do 
					execute ("paramWire.connect $"+b.name+".rotation.controller[#X_Rotation] $"+theVar.name+".rotation.controller[#X_Rotation] \"X_Rotation + degtorad "+(( in coordsys gimbal theVar.rotation.x) as string)+" \" ")
		if (chkY.checked==true) do 
				execute ("paramWire.connect $"+b.name+".rotation.controller[#Y_Rotation] $"+theVar.name+".rotation.controller[#Y_Rotation] \"Y_Rotation + degtorad "+(( in coordsys gimbal theVar.rotation.y) as string)+" \" ")		
		if (chkZ.checked==true) do 
				execute ("paramWire.connect $"+b.name+".rotation.controller[#Z_Rotation] $"+theVar.name+".rotation.controller[#Z_Rotation] \"Z_Rotation + degtorad "+(( in coordsys gimbal theVar.rotation.z) as string)+" \" ")
	)
)

rollout FullRigg "Full Rigg" width:231 height:111
(
	button btnWaveFn "WaveSin" pos:[5,5] width:89 height:34 toolTip:"Selecciona una cadena de huesos en orden y al final el control"
	button StretchyIKBtn "StretchyIK" pos:[107,4] width:69 height:34 toolTip:"Selecciona dos huesos el inicial y el final presiona el boton para crear el IK"
	on btnWaveFn pressed do
	(
		Arreglo=selection as array
		ControlWave=Arreglo[Arreglo.count]
	    deleteItem Arreglo Arreglo.count
		CreateWaveFunction  Arreglo ControlWave
	)
	on StretchyIKBtn pressed do
	(
		RMStretchyIK $[1] $[2]
	)
)
VentanaLigaParam = newRolloutFloater "RiggTools" 350 500
addRollout GeometryResetRollout VentanaLigaParam
addRollout BoneToolsRollout VentanaLigaParam
addRollout UtilitiesRollout VentanaLigaParam
addRollout ControlsRollout VentanaLigaParam
addRollout HierarchyRollout VentanaLigaParam
addRollout LigaParam VentanaLigaParam
addRollout FullRigg VentanaLigaParam

