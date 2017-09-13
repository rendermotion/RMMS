/**************************************
Compara 2 valores con una tolerancia es usado en algunas funciones para comparar valores muy parecios.
******************************************/
fn CompTolerancia a b tolerancia=(
	
	if (a-b)<tolerancia and (a-b)>-tolerancia then 
		return true
	else 
		return false
)

/*****************************
Crea Un punto coplanar a 2 huesos el cual puede servir como póle vector en un Ik regresa el punto
*************************************/
fn CreatePointCoplanar  Bone01 Bone02 =(
	Vector01=Bone01.position-Bone02.position
	if Bone02.children[1]!=undefined then 
		Vector02=Bone02.position - Bone02.children[1].position
	else
		Vector02=(point3  0 0 1)
	Angulo=(acos (dot (Normalize Vector01) (Normalize Vector02))+180)/2
	Punto=point ()
	Punto.parent=Bone02
	--Punto.rotation=Bone02.rotation
	--in coordsys world Punto.position=Bone02.children[1].position
	Punto.transform=Bone02.children[1].transform
	d=(Normalize (cross Vector01 Vector02) )
	MatrizB2=Bone02.transform
	PosB2Z1=pretranslate MatrizB2 (point3 0 0 1)
	VectorZ=PosB2Z1.position-Bone02.position
	normalize VectorZ
	if CompTolerancia d[1] VectorZ[1] .001 and CompTolerancia d[2] VectorZ[2] .001  and CompTolerancia d[3] VectorZ[3] .001 then
		(
		in coordsys parent Punto.rotation=eulerangles 0 0 Angulo	
		)
	else
		(
		in coordsys parent Punto.rotation=eulerangles 0 0 -Angulo	
		)
return Punto
		
)
/*************************
Asigna los objetos a la capa cuyo nombre layer name, en caso de que no exista crea la capa.
***************************/
fn AsigntoLayer LayerName Objetos=(
	Capa=LayerManager.getLayerFromName LayerName
	if  (Capa==undefined) do 
			Capa=LayerManager.newLayerFromName  LayerName
	if classof Objetos == Array then
		for i in objetos do 
			capa.addnode i
	else 
		capa.addnode Objetos
	)
