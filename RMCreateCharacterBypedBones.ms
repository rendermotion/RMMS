ScriptPath="\\\\server\\Alumnos\\Rigging\\Recursos\\Includes\\"
fileIn (ScriptPath+"RMRiggAdvancedTools.ms")
fileIn (ScriptPath+"\\AutoRigg\\RMHeadBones.ms")
fileIn (ScriptPath+"\\AutoRigg\\RMFeetBones.ms")
fileIn (ScriptPath+"\\AutoRigg\\RMHandBones.ms")
fileIn (ScriptPath+"\\AutoRigg\\RMArmBones.ms")
fileIn (ScriptPath+"\\AutoRigg\\RMLegBones.ms")
fileIn (ScriptPath+"\\AutoRigg\\RMSpineBones.ms")

fn RMCreateFullRigg =(

	max create mode
	disableSceneRedraw()
	undo off 
	(
		/*******************GetReferencePoints********************/

		--SpineReferencePoints
		PointSpineArray=#()
		append PointSpineArray (getNodeByName  "Character01_MD_Spine_pnt_rfr")
		append PointSpineArray (getNodeByName  "Character01_MD_Spine1_pnt_rfr")
		append PointSpineArray (getNodeByName  "Character01_MD_Spine2_pnt_rfr")
		append PointSpineArray (getNodeByName  "Character01_MD_Spine3_pnt_rfr")
		append PointSpineArray (getNodeByName  "Character01_MD_Spine4_pnt_rfr")
		
		PelvisPoint=getNodeByName "Character01_MD_Pelvis_pnt_rfr"
		
		--Arm ReferencePoints
		RHclavicle=getNodeByName  "Character01_RH_clavicle_pnt_rfr"
		RHshoulder=getNodeByName  "Character01_RH_shoulder_pnt_rfr"
		RHelbow=getNodeByName  "Character01_RH_elbow_pnt_rfr"
		RHwrist=getNodeByName  "Character01_RH_wrist_pnt_rfr"
		RHPalmNode=getNodeByName  "Characte01_RH_Palm_pnt_rfr"
		
		
		LFclavicle=getNodeByName  "Character01_LF_clavicle_pnt_rfr"
		LFshoulder=getNodeByName  "Character01_LF_shoulder_pnt_rfr"
		LFelbow=getNodeByName  "Character01_LF_elbow_pnt_rfr"
		LFwrist=getNodeByName  "Character01_LF_wrist_pnt_rfr"
		LFPalmNode=getNodeByName  "Characte01_LF_Palm_pnt_rfr"
		
		--LegReferencePoints
		RHleg=getNodeByName  "Character01_RH_leg_pnt_rfr"
		RHknee=getNodeByName  "Character01_RH_knee_pnt_rfr"
		RHankle=getNodeByName  "Character01_RH_ankle_pnt_rfr"
		RHAnkle=getNodeByName  "Character01_RH_ankle_pnt_rfr"
		
		LFleg=getNodeByName  "Character01_LF_leg_pnt_rfr"
		LFknee=getNodeByName  "Character01_LF_knee_pnt_rfr"
		LFankle=getNodeByName  "Character01_LF_ankle_pnt_rfr"
		LFAnkle=getNodeByName  "Character01_LF_ankle_pnt_rfr"
		
		 
		--GetHeadAndJawReference Points
		PointHeadArray=#()
		append PointHeadArray (getNodeByName "Character01_MD_neck_pnt_rfr")
		append PointHeadArray (getNodeByName"Character01_MD_head_pnt_rfr")
		append PointHeadArray (getNodeByName"Character01_headTip_ball_pnt_rfr")
		
		PointJawArray=#()

		append PointJawArray (getNodeByName"Character01_MD_jaw_pnt_rfr")
		append PointJawArray (getNodeByName"Character01_MD_JawTip_pnt_rfr")
		
		
		--**************************Create MainControls*********************************	
		MainSize=distance RHleg PointSpineArray[1]
		SpineMaster=RMCreateChildPoint PointSpineArray[1] parented:false name:"Character01_MD_MainSpine_pnt_rig" 
		MainCOGControl=RMCreateRiggControl PointSpineArray[1] name:"Character01_MD_COG_ctrl_rig" axis:"X" size:(MainSize*3) JustTheControl:TRUE
		MainFullControl= RMCreateRiggControl PointSpineArray[1] name:"Character01_MD_FullControl_ctrl_rig" axis:"X" size:(MainSize*5) JustTheControl:TRUE
		(MainFullControl.parent).position.z=0
		(MainCOGControl.parent).parent=MainFullControl
		
		
		--**************************Create SPine*********************************	
		SpineReturned = RMRiggCreateSpine PointSpineArray PelvisPoint
		--return #(SpineControls,PelvisControls,SpineBones,PelvisBones)	
		
		--**************************Create Arms*********************************
		RHArmControlsAndBones  =  RMRiggCreateArmBones RHclavicle RHshoulder RHelbow RHwrist
		LFArmControlsAndBones  =  RMRiggCreateArmBones LFclavicle LFshoulder LFelbow LFwrist
		--return #(LimbControl,FullArmOrigin,ClavicleControl,WorldOriented,TorsoOriented,(PoleVector)ArmStretchControls[2],(LastBone)RiggBones[4], UpNodedelTwistdeMuñeca)
		
		RHHandControlsAndBones = RMRiggHandBones RHPalmNode
		LFHandControlsAndBones = RMRiggHandBones LFPalmNode
		
		--return #(FullHandControl , FullHandPoint)
		--MANODERECHA
				LinkWristPointName=RMSetFromName RHwrist.name 4 "pnt"
				LinkWristPointName=RMSetFromName LinkWristPointName 3 "WristLink"
				LinkWristPointName=RMSetFromName LinkWristPointName 5 "rig"
				
				RHWristLinkedPoint=RMCreateChildPoint RHArmControlsAndBones[1] name:LinkWristPointName
				
				RHHandControlsAndBones[1].parent=RHArmControlsAndBones[1]
				RMParentConstraint  RHWristLinkedPoint RHHandControlsAndBones[2]
				RHHandControlsAndBones[2].parent=RHArmControlsAndBones[7]--Emparenta los Huesos de la mano
				RHArmControlsAndBones[8].parent=RHHandControlsAndBones[2]--Eparenta el Twist del brazo a la muñeca
				in coordsys parent RHArmControlsAndBones[8].position=[0,0,0]
				in coordsys Local move RHArmControlsAndBones[8] [0,0,10]
		
				
		--MANOIZQUIERDA
				LinkWristPointName=RMSetFromName LFwrist.name 4 "pnt"
				LinkWristPointName=RMSetFromName LinkWristPointName 3 "WristLink"
				LinkWristPointName=RMSetFromName LinkWristPointName 5 "rig"
				
				LFWristLinkedPoint=RMCreateChildPoint LFArmControlsAndBones[1] name:LinkWristPointName
				
				LFHandControlsAndBones[1].parent =LFArmControlsAndBones[1]
				RMParentConstraint  LFWristLinkedPoint LFHandControlsAndBones[2]
				LFHandControlsAndBones[2].parent=LFArmControlsAndBones[7]--Emparenta los Huesos de la mano
				LFArmControlsAndBones[8].parent=LFHandControlsAndBones[2]--Eparenta el Twist del brazo a la muñeca
				in coordsys parent LFArmControlsAndBones[8].position=[0,0,0]
				in coordsys Local move LFArmControlsAndBones[8] [0,0,10]
					
	--**************************Create Leg*********************************
		RHLegControls=RMRiggCreateLegBones RHleg RHknee RHankle
		LFLegControls=RMRiggCreateLegBones LFleg LFknee LFankle
		--return #(LegOrigin,LimbControl,LegControls[2],LastHierarchyBone,UpNodeTwistBoneFeet)
			
		RHFeetControl=getNodeByName"Character01_RH_leg_ctr_IK"
		RHFeetControlsAndBones=RMRiggCreateFootBones RHAnkle RHFeetControl

		LFFeetControl=getNodeByName"Character01_LF_leg_ctr_IK"
		LFFeetControlsAndBones=RMRiggCreateFootBones LFAnkle LFFeetControl
		
	--*************************Create Head*********************************

		FullHeadArray=RMCreateHeadBones  PointHeadArray jawPoints:PointJawArray
		
		--return #(HeadControls,FullHeadBoneOrigin,WorldOriented,TorsoOriented)
		
		--ArmControlsAndBones[1].parent = SpineReturned[1][SpineReturned[1].count]
		
	--*************************LigaEmparentamientos*********************************
	
		--((FullHeadArray[1][1]).parent).parent=SpineReturned[1][SpineReturned[1].count] --Emparenta Controles de Cabeza
		
		FullHeadArray[2].parent=SpineReturned[3][SpineReturned[3].count]--Emparenta Huesos
		
		ObjName=RMGetFromName FullHeadArray[2].name 3
		ObjName=RMSetFromName FullHeadArray[2].name 3 (ObjName+"Link")
		ObjName=RMSetFromName ObjName 4 "pnt"
		LinkedPointToNeckBone=RMCreateChildPoint FullHeadArray[2] name:ObjName
		RMParentConstraint  FullHeadArray[2] LinkedPointToNeckBone
		LinkedPointToNeckBone.parent=SpineReturned[1][SpineReturned[1].count]
		((FullHeadArray[1][1]).parent).parent=LinkedPointToNeckBone
		
		
		FullHeadArray[3].parent=MainFullControl  -- Emparenta World Oriented Point
		FullHeadArray[4].parent=SpineReturned[3][SpineReturned[3].count] --Emparenta SpineOriented Point

	--RIGHTPARENTING
				RHArmControlsAndBones[2].parent = SpineReturned[3][SpineReturned[3].count] --Emparenta Origen del Brazo Huesos
				(RHArmControlsAndBones[3].parent).parent = SpineReturned[1][SpineReturned[1].count] --Emparenta Control de Clavicula
				RHArmControlsAndBones[4].parent=MainFullControl --Emparenta worldOriented
				RHArmControlsAndBones[5].parent =SpineReturned[3][SpineReturned[3].count] --Emparenta SpineOriented Point
				(RHArmControlsAndBones[6].parent).parent= SpineReturned[1][SpineReturned[1].count] --Emparenta el Pole Vector
				
				RHLegControls[5].parent=RHFeetControlsAndBones[2]
				in coordsys parent RHLegControls[5].position=[0,0,0]
				in coordsys local move RHLegControls[5] [0,-10,0]
				RHLegControls[5].parent=RHFeetControlsAndBones[2]
				
				RHFeetControlsAndBones[2].parent=RHLegControls[1]--Emparento el origen del pie con el Origen de La pierna
				
				RHLegControls[1].parent=SpineReturned[4][2]	--LegBones
				(RHLegControls[2].parent).parent=MainFullControl	--FeetControl
				(RHLegControls[3].parent).parent=RHLegControls[2].parent	--PoleVector
	--LEFTPARENTING
				LFArmControlsAndBones[2].parent = SpineReturned[3][SpineReturned[3].count] --Emparenta Origen del Brazo Huesos
				(LFArmControlsAndBones[3].parent).parent = SpineReturned[1][SpineReturned[1].count] --Emparenta Control de Clavicula
				LFArmControlsAndBones[4].parent=MainFullControl --Emparenta worldOriented
				LFArmControlsAndBones[5].parent =SpineReturned[3][SpineReturned[3].count] --Emparenta SpineOriented Point
				(LFArmControlsAndBones[6].parent).parent= SpineReturned[1][SpineReturned[1].count] --Emparenta el Pole Vector

				LFLegControls[5].parent=LFFeetControlsAndBones[2]
				in coordsys parent LFLegControls[5].position=[0,0,0]
				in coordsys local move LFLegControls[5] [0,-10,0]
				LFLegControls[5].parent=LFFeetControlsAndBones[2]
				
				LFFeetControlsAndBones[2].parent=LFLegControls[1]--Emparento el origen del pie con el Origen de La pierna
				
				LFLegControls[1].parent=SpineReturned[4][2]	--LegBones
				(LFLegControls[2].parent).parent=MainFullControl	--FeetControl
				(LFLegControls[3].parent).parent=LFLegControls[2].parent	--PoleVector
		
		RMParentConstraint MainCOGControl SpineMaster
		
		(SpineReturned[3][1].parent).parent=SpineMaster
		(SpineReturned[4][1].parent).parent=SpineMaster
		(SpineReturned[1][1].parent).parent=MainCOGControl
		(SpineReturned[2][1].parent).parent=MainCOGControl

	)
	enableSceneRedraw()
)


	
