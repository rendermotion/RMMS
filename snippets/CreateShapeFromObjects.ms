new_spline = splineShape ()
addNewSpline new_spline
for i in selection do
	(
	a=i.position
	addKnot new_spline 1 #smooth #curve a
	)
updateShape new_spline