fn StretchyIK obj01 obj02=
(
hijos=#()
Distancias=#()
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
i=i+1
Dummy_Leaf=dummy()
Dummy_Leaf.boxsize=[2,2,2]
Dummy_Leaf.position=hijos[i].position
print hijos
print "distancias" + (Distancias as string)


for a=2 to hijos.count do
	(
	hijos[a].position.x_position.controller=float_script()
	hijos[a].position.x_position.controller.AddNode "Root" hijos[1]
    hijos[a].position.x_position.controller.AddNode "Leaf" Dummy_Leaf
	hijos[a].position.x_position.controller.script = 
	"Longitud_Total="+(dTotal as string)+"\n"+
	"Longitud_Inicial="+(Distancias[a-1]as string)+"\n"+
	"Node_Huesos="+(i-1)as string +"\n"+
	"a=in coordsys world Root.position\n"+
	"b=in coordsys world Leaf.position\n"+
	"movFinal=0\n"+
	"if (distance a b)<Longitud_Total then\n"+
	"	movFinal=Longitud_Inicial\n"+
	"else \n"+
	"	movFinal=Longitud_Inicial+((distance a b)-Longitud_Total)/Node_Huesos\n"+
	"movFinal\n"
	)
)
StretchyIK selection[1] selection[2]
