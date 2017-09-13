rollout SlicePlane "SlicePlane" width:180 height:112
(
	spinner NoSecciones "No de Secciones" pos:[29,11] width:111 height:16 type:#integer
	spinner DistanciaSP "Distancia" pos:[11,34] width:128 height:16 range:[0,100,0] enable:false type:#worldunits
	button Secciona "Secciona" pos:[33,59] width:90 height:28 
 
	HyperLink rm "www.rendermotion.com" pos:[14,92] width:111 height:15 address:"www.rendermotion.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181)
	
	checkbox Distancia "" pos:[145,36] width:15 height:14
	
	on Distancia changed NewValue do (
     if NewValue==false then(
		NoSecciones.enabled=true 
		DistanciaSP.enabled=false
		 )
	 else (
		NoSecciones.enabled=false
		DistanciaSP.enabled=true
		 )
	)		
	
	on Secciona pressed do
	(
		
		
		if ((selection as array).count !=1)  then 
			messagebox "selecciona un objeto y despues presiona el boton secciona"
		else
		(
			meshSelected = $
			minZ = meshSelected.min.z 
			maxZ = meshSelected.max.z
			numLevels=NoSecciones.value
			if Distancia.checked==false then
				delta = (maxZ - minZ) / (numLevels + 1) 
			else 
				if DistanciaSP.value!=0 then 
					delta=DistanciaSP.value
				else 
					delta=1
			for currentZ = minZ to maxZ by delta do 
				(
				s = section pos:[0, 0, currentZ]
				max views redraw 
				convertToSplineShape s 
				s.renderable = true 
				)
		)	
	)
)
rollout EditSplinesRollout "EditSplines" width:180 height:95
	 (
	 	spinner thickness "Thickness:" pos:[14,10] width:114 height:16
	 	checkbox EnableRender "Enable in Render" pos:[9,39] width:97 height:16
	 	checkbox EnableViewport "Enable in Viewport" pos:[9,59] width:118 height:16
	 	on thickness changed SpinValue do
	 	(
	 	for i in selection do
	 		if (i.category==#Splines or i.category==#shape)  do i.render_thickness=SpinValue
	 	)
	 	on EnableRender changed EnRendValue do
	 	(
	 	for i in selection do
	 		if ( i.category==#Splines or i.category==#shape)  do i.render_renderable=EnRendValue
	 	)
	 	on EnableViewport changed EnViewValue do
	 	(
	 	for i in selection do
	 		if (i.category==#Splines or i.category==#shape)  do i.render_displayRenderMesh=EnViewValue
	 	)
	hyperlink rm "www.diplomados3d.com" address:"www.diplomados3d.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181) align:#center pos:[14,78]
	)
VentanaSeccion = newRolloutFloater "Secciona" 180 245
addRollout  SlicePlane VentanaSeccion
addRollout EditSplinesRollout VentanaSeccion

c=SlicePlane.controls[2]
c.enabled = false
