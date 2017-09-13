
/*a=selection[1]
b=selection[2]
execute ("paramWire.connect $"+b.name+".rotation.controller[#Z_Rotation] $"+a.name+".rotation.controller[#Z_Rotation] \"Z_Rotation + degtorad "+(( in coordsys gimbal a.rotation.z) as string)+" \" ")
execute ("paramWire.connect $"+b.name+".rotation.controller[#X_Rotation] $"+a.name+".rotation.controller[#X_Rotation] \"X_Rotation + degtorad "+(( in coordsys gimbal a.rotation.x) as string)+" \" ")
execute ("paramWire.connect $"+b.name+".rotation.controller[#Y_Rotation] $"+a.name+".rotation.controller[#Y_Rotation] \"Y_Rotation + degtorad "+(( in coordsys gimbal a.rotation.y) as string)+" \" ")
*/
rollout LigaParam "Untitled" width:163 height:227
(
	checkbox chkX "X" pos:[51,33] width:41 height:18
	checkbox chkY "Y" pos:[51,55] width:29 height:18
	checkbox chkZ "Z" pos:[51,76] width:30 height:17
	checkbox NX "-" pos:[9,32] width:35 height:20
	checkbox NY "-" pos:[9,55] width:35 height:20
	checkbox NZ "-" pos:[9,75] width:35 height:20
	radiobuttons rdo2 "Master2Slave" pos:[91,12] width:45 height:78 labels:#("P2P", "R2R", "P2R", "R2P")
	label lbl1 "LinkAxis" pos:[15,11] width:54 height:17
	button btn1 "Link" pos:[26,103] width:100 height:34
	checkbox chkCC "Create Controller" pos:[25,144] width:106 height:21
	spinner spnRad "Radius     :" pos:[16,169] width:125 height:16 range:  [0,100,2]
	spinner spnThick "Thickness:" pos:[17,191] width:125 height:16 range:  [0,100,1.1]
		fn ParentWithConstraints Child Parent=(
			a=Position_Constraint ()
			ai=a.constraints
			Child.position.controller=a
			ai.appendTarget Parent 50.0
			a=Orientation_Constraint ()
			ai=a.constraints
			Child.rotation.controller=a
			ai.appendTarget Parent 50.0
			)
	
		fn CreateCircularControl AlignedTo  radius Nombre Thickness=(
			c=circle render_sides:4 render_displayRenderMesh:TRUE  radius:radius steps:3 name:(uniqueName Nombre) render_thickness: Thickness
			--/************/AsigntoLayer "RiggControls"  c
			BasePunto=Point  name:(uniqueName ("ResetPoint_"+Nombre))
			LinkedPoint=Point  name:(uniqueName ("LinkedPoint_"+Nombre))
			convertToSplineShape c
			c.Parent=BasePunto
			if AlignedTo.parent !=undefined then 
				(
				LinkedPoint.transform=(AlignedTo.parent).transform
				LinkedPoint.position=AlignedTo.position
				LinkedPoint.parent=AlignedTo.parent
				ParentWithConstraints BasePunto LinkedPoint
				)
			else
				(
					BasePunto.position=AlignedTo.position
				)
				--in coordsys parent BasePunto.rotation=(eulerangles 0 -90 0)
			Return c
		)
	

	on btn1 pressed do
	( print chkCC.checked
		if chkCC.checked==False then
		(
			a=selection[2]
			b=selection[1]
		)
		else 
		(  Print "Cree Punto"
			a=selection[1]
			b=CreateCircularControl selection[1] spnRad.value "control" spnThick.value
			--(b.parent).parent=a.parent
		)
	if (chkX.checked==true) do 
		if(NX.checked==false) then
			execute ("paramWire.connect $"+b.name+".rotation.controller[#X_Rotation] $"+a.name+".rotation.controller[#X_Rotation] \"X_Rotation + degtorad "+(( in coordsys gimbal a.rotation.x) as string)+" \" ")
		else
			execute ("paramWire.connect $"+b.name+".rotation.controller[#X_Rotation] $"+a.name+".rotation.controller[#X_Rotation] \"-X_Rotation + degtorad "+(( in coordsys gimbal a.rotation.x) as string)+" \" ")
	if (chkY.checked==true) do 
		if(NY.checked==false) then
			execute ("paramWire.connect $"+b.name+".rotation.controller[#Y_Rotation] $"+a.name+".rotation.controller[#Y_Rotation] \"Y_Rotation + degtorad "+(( in coordsys gimbal a.rotation.y) as string)+" \" ")		
			else
			execute ("paramWire.connect $"+b.name+".rotation.controller[#Y_Rotation] $"+a.name+".rotation.controller[#Y_Rotation] \"-Y_Rotation + degtorad "+(( in coordsys gimbal a.rotation.y) as string)+" \" ")			
	if (chkZ.checked==true) do 
		if(NZ.checked==false) then
			execute ("paramWire.connect $"+b.name+".rotation.controller[#Z_Rotation] $"+a.name+".rotation.controller[#Z_Rotation] \"Z_Rotation + degtorad "+(( in coordsys gimbal a.rotation.z) as string)+" \" ")
			else 
			execute ("paramWire.connect $"+b.name+".rotation.controller[#Z_Rotation] $"+a.name+".rotation.controller[#Z_Rotation] \"-Z_Rotation + degtorad "+(( in coordsys gimbal a.rotation.z) as string)+" \" ")
	)
)
VentanaLigaParam = newRolloutFloater "Liga Parametros" 163 250
addRollout LigaParam VentanaLigaParam

