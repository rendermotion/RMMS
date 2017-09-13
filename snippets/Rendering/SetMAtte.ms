--renderers.current.environment_gi_map=environmentMap
--useEnvironmentMap=false
rollout SetMatteProperties
	
fn RMremovematte CurrentSelection:(selection as array) =
(
	CurrentMat=#()
	for i in scenematerials do
		(
			if classof i == VrayMtlWrapper do 
				append CurrentMat i
		)
	--CurrentSelection=selection as array
	print CurrentMat
	for matx in CurrentMat do 
	(
		clearSelection()
		for objx in CurrentSelection do 
		(
			if objx.material==matx do
				selectMore objx
		)
		g=matx.baseMtl
		for i in selection do 
			i.material=g
	)		
)
fn RMsetmatte CurrentSelection:(selection as array)=
	(
		CurrentMat=#()
		for i in scenematerials do
			(if i != undefined and classof i != VRaySky and classof i != VRayHDRI do 
				append CurrentMat i
			)
		--CurrentSelection=selection as array
		print CurrentMat
		for matx in CurrentMat do 
		(
			clearSelection()
			for objx in CurrentSelection do 
			(
				if objx.material==matx do
					selectMore objx
			)
		g=VrayMtlWrapper()
		g.name=("Mtlwrapper_"+matx.name)
		g.baseMtl=matx
		g.matteSurface=true
		g.alphaContribution =-1
		g.matte_shadows=False
		g.matte_shadowsAffectAlpha=False
		g.matte_noGIOnOtherMattes=false
		g.matte_reflectionMultiplier=0
		g.matte_refractionMultiplier=0
		for i in selection do 
			i.material=g
		)
	)