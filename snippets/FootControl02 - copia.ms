

fn CreateCircularControl AlignedTo radius Nombre=(
	c=circle render_sides:4 render_displayRenderMesh:TRUE  radius:radius steps:3 name:(uniqueName Nombre) render_thickness: 1
	/************/AsigntoLayer "RiggControls"  c
	BasePunto=Point  name:(uniqueName ("ResetPoint_"+Nombre))
	convertToSplineShape c
	c.Parent=BasePunto
	BasePunto.parent=AlignedTo
	BasePunto.transform=AlignedTo.transform
	in coordsys parent BasePunto.rotation=(eulerangles 0 -90 0)
	BasePunto.parent=undefined
	Return c
	)

/***************************************************
Funcion que crea un arreglo de toda la herarquia de 2 objetos, 
se le pasa un objeto 1 y un objeto 2 que se encuentre en su herarquia, 
y regresa en el arreglo de hijos, toda la herarquia, y en el arreglo de distancias
la distancia que existe entre cada objeto y su hijo, 
la funcion regresa la sumatoria de la distancia entre cada hijo y su padre
**************************************************/
fn creaArreglos hijos Distancias obj01 obj02=(
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

hijos=#();
Distancias=#();
creaArreglos  hijos Distancias $[1] $[selection.count]

if (hijos.count==5) then 
		(
		/*ball=point()
		ball.position=hijos[3].position
		toe=point()
		toe.position=hijos[4].position*/

		feet =CreateCircularControl  hijos[3] 5 "Feet"
		Ball  =CreateCircularControl  hijos[3] 7 "Ball"
		Toe =CreateCircularControl  hijos[4] 7 "Toe"


			
		)
else 
		messageBox "no hay el número de elementos adecuados para una pierna"


