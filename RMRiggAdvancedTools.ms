ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMRiggTools.ms")

fn RMTwistBones TwistBone NumberOfTB:3=
	(
		if TwistBone.Children.count!=0 do
		(
			PuntoInicial=TwistBone.position
			PuntoFinal=TwistBone.children[1].position
			TwistBoneArray=RMCreateBonesBetweenPoints PuntoInicial PuntoFinal TwistBone.dir NumberOfTB
			
			RMAsigntoLayer "SkinedBones" TwistBoneArray AvoidNub:TRUE
			 
			
			MakeStretchyBones TwistBoneArray
			TwistPoint=RMCreateChildPoint #(TwistBone)
			TwistPoint.name=uniquename("TwistPoint")
			TwistBoneArray[1].parent=TwistPoint
			
			TwistCntrlPntOrig=RMCreateChildPoint #(TwistBone)
			TwistCntrlPntOrig.name=uniquename("TwistControlOrigin")
			
			TwistCntrlPntEnd=RMCreateChildPoint #(TwistBone)
			TwistCntrlPntEnd.name=uniquename("TwistControlEnd")
			in coordsys local move TwistCntrlPntEnd [((distance PuntoInicial PuntoFinal)*(NumberOfTB-1)/NumberOfTB),0,0]
			
			for n=2 to  TwistBoneArray.count do
				paramWire.connect TwistBone.children[1].position.controller[#X_Position]   TwistBoneArray[n].position.controller[#X_Position] "X_Position/3"
			
			--RMAttachToPoints TwistBoneArray[1] TwistBoneArray[3] TwistBoneArray[2] flag:2
			upNode1=RMLookAtConstraint TwistCntrlPntOrig TwistBone.children[1] Axis:"Y" UpNodeValue:-1
			upNode2=RMLookAtConstraint TwistCntrlPntEnd TwistBone.children[1] Axis:"Y" UpNodeValue:-1
			for n=1 to NumberOfTB do
				(
				  RMAttachToPoints   TwistCntrlPntOrig TwistCntrlPntEnd  TwistBoneArray[n] flag:2 weightNeg:(1.0-(n-1.0)/(NumberOfTB-1.0)) weightPos:((n-1.0)/(NumberOfTB-1.0)) wireWeight:False
				)
			if TwistBone.parent != undefined do 
				upNode1.parent=TwistBone.parent
			upNode2.parent=TwistBone
			--Regresa 
				-- Los Punos que controlan el Twist
				--Los Upnodes de Los puntos que controlan el Twist
				-- El origen de los twistBones
			return #(#(TwistCntrlPntOrig,TwistCntrlPntEnd),#(upNode1,upNode2),TwistCntrlPntOrig)
		)
	)
	
fn RMlink2Bones Point01 Point02  Bone01 Bone02=
(
	IKMAnip=IKSys.ikChain Bone01 Bone02 "IKHISolver"
	IKMAnip.parent=Point02

	Bone02.position.x_position.controller=float_script()
	Bone02.position.x_position.controller.AddNode "Root" Point01
    Bone02.position.x_position.controller.AddNode "Leaf" Point02
	Bone02.position.x_position.controller.script = 
	"a=in coordsys world Root.position \n"+
	"b=in coordsys world Leaf.position \n"+
	"(distance a b)"
)

fn RMStrechyChain ArreglodePuntos=(
		
	ArreglodeHuesos=RMCreateBonesatPoints ArreglodePuntos
	MakeStretchyBones ArreglodeHuesos
	Cuenta=1
	for Cuenta=1 to  (ArreglodeHuesos.count-1) do
	(
		RMlink2Bones ArreglodePuntos[Cuenta] ArreglodePuntos[Cuenta+1] ArreglodeHuesos[Cuenta] ArreglodeHuesos[Cuenta+1]
	)
)

fn RMCreateWaveFunction  Arreglo ControlWave =
(
	WaveAttributes=attributes WaveParamGeneral
	(
		parameters WaveParam rollout:WaveParamRollout
		(
			Phase type:#float ui:PhaseSpn
			Amplitud type:#float ui:AmpSpn
			WaveLenght type:#float ui:WaveLenSpn
			--Decay type:#float ui:DecaySpn
		)
		rollout WaveParamRollout "ControlOnda"
		(
			group "Controles Del Pie"
			(
				spinner PhaseSpn "Phase" range:[-1000, 1000,0]
				spinner AmpSpn "Amplitud" range:[0, 1000,100]
				spinner WaveLenSpn "Wave Len" range:[0, 1000,100]
				--spinner DecaySpn "Decay"
			)
		)
	)
	
	BaseLine=RMCreateLineAtHierarchy Arreglo TRUE
	Puntos3= RMIKControlMod BaseLine
	RMParentArrays Arreglo Puntos3
	PuntosEnLinea=RMCreatePointsAtShape  BaseLine 20 follow:TRUE
	arregloDePuntos=#()
	for i in PuntosEnLinea do 
	(
		NewPoint=RMCreateChildPoint  #(i)
		append arregloDePuntos NewPoint
	)
	print arregloDePuntos.count
	
	if ControlWave.modifiers[#AttributeHolder]!= undefined  then
			custAttributes.add ControlWave.modifiers[#AttributeHolder] WaveAttributes
	else 
	(	
		AttrHold=EmptyModifier()
		addmodifier ControlWave AttrHold
		custAttributes.add ControlWave.modifiers[#AttributeHolder] WaveAttributes
	)
	
	ControlWave.scale.controller=scale_script()
	ControlWave.scale.controller.addTarget "Amplitud" ControlWave.modifiers[#AttributeHolder].WaveParamGeneral[#Amplitud]
	ControlWave.scale.controller.addTarget "LongitudDeOnda" ControlWave.modifiers[#AttributeHolder].WaveParamGeneral[#WaveLenght]
	ControlWave.scale.controller.addTarget "Fase" ControlWave.modifiers[#AttributeHolder].WaveParamGeneral[#Phase]
	--ControlWave.scale.controller.addTarget "Decaimiento" ControlWave.modifiers[#AttributeHolder].WaveParamGeneral[#Decay]	
	print arregloDePuntos
	StringArreglodePuntos=RMCreateStringArray arregloDePuntos
	
	ControlWave.scale.controller.script = "Puntos="+ StringArreglodePuntos+"\n"+
		"NdePuntos=Puntos.count\n"+
		"	FactorDec=1.0/NdePuntos\n"+
		"	LoopNumber=0\n"+
		"	DistanciaEntrePuntos=2.5\n"+
		"	for i in Puntos do\n"+
		"	(\n"+
		"		if LongitudDeOnda!= 0 do \n"+
		"		(\n"+
		"			in coordsys parent Puntos[LoopNumber+1].position.y = LoopNumber*FactorDec*Amplitud*sin((2*pi/LongitudDeOnda)* (LoopNumber*DistanciaEntrePuntos)-Fase)\n"+
		"			in coordsys parent Puntos[LoopNumber+1].position.x = LoopNumber*FactorDec*Amplitud*sin((2*pi/LongitudDeOnda)* (LoopNumber*DistanciaEntrePuntos)-Fase-180)\n"+
		"		)\n"+
		"	LoopNumber=LoopNumber+1\n"+
		")\n"+
		"[1,1,1]"
		
	RMStrechyChain arregloDePuntos
)

fn RMSpaceSwitcCreator LinkedObject  Space01  Space02 ControlLink=
	(
		SpaceSwitchAttr=attributes SpaceSwitch
		(
			Parameters Memory rollout:Picker
			(
				LinkedItem  Type:#node tabSizeVariable:TRUE
				LinkItems  Type:#nodeTab tabSizeVariable:TRUE 
				LinkNames Type:#stringTab tabSizeVariable:TRUE
				LinkInfo Type:#stringTab tabSizeVariable:TRUE
			)
			rollout Picker "LinkControls" width:168 height:368
			(
				fn convierte=
					(
						LinkNames=#()
						for i in LinkItems do
							append LinkNames i.name
						return LinkNames
					)
				fn GetArrayNum arreglo cadena =
					(
						f=0;
						n=0;
						for i in arreglo do 
						(
							n=n+1;
							if i==cadena do 
								f=n;
						)
						return f
					)
				fn rewriteinfo=
				(
					NumTargets=LinkedItem.rotation.controller.getNumTargets()
					LinkInfo=#()
					numWeightKeys=LinkedItem.rotation.controller.weight[1].controller.keys.count
					for WeightKeys=1 to numWeightKeys do
						for n=1 to NumTargets do 
							(
								if LinkedItem.rotation.controller.weight[n].controller.keys[WeightKeys].value > 0 then  
									(   currentNode=LinkedItem.rotation.controller.getNode n
										append LinkInfo (((LinkedItem.rotation.controller.weight[n].controller.keys[WeightKeys].time)as string)+"  "+currentNode.name)
									)
							) 
					return LinkInfo
				)
				listbox Padres "Objects" pos:[20,5] width:120 height:5  items:(LinkNames as array)
				button BtnLink "LinkToObject" pos:[32,100] width:104 height:24 toolTip:"Link an object  in the current Frame"
				button BtnDelLnk "DeleteLink" pos:[32,130] width:104 height:24 toolTip:"Deletes the selected link Key frame"
				groupBox grp1 "Frame  Linked Object" pos:[17,160] width:136 height:300
				listbox InfoTxt "" pos:[24,175] width:120 height:20  items:(LinkInfo as array)
				
				on BtnDelLnk pressed do
					(  
						NumTargets=LinkedItem.rotation.controller.getNumTargets()
					  	for targetN=1 to NumTargets do
								if InfoTxt.selection!=0 do
									deleteKey   LinkedItem.rotation.controller.weight[targetN].controller   InfoTxt.selection
						InfoTxt.items=(rewriteinfo())as array
					)
					
				on BtnLink pressed do
				(
				 if (Padres.selection != 0) do
					(
					for LinkedNode=1 to LinkedItem.rotation.controller.weight.count do
						(
							addNewKey LinkedItem.rotation.controller.weight[LinkedNode].controller currentTime #select
							
							for oneKey=1 to  LinkedItem.rotation.controller.weight[LinkedNode].controller.keys.count do
							(
								if LinkedItem.rotation.controller.weight[LinkedNode].controller.keys[oneKey].time==currentTime do
								(
									if 	(LinkedItem.rotation.controller.getNode LinkedNode) == LinkItems[Padres.selection] then
												(
													LinkedItem.rotation.controller.weight[LinkedNode].controller.keys[oneKey].value=100
													
												)
										else 
												LinkedItem.rotation.controller.weight[LinkedNode].controller.keys[oneKey].value=0
								)
							)
						)
					InfoTxt.items=(rewriteinfo())as array
					)

				)
				on Picker open do 
					(
						if LinkItems.count==0 do 
							(
								for i=1 to (LinkedItem.rotation.controller.weight.count) do
									append LinkItems (LinkedItem.rotation.controller.getNode i)
							)
						NItem=LinkItems.count
						while(NItem>0)do
						(
							if LinkItems[NItem]==undefined do 
									deleteitem LinkItems NItem
							NItem=NItem-1
						)
						Padres.items=(convierte() as array)
						InfoTxt.items=(rewriteinfo())as array
					)
			)
		)
	OrientConst=Orientation_constraint()
	LinkedObject.rotation.controller=OrientConst
	OrientConst.appendTarget Space01 100
	OrientConst.appendTarget Space02 0
	LinkedObject.rotation.controller.weight[1].controller=Bezier_Float()
	LinkedObject.rotation.controller.weight[2].controller=Bezier_Float()
	if ControlLink.modifiers[#AttributeHolder]!= undefined then 
		(
			AttributeHolder=ControlLink.modifiers[#AttributeHolder]
		)
	else
		(
			AttributeHolder=EmptyModifier()
			addmodifier  ControlLink AttributeHolder
		)
	CustAttributes.add  AttributeHolder SpaceSwitchAttr
	ControlLink.modifiers[#AttributeHolder].SpaceSwitch.LinkedItem=LinkedObject
	)



				
