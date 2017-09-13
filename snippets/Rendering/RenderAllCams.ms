Dirpath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (Dirpath+"RMRiggMath.ms")
filein (Dirpath+"RMNetRenderTools.ms")
filein (Dirpath+"RMFile&pathTools.ms")
filein (Dirpath+"RMOptimizeScene.ms")


rollout RenderCamerasRollout "Render all Cameras" width:162 height:276
(
	checkbox WireRenderChk "WireRender" pos:[24,16] width:115 height:17 checked:true
	checkbox RegularRenderchk "RegularRender" pos:[24,32] width:115 height:17 checked:true
	button SendRenderBtn "Send Net Render" pos:[24,64] width:119 height:32
	multiListBox CameraListBox "Scene Cameras" pos:[16,104] width:136 height:20
	
	on SendRenderBtn pressed do
	(
		OutputPath= (MaxFilePath+"RenderOutput\\")
		makeDir OutputPath
		g=CameraListBox.selection
		CamsToRender=RMBitArrayToArray g
		if WireRenderChk.checked do 
		(
			RMStrippToRealPath()
			renderers.current.options_overrideMtl_on=true
			RMRenderAllCams OutputPath prefix:"wire" CamArray:CamsToRender
			renderers.current.options_overrideMtl_on=false
			RMStrippPath()
		) 
		if RegularRenderchk.checked do 
		(
			RMStrippToRealPath()
			renderers.current.options_overrideMtl_on=false
			RMRenderAllCams OutputPath CamArray:CamsToRender
			RMClearVariables Type:"Output"
			RMStrippPath()
		)
	)
)
RenderCamerasWindow=newrolloutfloater "Render Cameras" 200 430
addrollout RenderCamerasRollout RenderCamerasWindow

Objetos=(Cameras as array)
CamArray=#()
for i in Objetos do
	if (( (classof i) == VRayPhysicalCamera) or ((classof i) == Physical )) do 
		(
			append  CamArray i.name
			print i.name
		)
RenderCamerasRollout.CameraListBox.items=CamArray