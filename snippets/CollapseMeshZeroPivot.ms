for i in selection do
	(
	ep = editable_mesh name:(uniquename "EPoly")
	convertTo ep (Editable_Poly)
	f=i.name
	ep.EditablePoly.attach i ep
	ep.name=f
	)
