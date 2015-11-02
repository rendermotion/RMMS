fn RMSceneTurbosmoothEnabled  enabled:true=(
	for i in objects do
	(
		if i.modifiers[#Turbosmooth]!=undefined do
		(
			i.modifiers[#Turbosmooth].enabled=enabled
		)
	)
)	
fn RMTurbosmoothOnlyInRender =(
for i in objects do
(
	if i.modifiers[#Turbosmooth]!=undefined do
	(
		a=i.modifiers[#Turbosmooth].iterations
		i.modifiers[#Turbosmooth].iterations=0
		i.modifiers[#Turbosmooth].useRenderIterations=TRUE 
		b=i.modifiers[#Turbosmooth].renderIterations
		if a >0 then
			i.modifiers[#Turbosmooth].renderIterations=a
		else
			if b==0 do 
				i.modifiers[#Turbosmooth].renderIterations=2
	)
 )
)

fn RMClearCompactMaterialLibrary=(
	for n=1 to meditMaterials.count do 
		meditMaterials[n]=Standardmaterial()
)

fn RMCleareSlateMaterial=(
	NumViews=sme.GetNumViews()
	for i = 1 to NumViews do 
		sme.DeleteView i False
	)

fn RMClearVariables Type:"All"=(
	if Type=="All" then
		(
		renderers.current.environment_gi_on=false
		renderers.current.environment_gi_map=undefined
		renderers.current.environment_rr_on=false
		renderers.current.environment_rr_map=undefined
		renderers.current.environment_refract_on=false
		renderers.current.environment_refract_map=undefined
		renderers.current.output_splitfilename=""
		sme.GetNumViews()
		rendOutputFilename=""
		rendSaveFile=false
		)
	if Type=="Output" then
		(
			renderers.current.output_splitfilename=""
			rendOutputFilename=""
		)
	)
	
fn RMClearEmptyLayers=(
	defaultLayer=LayerManager.getLayer 0
	defaultLayer.current=TRUE
	NLayers=LayerManager.count
	for i=1 to NLayers-1 do 
		(
		LayerToDelete=LayerManager.getLayer (NLayers-i)
		LayerManager.deleteLayerByName LayerToDelete.name
		)
	)

fn RMReimportInNewScene=(
	FileFUllName=maxFilePath+ maxFileName
	resetMaxFile #noPrompt
	mergeMAXFile  FileFUllName
	saveMaxFile     FileFUllName
	)
