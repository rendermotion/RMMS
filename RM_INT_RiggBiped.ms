ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMCreateCharacterByped.ms")
filein (ScriptPath+"RMCreateCharacterBypedBones.ms")
filein (ScriptPath+"RMCreateCharacterByped.ms")
rollout BipedCharacter "BipedCharacter" width:197 height:187
(
	spinner spnCharHeight	"Height" pos:[15,15] width:80 height:16 range:[0,10000,500]
	button ButtonCreateReferencePoints "CreateReferencePoints" pos:[4,37] width:182 height:23 toolTip:""
	button ButtonMirrorLFToRH "Mirror LF to RH" pos:[6,70] width:88 height:23 toolTip:""
	button ButtonMirrorRHToLF "Mirror RH to LF" pos:[98,70] width:88 height:23 toolTip:""
	button ButtonCreateBiped "CreateBipedBones" pos:[8,101] width:178 height:23 toolTip:""
	
	on ButtonCreateReferencePoints pressed do
	(
		CreateBipedCharacter spnCharHeight.value [0,-1,0] [0,0,1]
	)
	on ButtonMirrorLFToRH pressed do
	(
		RMMirrorPositionPoints()
	)
	on ButtonMirrorRHToLF pressed do
	(
		RMMirrorPositionPoints()
	)
	on ButtonCreateBiped pressed do
	(
		RMCreateFullRigg()
	)
)
rollout BipedCharacterRigTools "Rig Tools" width:197 height:187 
	(
	button LegCreationButton "Leg Creation" pos:[4,37] width:182 height:23 toolTip:"Select leg, knee and ankle points in order and press the button "
	on LegCreationButton pressed do
		RMRiggCreateLegBones $[1] $[2] $[3]
	)

VentanaBiped = newRolloutFloater "Creation" 200 300
addRollout BipedCharacter VentanaBiped
addRollout BipedCharacterRigTools VentanaBiped



