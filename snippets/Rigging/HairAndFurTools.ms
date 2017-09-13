rollout HairAndFurRollout "Hair And Fur" width:193 height:237
(
	colorPicker TipColor "TipColor" pos:[38,11] width:90 height:31
	colorPicker RootColor "RootColor" pos:[31,44] width:97 height:31 color:(color 0 0 155)
	spinner SpnHue "Hue Variation" pos:[25,83] width:105 height:16
	spinner SpnValue "Value Variation" pos:[18,107] width:113 height:16 range:[0,100,0]
	spinner SpnSpecular "Specular" pos:[47,134] width:85 height:16 range:[0,100,0]
	spinner SpnGloss "SpnGloss" pos:[44,162] width:88 height:16 range:[0,100,0]
	colorPicker ClrSpecTint "Specular Tint" pos:[16,184] width:114 height:31 color:(color 0 0 155)
	
	on TipColor changed ColorValue do 
	(
		ObjSel=selection as array
		for i in ObjSel do
				if 	i.modifiers[#HairAndFur]!=undefined   do
							i.modifiers[#HairAndFur].MaterialTipColor=ColorValue
	)
	on RootColor changed ColorValue do 
	(
		ObjSel=selection as array
		for i in ObjSel do
				if 	i.modifiers[#HairAndFur]!=undefined   do
							i.modifiers[#HairAndFur].MaterialRootColor=ColorValue
	)
	on SpnHue changed SpinValue do
	(
		ObjSel=selection as array
		for i in ObjSel do
				if 	i.modifiers[#HairAndFur]!=undefined   do
							i.modifiers[#HairAndFur].MaterialHueVariation=SpinValue
	)
	on SpnValue changed SpinValue do
	(
		ObjSel=selection as array
		for i in ObjSel do
				if 	i.modifiers[#HairAndFur]!=undefined   do
							i.modifiers[#HairAndFur].MaterialSpecular=SpinValue
	)
	on SpnGloss changed SpinValue do
	(
		ObjSel=selection as array
		for i in ObjSel do
				if 	i.modifiers[#HairAndFur]!=undefined   do
							i.modifiers[#HairAndFur].MaterialGlossness=SpinValue
	)
	on ClrSpecTint changed ColorValue do 
	(
		ObjSel=selection as array
		for i in ObjSel do
				if 	i.modifiers[#HairAndFur]!=undefined   do
							i.modifiers[#HairAndFur].MaterialSpecTint=ColorValue
	)
	on HairAndFurRollout open do
	(
	ObjSel=selection as array
	print "Rollout Opened"
	if 	(ObjSel.count>=1) do
		if ObjSel[1].modifiers[#HairAndFur]!=undefined   do
			(print "entre al ciclo"
				HairAndFurFloater.rollouts[1].TipColor.color=ObjSel[1].modifiers[#HairAndFur].MaterialTipColor
				HairAndFurFloater.rollouts[1].RootColor.color=ObjSel[1].modifiers[#HairAndFur].MaterialRootColor
				HairAndFurFloater.rollouts[1].SpnHue.value=ObjSel[1].modifiers[#HairAndFur].MaterialHueVariation
				HairAndFurFloater.rollouts[1].SpnValue.value=ObjSel[1].modifiers[#HairAndFur].MaterialValueVariation
				HairAndFurFloater.rollouts[1].SpnSpecular.value=ObjSel[1].modifiers[#HairAndFur].MaterialSpecular
				HairAndFurFloater.rollouts[1].SpnGloss.value=ObjSel[1].modifiers[#HairAndFur].MaterialGlossness
				HairAndFurFloater.rollouts[1].ClrSpecTint.color=ObjSel[1].modifiers[#HairAndFur].MaterialSpecTint
			)	
	)
	on HairAndFurRollout close do
	(
		callbackItem = undefined
		gc light:true	
		print "GarbageCollector"
	)
)

fn SelectionChanged ev nd = (
 ObjSel=selection as array
	print "llamada Callback"
if 	(ObjSel.count>=1) do
		if ObjSel[1].modifiers[#HairAndFur]!=undefined   do
			(print "entre al ciclo"
				HairAndFurFloater.rollouts[1].TipColor.color=ObjSel[1].modifiers[#HairAndFur].MaterialTipColor
				HairAndFurFloater.rollouts[1].RootColor.color=ObjSel[1].modifiers[#HairAndFur].MaterialRootColor
				HairAndFurFloater.rollouts[1].SpnHue.value=ObjSel[1].modifiers[#HairAndFur].MaterialHueVariation
				HairAndFurFloater.rollouts[1].SpnValue.value=ObjSel[1].modifiers[#HairAndFur].MaterialValueVariation
				HairAndFurFloater.rollouts[1].SpnSpecular.value=ObjSel[1].modifiers[#HairAndFur].MaterialSpecular
				HairAndFurFloater.rollouts[1].SpnGloss.value=ObjSel[1].modifiers[#HairAndFur].MaterialGlossness
				HairAndFurFloater.rollouts[1].ClrSpecTint.color=ObjSel[1].modifiers[#HairAndFur].MaterialSpecTint
			)
)
global callbackItem = NodeEventCallback mouseUp:true delay:100 selectionChanged:SelectionChanged
global HairAndFurFloater= newrolloutfloater   "Edit HairAndFur" 150 250
addrollout  HairAndFurRollout HairAndFurFloater