/**************************
Funcion que crea una linea en los puntos en los que se encuentran los elementos de un arreglo
*************************************/
fn creaLineaenHerarquia hijos curvedLine =(

ss = SplineShape pos:hijos[1].position render_displayRenderMesh:FALSE 
if curvedLine ==TRUE then
	ss.name=uniquename ("CurvedLineOnH")
else
	ss.name=uniquename ("StraightLineOnH")

/************/AsigntoLayer "RiggPoints"  SS
addNewSpline ss
for i in hijos do  
	if curvedLine==TRUE then
	addKnot ss 1 #smooth #curve i.position
	else 
	addKnot ss 1 #corner #curve i.position
updateShape ss
ss
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
/*************************
Funciones que agregan parametros en un Modificador vacio
*********************************/
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

fn SetAttibutes_Polaridad objeto=(
	Atributos=attributes PolaridadParam(
	parameters Pol rollout:PolRoll
		(
		Polaridad type:#float ui:(PolESp, PolESl)
		)
	Rollout PolRoll "Peso"
		(
		spinner PolESp "" offset:[0,0] range:[-1,1,1]
		slider  PolESl "Peso" offset:[0,-20] range:[-1,1,1]
		)
	)
	addmodifier objeto (EmptyModifier())
	custAttributes.add objeto.modifiers[1] Atributos
)
fn CreateCircularControl AlignedTo  radius Nombre=(
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
/********************************
Funcion que genera un stretchy IK en los huesos que se encuentran en una herarquia
***************************************/
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
Dummy_Leaf=point name:(uniquename "Control")
/************/AsigntoLayer "RiggPoints" Dummy_Leaf
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
 IKMAnip=IKSys.ikChain obj01 obj02 "IKHISolver"
 IKMAnip.parent=Dummy_Leaf
 Elem=int hijos.count
 Elem=Elem/2
 Punto2=CreatePointCoplanar hijos[Elem] hijos[Elem+1]
 Punto=CreateCircularControl Punto2 5 "UpNode"
 AsigntoLayer "RiggControls" Punto
 AsigntoLayer "RiggControls" Punto.parent
 (Punto.parent).parent=Dummy_Leaf
 IKMAnip.controller.VHTarget=Punto
delete Punto2
 return #(Dummy_Leaf,Punto)
)
/********************************************
Funcion que genera puntos sobre la linea, y los atacha a ella utilizando un path constraint.
Genera el numero de puntos NumPuntos y los distribuye a lo largo de la linea PShape
La funcion regresa un arreglo de puntos.
**************************************/
fn CreatePointsAtShape   PShape  NumPuntos =(
	ArreglodePuntos=#()
	porcentaje=100/(NumPuntos-1)as float;
	for PuntoN=0 to (NumPuntos-1) do 
	(
		puntoNuevo=point()
		if (PuntoN!=0) do
			puntoNuevo.parent=ArreglodePuntos[PuntoN]
			
/************/AsigntoLayer "RiggPoints" puntoNuevo
		puntoNuevo.name=("PointOn"+PShape.name+(PuntoN)as string);
		append  ArreglodePuntos puntoNuevo  
		puntoNuevo.position.controller=Path_Constraint();
		puntoNuevo.position.controller.path=PShape
		deleteItem puntoNuevo.position.controller.percent.controller.keys 2
		puntoNuevo.position.controller.percent=porcentaje*(PuntoN)
		puntoNuevo.position.controller.constantVel=off
	)
return ArreglodePuntos
)
/****************************
Cambia La propiedad de BoneFrezeLength en los huesos, para que se puedan estirar
***********************************/
fn MakeStretchyBones ArreglodeHuesos=(
	
	for i in ArreglodeHuesos do
			i.boneFreezeLength=False
	)
/****************************
Mide la distancia entre objetos en un arreglo y regresa la distancia total que hay entre ellos como si formaran una cadena
******************************/
fn DistanciasObjetos Arreglo=(
	distancia=0.0
	for i=1 to (Arreglo.count-1) do
		distancia=distancia+distance Arreglo[i] Arreglo[i-1]
	return distancia
	)
/****************************
Crea un conjunto de huesos basado en un arreglo de puntos. 
******************************/c
fn CreateBonesatPoints ArreglodePuntos =(
	n=ArreglodePuntos.count

	ArregloHuesos=#()
	for Elemento=1 to n do 
		(
		if Elemento<n then
			(	print ((ArreglodePuntos[Elemento].transform.position ) as string+ (ArreglodePuntos[Elemento+1].transform.position) as string)
				a=BoneSys.createBone ArreglodePuntos[Elemento].transform.position ArreglodePuntos[Elemento+1].transform.position ArreglodePuntos[Elemento].transform.position

/************/AsigntoLayer "RiggBones" a
				append ArregloHuesos a
				if Elemento!=1 do
						ArregloHuesos[Elemento].parent=ArregloHuesos[Elemento-1]
			)
		else 
			(
			FinalPoint=(ArreglodePuntos[Elemento].transform.position+5*normalize	(ArreglodePuntos[Elemento].transform.position-ArreglodePuntos[Elemento-1].transform.position))
			a=BoneSys.createBone ArreglodePuntos[Elemento].transform.position FinalPoint FinalPoint
/************/AsigntoLayer "RiggBones" a
			append ArregloHuesos a
			ArregloHuesos[Elemento].parent=ArregloHuesos[Elemento-1]
			)
		)
	return ArregloHuesos
	)

/*****************************************
	Crea un constraint de orientacion en los puntos y los alinea con arreglo de huesos, 
	cada punto es alineado con tres huesos sobre el que se encuenta, el anterior y el posterior
	********************************************/	
fn OrientPointsToBones ArreglodePuntos ArreglodeHuesos=(
	Incremento=(ArreglodeHuesos.count-1)/ArreglodePuntos.count
	
	for Pointnum=1 to ArreglodePuntos.count do
	(
		OrConst=Orientation_Constraint()
		ArreglodePuntos[Pointnum].parent.rotation.controller=OrConst
		FactorPP=(ArreglodeHuesos.count as float-1)/((ArreglodePuntos.count) as float-1)/***Factor por punto el avance que hay por punto****/
		DesdeHueso=int (ceil(Pointnum*FactorPP))
		
		--print ("Punto="+Pointnum as string)
		--print ("PuntosPorHueso="+FactorPP as string)
		--print ("DesdeHueso="+DesdeHueso as string)

		for  BoneNum=(DesdeHueso-1) to (DesdeHueso+1) do 
		(--print ("BoneNum="+BoneNum as string)
			if BoneNum>0 and BoneNum<=ArreglodeHuesos.count do
					(
					Val=FactorPP*Pointnum-BoneNum
					--print ("BoneNum In="+BoneNum as string)
					--print ("Val="+Val as string)
					if BoneNum==DesdeHueso do
						OrConst.appendtarget ArreglodeHuesos[BoneNum]  1
					if BoneNum==(DesdeHueso-1) do
						OrConst.appendtarget ArreglodeHuesos[BoneNum]  (1-Val)
					if BoneNum==(DesdeHueso+1) do
						OrConst.appendtarget ArreglodeHuesos[BoneNum]  Val
					)
		)
	)
)
/********************
Acepta dos Arreglos uno de huesos y otro de púntos, y crea un script por hueso para que se estire basado en la distancia entre los puntos, Crea un punto de control para la rotacion lugado a MainCntrl
/***********************************/
fn StretchBonestoPoints   ArregloHuesos ArreglodePuntos MainCntrl OrientOrigin=(
	MakeStretchyBones ArregloHuesos
	--dTotal=DistanciasObjetos ArreglodePuntos
	IKArray=#()
	PoleVector=#()
	PoleVectorCntrl=#()
			
	for a=2 to ArreglodePuntos.count do
		(
		append PoleVector (Point name:(uniquename "PoleSpinePoint") )
		PoleVector[a-1].transform=(ArreglodePuntos[a-1].parent).transform
		PoleVector[a-1].transform=pretranslate PoleVector[a-1].transform  (point3 0 0 10)
		
		CirculoPole=CreateCircularControl ArreglodePuntos[a-1].parent 1 "PoleVectorMarker"
		CirculoPole.render_thickness=.7
		CirculoPole.transform=ArreglodePuntos[a-1].transform
		AsigntoLayer "RiggControls_SubControl" CirculoPole
		append PoleVectorCntrl CirculoPole
		MoveMtx1y=transMatrix (point3 0 0 10)
		CirculoPole.objectoffsetpos*=MoveMtx1y
		delete CirculoPole.parent
		CirculoPole.parent=(ArreglodePuntos[a-1])

		PoleVector[a-1].parent=CirculoPole
		
		CirculoPole.rotation.x_rotation.controller=float_script()
		CirculoPole.rotation.x_rotation.controller.AddTarget "RotFin" MainCntrl.rotation.x_rotation.controller
		CirculoPole.rotation.x_rotation.controller.AddNode "RotIni"   OrientOrigin
		CirculoPole.rotation.x_rotation.controller.script=
		("rotFinVal=degtorad RotFin \n"+
		  "rotiniVal=quattoeuler (RotIni.transform*(inverse (RotIni.parent).transform)).rotationpart \n"+
		  "f=rotiniVal.x_rotation\n"+
		  "rotFinVal*"+(1/((ArreglodePuntos.count as float)-1)*(a-2))as string+"+degtorad(f)*"+(1-(1/((ArreglodePuntos.count as float)-1)*(a-2)))as string+"\n")
		
		 IK_Spline=IKSys.ikChain ArregloHuesos[a-1] ArregloHuesos[a]  "IKHISolver"
	     /***********/AsigntoLayer "RiggPoints" IK_Spline
		IK_Spline.parent=ArreglodePuntos[a]
		append IKArray IK_Spline
		ArregloHuesos[a].position.x_position.controller=float_script()
		ArregloHuesos[a].position.x_position.controller.AddNode "Root" ArreglodePuntos[a-1]
		ArregloHuesos[a].position.x_position.controller.AddNode "Leaf" ArreglodePuntos[a]
		--ArregloHuesos[a].position.x_position.controller.AddTarget "Effecto" Dummy_Leaf.modifiers["Attribute Holder"].ScaleParam[1]
		ArregloHuesos[a].position.x_position.controller.script ="movFinal=distance Root Leaf"
		)
	AsigntoLayer "RiggPoints" PoleVector
	for IK_N=1 to IKArray.count do
		IKArray[IK_N].controller.VHTarget = PoleVector[IK_N]
	return IKArray
	)
	
/****************************
    Agrega un ik por cada Hueso que existe en un arreglo Regresa el Arreglo de IK
	*******************************/
fn AddIktoBones ArregloHuesos=(
	IKArray=#();
		for i=2 to ArregloHuesos.count do 
			append IKArray (IKSys.ikChain ArregloHuesos[i-1] ArregloHuesos[i]  "IKHISolver")
	return IKArray
	)
/****************************
    Emparenta 1 a 1 los elementos de 2 arreglos, utiliza la variable offset para desfasar los elementos del arreglo de padres
	*******************************/
fn ParentConstraint Padre Hijo=(
	--print Hijo.name
	--print Hijo.position.controller 
	if classof Hijo.position.controller == Position_Constraint do
		print ("numero de Targets"+ (Hijo.position.controller.getNumTargets()) as string)

if (classof hijo.position.controller==Position_Constraint) do hijo.position.controller=Position_XYZ()
a=Position_Constraint ()
ai=a.constraints
Hijo.position.controller=a
ai.appendTarget Padre 50.0
if (classof hijo.rotation.controller==Orientation_Constraint) do hijo.rotation.controller=Euler_XYZ()
a=Orientation_Constraint ()
ai=a.constraints
Hijo.rotation.controller=a
ai.appendTarget Padre 50.0

)
fn ParentConstArrays Padres Hijos Offset=	(
	for i=1 to Hijos.count do
		ParentConstraint Padres[i+Offset] Hijos[i]
	)
fn ParentArrays Padres Hijos Offset=	(
	for i=1 to Hijos.count do
		Hijos[i].parent=Padres[i+Offset]
	)
/************************************************
	Atacha un punto a  dos puntos y crea un control en el punto en slider para controlar el controlador de Posicion
	*****************************************************/
fn AttachtoPoints PesoNeg PesoPos Controlado=(
	 SetAttibutes_Polaridad Controlado
	 PositionC=Controlado.position.controller=Position_Constraint();
	 PositionC.appendTarget PesoNeg 1.0
	 PositionC.appendTarget PesoPos  1.0
	 paramWire.connect Controlado.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] Controlado.pos.controller[#Position_Weight_0] "if Polaridad>0 then 1-Polaridad else 1"
	 paramWire.connect Controlado.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] Controlado.pos.controller[#Position_Weight_1] "if Polaridad<0 then 1+Polaridad else 1"
	)

fn IKControlMod SPline_Guide Name_Points=
(
	local SplineControlMod=Spline_IK_Control()
    addmodifier SPline_Guide SplineControlMod
	select SPline_Guide
	f=$.modifiers[1].getKnotCount()
	SPline_Guide.modifiers[1].createHelper (SPline_Guide.modifiers[1].getKnotCount())
	for i=1 to  ((SplineControlMod.helper_list).count) do 
		(
			SplineControlMod.helper_list[i].name=(Name_Points + (i as string))
			SplineControlMod.helper_list[i].size=30
		)
	AsigntoLayer "RiggPoints" ($.modifiers[1].helper_list as array)
	return $.modifiers[1].helper_list
)

fn orientPoints Puntos UpNode=(
	for i=1 to Puntos.count-1 do 
	(
	LookAtPoint=LookAt_Constraint()
	Puntos.rotation.controller=LookAtPoint
	LookAtPoint.pickUpNode =UpNode
	LookAtPoint.appendTarget Puntos[i+1] 50
	)		
)

fn MAINCreaTubeCntrls ObjParent ObjChildren NumControls=
	(
	Distancias=#()
	Herarquia=#()
	Dtotal=creaArreglos Herarquia Distancias ObjParent ObjChildren
	AsigntoLayer "RiggBones_NoSkin" Herarquia
	LineaCurva=creaLineaenHerarquia Herarquia TRUE 
	LineaRecta=creaLineaenHerarquia Herarquia FALSE
	
	PuntosCurva=IKControlMod LineaCurva "PointCurva"
	PuntosRecta=IKControlMod LineaRecta "PointRecta"
    
	--ParentArrays  Herarquia PuntosCurva 0
	--ParentArrays  Herarquia PuntosRecta 0
	
	ParentConstArrays  Herarquia PuntosCurva 0
	ParentConstArrays  Herarquia PuntosRecta 0
    
	
	for i=2 to (PuntosCurva.count-1) do 
		(
			Control_Curva=CreateCircularControl Herarquia[i] 15 "ControlCurva"
			AsigntoLayer "RiggControls" Control_Curva
			AsigntoLayer "RiggPoints" (Control_Curva.parent)
			select Control_Curva
			select PuntosCurva[i]
			ParentConstraint Control_Curva PuntosCurva[i]
			ParentConstraint Herarquia[i] Control_Curva.parent
			--append Control_Curva.children PuntosCurva[i]
			--append Herarquia[i].children Control_Curva.parent 
		)

	ControlTotal=CreateCircularControl  Herarquia[Herarquia.count] 10 "ControlTotal"
--	(ControlTotal.Parent).parent=undefined
	SetAttibutes_Polaridad ControlTotal
	ControlTotal.modifiers[1].PolaridadParam.Polaridad=1
	Root=Point size:30 centermarker:TRUE box:true name:(uniquename "Root")
	Root.transform=herarquia[1].transform
	herarquia[1].parent=root	
	RootHelpers=Point size:10 centermarker:TRUE box:true name:(uniquename "RootPoints")
	RootHelpers.transform=herarquia[1].transform
	PuntosCurva[1].parent=RootHelpers
	PuntosRecta[1].parent=RootHelpers
	LineaCurva.parent=RootHelpers
	LineaRecta.parent=RootHelpers
	
	
	PuntosCurvos=CreatePointsAtShape LineaCurva NumControls	
	PuntosRectos=CreatePointsAtShape LineaRecta NumControls
	
	HesosMedios=CreateBonesatPoints PuntosRectos
	
	PuntoMedio=#()
	ControlesMedios=#()

	for i=1 to PuntosCurvos.count do
	    (
			append ControlesMedios (CreateCircularControl HesosMedios[i]  3 ("ControlesMedios_"+i as string))
			AsigntoLayer "RiggControls_SubControl" ControlesMedios[i]
			--(ControlesMedios[i].parent).parent=undefined
			append PuntoMedio (ControlesMedios[i].parent)
			AsigntoLayer "RiggPoints" PuntoMedio[i]
			AttachtoPoints PuntosCurvos[i] PuntosRectos[i] PuntoMedio[i]
			paramWire.connect ControlTotal.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] PuntoMedio[i].modifiers[#Attribute_Holder].PolaridadParam[#Polaridad]  "Polaridad"	
		)
	
	--PuntoControl=StretchyIK ObjParent ObjChildren 
		
	NElem=Herarquia.count
	NElem=Nelem/2
	--PoleVectorCircle=CreateCircularControl PuntoControl[2].parent 5 "PoleVector"
	--(PoleVectorCircle.parent).transform= pretranslate PoleVectorCircle.transform   (point3 (distance Herarquia[NElem] Herarquia[NElem+1]) 0 ((distance Herarquia[NElem] Herarquia[NElem+1])) )
	--orientPoints PuntoMedio PuntoControl[2]
	
	--PuntoControl[1].parent=ControlTotal
	
	ControlRotacion=CreateCircularControl Herarquia[Herarquia.count] 5 "Rotacion"
	(ControlRotacion.parent).parent=Herarquia[Herarquia.count]
	
		
	/**********************************************************************************/
	/*Prepara dos puntos para ser la rotacion inicial del sistema de rotacion de stretchyIK**/
	OrientOrigin=Point name:(uniquename "OrientOriginPoint" axistripod:TRUE)
	AsigntoLayer "RiggBones" OrientOrigin
	OrientOrigin.transform=Herarquia[1].transform
	OrientOrigin.parent=Herarquia[1]
	PoleVectorOrigin=Point name:(uniquename "PoleVector" axistripod:TRUE)
	PoleVectorOrigin.transform=OrientOrigin.transform
	in coordsys local (move PoleVectorOrigin [0, 0, 10])
	
	LookatController=Lookat_Constraint()
	OrientOrigin.rotation.controller=LookatController
	LookatController.appendTarget Herarquia[2] 100
	LookatController.upnode_world=false
	LookatController.pickUpNode=PoleVectorOrigin
	LookatController.upnode_ctrl=0
	/*********************************************************/
	OrientPointsToBones ControlesMedios Herarquia
	StretchyIKArray=StretchBonestoPoints HesosMedios ControlesMedios ControlRotacion OrientOrigin--Funcion que crea los controles de Rotacion
	
	
	HesosMedios[1].parent=root
	)
	
--CreateCircularControl $ 10
rollout BotonesStretchy "Stretch" width:131 height:136
(
	button BtnStretchyc "StretchyC" pos:[13,8] width:106 height:31
	button BtnStretchyIK "StretchyIK" pos:[12,45] width:106 height:31 toolTip:""
	button ParentConst "Parent Constraint" pos:[13,85] width:106 height:31 toolTip:"Emparenta con constraints selecciona hijo y a continuacion padre"
	on BtnStretchyc pressed do
	(
	 MAINCreaTubeCntrls $[1] $[2]  9
	)
	on BtnStretchyIK pressed do
	(
		StretchyIK $[1] $[2]
	)
	on ParentConst pressed do
	(
		ParentConstraint  $[2] $[1]
	)
)
VentanaLigaParam = newRolloutFloater "Liga Parametros" 163 180
addRollout BotonesStretchy VentanaLigaParam

