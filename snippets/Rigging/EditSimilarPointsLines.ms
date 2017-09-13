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
 )
rollout EditPointsRollout "Edit Points" width:193 height:237
(
	checkbox CenterMarker "CenterMarker" pos:[9,11] width:91 height:16
	checkbox AxisTripod "Axis Tripod" pos:[9,27] width:89 height:16
	checkbox CrossCheckbox "Cross" pos:[9,43] width:68 height:16
	checkbox BoxCheckbox "Box" pos:[9,59] width:68 height:16
	spinner Size "Size:" pos:[21,81] width:91 height:16
	
	on CenterMarker changed CenterMarkerValue do
	(
	 for i in selection do
 		if ( classof i==Point )  do i.centermarker=CenterMarkerValue
	)
	on AxisTripod changed axistripodValue do
	(
	 for i in selection do
 		if ( classof i==Point )  do i.axistripod=axistripodValue
	)
 	
	on CrossCheckbox changed CrossCheckboxValue do
	(
	 for i in selection do
 		if ( classof i==Point )  do i.cross=CrossCheckboxValue
	)
	
	on BoxCheckbox changed BoxCheckboxValue do
	(
	 for i in selection do
 		if ( classof i==Point )  do i.box=BoxCheckboxValue
	)
	
	on Size changed SpinValue do
 	(
 	for i in selection do
 		if ( classof i==Point )  do i.size=SpinValue
 	)
	
)

EditSplinesFloater= newrolloutfloater   "Edit Splines" 150 250
addrollout  EditSplinesRollout EditSplinesFloater
addrollout  EditPointsRollout EditSplinesFloater