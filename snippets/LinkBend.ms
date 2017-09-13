For i in selection do
	(
	AddModifier i (Bend())
	i.bend.direction=-90
	i.bend.limit=True
	i.bend.upperlimit=200
 	i.bend.lowerlimit=0
	paramWire.connect $Torus02.Rotation.controller[#y_Rotation] i.bend[#angle] "radtodeg(y_Rotation)"
	)
