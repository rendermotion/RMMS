fn creaLineaenHerarquia hijos=(
ss = SplineShape pos:hijos[1].position
addNewSpline ss
for i in hijos do  
	addKnot ss 1 #smooth #curve i.position
updateShape ss
ss
)
fn creaArreglos hijos Distancias obj01 obj02=
(
append hijos obj01
i=0
dTotal=0
do
	(
	i=i+1
	hijos[i].boneFreezeLength=False
	if (hijos[i].children.count!=0) do
		(
		append hijos hijos[i].children[1]
		d=in coordsys parent hijos[i].children[1].position.x
		append Distancias d
		dTotal=dTotal+d
		)
	)
while ((hijos[i+1]!=obj02) and  (hijos[i].children.count!=0))
return dTotal
)

hijos=#()
Distancias=#()
creaArreglos hijos Distancias selection[1] selection[2]
f=creaLineaenHerarquia hijos
f.name