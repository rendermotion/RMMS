fn RMRiggCreateSpine SpineRefPointArray PelvisPoint=(
	
	PelvisPoints=#(SpineRefPointArray[1],PelvisPoint)
	SpineBones=RMCreateBonesatPoints SpineRefPointArray

	RMAsigntoLayer "SkinedBones" SpineBones AvoidNub:TRUE
	
	PelvisBones=RMCreateBonesatPoints PelvisPoints
	
	RMAsigntoLayer "SkinedBones" PelvisBones AvoidNub:TRUE
	
	RMCreateParentPoint SpineBones[1] GuessName:True
	RMCreateParentPoint PelvisBones[1] GuessName:True
	SpineControls=RMCreateChainControl  SpineBones
	PelvisControls=RMCreateChainControl  PelvisBones
	
	return #(SpineControls,PelvisControls,SpineBones,PelvisBones)
	)