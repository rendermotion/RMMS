for i in scenematerials do 
	if classof i ==VrayMtl do
		(
		if i.reflection_useInterpolation==TRUE do
			i.reflection_useInterpolation==FALSE
		if i.refraction_useInterpolation==TRUE do
			i.refraction_useInterpolation==FALSE
		)