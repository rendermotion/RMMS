
fn RMCreateHeadBones  HeadPoints jawPoints:undefined =(
	HeadBones=RMCreateBonesatPoints HeadPoints
	
	RMAsigntoLayer "SkinedBones" HeadBones AvoidNub:TRUE
	
	FullHeadBoneOrigin=RMCreateParentPoint HeadBones[1] GuessName:True
	HeadControls=RMCreateChainControl  HeadBones
	
	if  jawPoints != undefined do 
		(
		jawBones=RMCreateBonesatPoints jawPoints
			
		RMAsigntoLayer "SkinedBones" jawBones AvoidNub:TRUE
			
		JawStart=RMCreateParentPoint jawBones[1] GuessName:True
		JawStart.parent=HeadBones[2]
		)
		
	WorldOriented=RMCreateChildPoint HeadBones[1] parented:false name:"WorldOriented"
	TorsoOriented=RMCreateChildPoint HeadBones[1] parented:false name:"TorsoOriented"
	RMSpaceSwitcCreator FullHeadBoneOrigin WorldOriented TorsoOriented HeadControls[1]
	return #(HeadControls,FullHeadBoneOrigin,WorldOriented,TorsoOriented)
	)