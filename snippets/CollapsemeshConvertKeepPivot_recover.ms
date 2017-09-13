for i in selection do 
	(
	a=box()
	OrigName=i.name
	a.rotation=coordsys world i.rotation
	a.position=coordsys world i.position
	a = convertToPoly(a)
	a.attach i a
	polyop.DeleteFaces a #{1..6}
	a.name=OrigName
	)

