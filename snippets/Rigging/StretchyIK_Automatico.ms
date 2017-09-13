fn SetAttibutes_Scale objeto=(
	Atributos=attributes ScaleParam(
	parameters Escala rollout:Cntrl
		(
		Scale_Multiplier type:#float ui:(ScalESp, ScalESl)
		)
	Rollout Cntrl "Control"
		(
		spinner ScalESp "" offset:[0,0] range:[0,1,0]
		slider  ScalESl "Escala" offset:[0,-20] range:[0,1,0]
		)
	)
	addmodifier objeto (EmptyModifier())
	custAttributes.add objeto.modifiers[1] Atributos
)

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
Dummy_Leaf=point()
Dummy_Leaf.size=8
Dummy_Leaf.box=True
Dummy_Leaf.position=hijos[i].position
SetAttibutes_Scale Dummy_Leaf
print hijos
print "distancias" + (Distancias as string)

for a=2 to hijos.count do
	(
	hijos[a].position.x_position.controller=float_script()
	hijos[a].position.x_position.controller.AddNode "Root" hijos[1]
    hijos[a].position.x_position.controller.AddNode "Leaf" Dummy_Leaf
	hijos[a].position.x_position.controller.AddTarget "Effecto" Dummy_Leaf.modifiers["Attribute Holder"].ScaleParam[1]
	hijos[a].position.x_position.controller.script = 
	"Longitud_Total="+(dTotal as string)+"\n"+
	"Longitud_Inicial="+(Distancias[a-1]as string)+"\n"+
	"/*factor de multiplicacion*/FM=Longitud_Inicial/Longitud_Total \n"+
	"Node_Huesos="+(i-1)as string +"\n"+
	"a=in coordsys world Root.position\n"+
	"b=in coordsys world Leaf.position\n"+
	"movFinal=0\n"+
	"if (distance a b)<Longitud_Total then\n"+
	"movFinal=Longitud_Inicial - ((Longitud_Total - (distance a b))*FM * Effecto) \n"+--
	"else \n"+
	"	movFinal=Longitud_Inicial+((distance a b)-Longitud_Total)/Node_Huesos\n"+
	"movFinal\n"
	)
return Dummy_Leaf
)
StretchyIK selection[1] selection[2]
