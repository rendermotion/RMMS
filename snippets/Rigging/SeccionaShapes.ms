rollout SlicePlane "SlicePlane" width:162 height:80
(
	spinner NoSecciones  "No de Secciones" pos:[40,11] width:100 height:16 type: #integer
	button Secciona "Secciona" pos:[33,37] width:90 height:28 
	hyperlink rm "www.rendermotion.com" address:"www.rendermotion.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181) align:#center pos:[14,70]
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
			delta = (maxZ - minZ) / (numLevels + 1) 
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
rollout EditSplinesRollout "EditSplines" width:143 height:95
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
VentanaSeccion = newRolloutFloater "Secciona" 163 245
addRollout  SlicePlane VentanaSeccion
addRollout EditSplinesRollout VentanaSeccion

