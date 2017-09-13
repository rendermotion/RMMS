ObjSelect=selection as array
	NSelect=ObjSelect.count
	for i=1 to NSelect do 
		(
		if 	(isShapeObject ObjSelect[(NSelect-i)+1]==false) then
			(
				ObjtoReset = ObjSelect[(NSelect-i)+1]
				print ObjtoReset
				itHasturbosm=0
				if classof ObjtoReset.modifiers[1]==Turbosmooth do
					(
					TurboMod=ObjtoReset.modifiers[1]
					deleteModifier ObjtoReset 1
					itHasturbosm=1
					)
				a=Box()
				Convertto a Editable_Poly
				a.name=ObjSelect[(NSelect-i)+1].name
				a.parent=ObjSelect[(NSelect-i)+1].parent
				a.EditablePoly.attach ObjSelect[(NSelect-i)+1] a
				--select a
				a.EditablePoly.SetSelection #Face #{1..6}
				a.EditablePoly.delete #Face
				if (itHasturbosm==1) do
					addmodifier a TurboMod
			)
		else(
			print "el objeto no es linea"
			
			)
		)