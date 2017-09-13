ScriptPath="D:\\Development\\RMMS\\"

filein (ScriptPath+"RMRiggOrder.ms")
filein (ScriptPath+"RMNameConvention.ms")
filein(ScriptPath+"RMRiggMath.ms")

fn RMSetAttibutes_Polaridad objeto=(
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

--****************************************************************
--  Crea un hueso en la punta del hueso dado
--**********************************************************
fn RMCreateNub LastBone =
(
	if classof LastBone==BoneGeometry do
	(
		XVector=RMGetDirVector LastBone Axis:"x"
		a=BoneSys.createBone (LastBone.position+XVector*LastBone.length) (LastBone.position+XVector*LastBone.length + XVector*LastBone.width) LastBone.dir
		a.height=LastBone.height
		a.width=LastBone.width
		a.parent=LastBone
	)
	RMAsigntoLayer "RiggBones" a
	return a
)

/************************************************************
Crea una herarquia de huesos entre 2 puntos dados
/************************************************************/

fn RMCreateBonesBetweenPoints StartingPosition EndPosition UpVector NumberOfBones parented:TRUE =
(
	DirectionVector=(EndPosition-StartingPosition)/3
	ArregloHuesos=#()
	for NBone=1 to NumberOfBones do
	(
		a=BoneSys.createBone StartingPosition (StartingPosition+DirectionVector) UpVector
		a.height=(length DirectionVector)/5
		a.width=(length DirectionVector)/5
		/************/RMAsigntoLayer "RiggBones" a
		append ArregloHuesos a
		StartingPosition=StartingPosition+DirectionVector
		if NBone>1 and parented==TRUE do 
			ArregloHuesos[NBone].parent=ArregloHuesos[NBone-1]
		
		if NBone==NumberOfBones and parented==True do
			(
				nub=RMCreateNub a
				append ArregloHuesos nub
			)

	)
	return ArregloHuesos
)
--********************************************************
--Funcion que crea huesos en la posicion de un arreglo de puntos
--Receives an array of points and Creates a bone chain through the points
--Can also receive only one point and create a bone at that point position aligned to the point
--*********************************************************
fn RMCreateBonesatPoints ArreglodePuntos BoneSize:1 =(

	if classof ArreglodePuntos==Array then
	(
	n=ArreglodePuntos.count
	ArregloHuesos=#()
	for Elemento=1 to n do 
		(
		if Elemento<n then
			(	
				a=BoneSys.createBone ArreglodePuntos[Elemento].transform.position ArreglodePuntos[Elemento+1].transform.position ArreglodePuntos[1].dir
				a.width=(distance ArreglodePuntos[Elemento].transform.position ArreglodePuntos[Elemento+1].transform.position)/5
				a.height=(distance ArreglodePuntos[Elemento].transform.position ArreglodePuntos[Elemento+1].transform.position)/5
				if RMIsNameInFormat ArreglodePuntos[Elemento] do
					a.name=RMUniqueName(RMSetFromName ArreglodePuntos[Elemento].name 4 "jnt")
				
	/************/RMAsigntoLayer "RiggBones" a
				append ArregloHuesos a
				if Elemento!=1 do	
						ArregloHuesos[Elemento].parent=ArregloHuesos[Elemento-1]
			)
		else 
			(
			a=RMCreateNub ArregloHuesos[n-1]
			/*FinalPoint=(ArreglodePuntos[Elemento].transform.position+5*normalize	(ArreglodePuntos[Elemento].transform.position-ArreglodePuntos[Elemento-1].transform.position))
			a=BoneSys.createBone ArreglodePuntos[Elemento].transform.position FinalPoint ArreglodePuntos[1].dir
			a.width=(distance ArreglodePuntos[Elemento].transform.position FinalPoint)/5
			a.height=(distance ArreglodePuntos[Elemento].transform.position FinalPoint)/5
			*/
			if RMIsNameInFormat ArreglodePuntos[Elemento] do
					a.name= RMUniqueName(RMSetFromName ArreglodePuntos[Elemento].name 4 "jnt")
	/************/RMAsigntoLayer "RiggBones" a
			append ArregloHuesos a
			ArregloHuesos[Elemento].parent=ArregloHuesos[Elemento-1]
			)
		)
	return ArregloHuesos
	)
	else
		(
		if classof ArreglodePuntos==Point do
			(
				XVector=RMGetDirVector ArreglodePuntos Axis:"x"
				ZVector=RMGetDirVector ArreglodePuntos Axis:"z"
				a=BoneSys.createBone (ArreglodePuntos.position) (ArreglodePuntos.position+XVector*BoneSize) ZVector
				a.height=BoneSize
				a.width=BoneSize
				RMAsigntoLayer "RiggBones" a
				return a
			)
		)
	)
/**************************
Funcion que crea una linea en los puntos en los que se encuentran los elementos de un arreglo
*************************************/	
fn RMCreateLineAtHierarchy hijos curvedLine =(

ss = SplineShape pos:hijos[1].position render_displayRenderMesh:FALSE 
	
if curvedLine ==TRUE then
	ss.name=uniquename ("CurvedLineOnH")
else
	ss.name=uniquename ("StraightLineOnH")

/************/RMAsigntoLayer "RiggPoints"  SS
addNewSpline ss
for i in hijos do  
	if curvedLine==TRUE then
	addKnot ss 1 #smooth #curve i.position
	else 
	addKnot ss 1 #corner #curve i.position
updateShape ss
return ss
)
/****************************
Crea un LookAtConstraintcon un punto 
***********************************/
fn RMLookAtConstraint ObjectConstrained LookAtTarget Axis:"Z" UpNodeValue:1=
(
	LAConstraint=LookAt_Constraint()
	UpNode=point name:(uniquename "UpNode")
	RMAsigntoLayer "RiggPoints" UpNode
	UpNode.transform=ObjectConstrained.transform
	if axis=="Y"or axis=="y" then 
	(
		in coordsys local move UpNode [0,UpNodeValue,0]
	)
	else 
	(
		if axis=="X" or axis=="x" then
			(in coordsys local move UpNode [UpNodeValue,0,0])
		else 
			(in coordsys local move UpNode [0,0,UpNodeValue])
	)
	ObjectConstrained.rotation.controller=LAConstraint
	LAConstraint.appendTarget LookAtTarget 50
	LAConstraint.upnode_world = off
	LAConstraint.pickUpNode=UpNode
	LAConstraint.upnode_ctrl=0
	LAConstraint.StoUP_axis=2
	LAConstraint.lookat_vector_length=0
	print UpNode
	return UpNode
)
	
	
/****************************
Cambia La propiedad de BoneFrezeLength en los huesos, para que se puedan estirar
***********************************/
fn MakeStretchyBones ArreglodeHuesos=(
	for i in ArreglodeHuesos do
			i.boneFreezeLength=False
	)
/****************************
    Agrega un ik por cada Hueso que existe en un arreglo Regresa el Arreglo de IK
	*******************************/
fn RMAddIktoBones ArregloHuesos=(
	IKArray=#();
		for i=2 to ArregloHuesos.count do 
			(
				append IKArray (IKSys.ikChain ArregloHuesos[i-1] ArregloHuesos[i]  "IKHISolver")
			)
	RMAsigntoLayer "RiggPoints" IKArray
	return IKArray
	)
	
/****************************
Agrega un spline Control a la linea y crea los puntos que la controlaran, regresa un arreglo con los puntos que controlan la linea
/****************************/
fn RMIKControlMod SPline_Guide Name_Points:"IK_Control_Points"=
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
	RMAsigntoLayer "RiggPoints" ($.modifiers[1].helper_list as array)
	return $.modifiers[1].helper_list
)

/*****************************************************************
	Emparenta Con constraints 
/*****************************************************************/
fn RMParentConstraint Padre Hijo Flag:3=(
	   /*****************************************************************************
	      Flag= if flag == 1 it will link only on position
						  2 It will link only orientation
						  3 it will link Position and Orientation 
		****************************************************************************/
	if (Flag==3 or Flag==1) do
	(
		if classof Hijo.position.controller == Position_Constraint do
				print ("numero de Targets"+ (Hijo.position.controller.getNumTargets()) as string)
		if (classof hijo.position.controller==Position_Constraint) do hijo.position.controller=Position_XYZ()
		a=Position_Constraint ()
		ai=a.constraints
		Hijo.position.controller=a
		ai.appendTarget Padre 50.0
	)
	if (Flag==3 or Flag==2) do
	(
		if (classof hijo.rotation.controller==Orientation_Constraint) do hijo.rotation.controller=Euler_XYZ()
		a=Orientation_Constraint ()
		ai=a.constraints
		Hijo.rotation.controller=a
		ai.appendTarget Padre 50.0
	)
)
/*****************************************************************
Emparenta dos Arreglos Por medio de Constraints, lo hace 1 a 1
/*****************************************************************/
fn RMParentConstArrays Padres Hijos Offset:0=	(
	if (classof Padres ==Array) then
		for i=1 to Hijos.count do
			ParentConstraint Padres[i+Offset] Hijos[i]
	else 
		for i=1 to Hijos.count do
			ParentConstraint Padre Hijos[i]
	)
/*****************************************************************
Emparenta dos Arreglos Por medio de Constraints, lo hace 1 a 1
/*****************************************************************/
fn RMParentArrays Padres Hijos Offset:0=	(
	if (classof Padres ==Array) then
		for i=1 to Hijos.count do
			Hijos[i].parent=Padres[i+Offset]
	else 
		for i=1 to Hijos.count do
			Hijos[i].parent=Padres
	)
/*****************************************************************************
	Emparenta con Constraints  un punto a  dos puntos y crea un control en el punto en slider para controlar el controlador de Posicion
*****************************************************/
	
fn RMAttachToPoints PesoNeg PesoPos Controlado flag:1 weightNeg:1 weightPos:1 wireWeight:TRUE=
	(
		/***************************************************************************
		Controlado= The object that will be linked to Peso Neg and Peso Pos
		PesoNeg= The object that will be linked at the -1 value
		PesoPos= The object that will be linked at the 1 value
		Flag= if flag == 1 it will link only on position
						  2 It will link only orientation
						  3 it will link Position and Orientation 
		****************************************************************************/
	if wireWeight==TRUE do 
	(
	 RMSetAttibutes_Polaridad Controlado
	)
	 if Flag==1 or  Flag==3 do 
		(
			PositionC=Controlado.position.controller=Position_Constraint();
			PositionC.appendTarget PesoNeg weightNeg
			PositionC.appendTarget PesoPos  weightPos
			if wireWeight==TRUE do 
			(
				paramWire.connect Controlado.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] Controlado.pos.controller[#Position_Weight_0] "if Polaridad>0 then 1-Polaridad else 1"
				paramWire.connect Controlado.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] Controlado.pos.controller[#Position_Weight_1] "if Polaridad<0 then 1+Polaridad else 1"
			)
		)
		
	 if Flag==2 or  Flag==3 do
		(
			OrientationC=Controlado.rotation.controller=Orientation_Constraint()
			OrientationC.appendTarget PesoNeg weightNeg
			OrientationC.appendTarget PesoPos  weightPos
			if wireWeight==TRUE do 
			(
			paramWire.connect Controlado.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] Controlado.rotation.controller[#Orientation_Weight_0] "if Polaridad>0 then 1-Polaridad else 1"
			paramWire.connect Controlado.modifiers[#Attribute_Holder].PolaridadParam[#Polaridad] Controlado.rotation.controller[#Orientation_Weight_1] "if Polaridad<0 then 1+Polaridad else 1"
			)
		)
	 
	)
fn RMResetTransformMatrix ObjectsArray KeepPosition:TRUE=
(
	ObjectsArray
	NSelect=ObjectsArray.count
	NewObjects=#()
	for i=0 to (NSelect-1) do 
	(
		a=Box()
		Convertto a Editable_Poly
		a.name=ObjectsArray[(NSelect-i)].name
		a.parent=ObjectsArray[(NSelect-i)].parent
		if KeepPosition==TRUE do 
			(
					a.rotation=ObjectsArray[(NSelect-i)].rotation
					a.position=ObjectsArray[(NSelect-i)].position
			)
		ChildrenArray=ObjectsArray[(NSelect-i)].children
		for j in ChildrenArray do
		(
			j.parent=a
		)
		a.EditablePoly.attach ObjectsArray[(NSelect-i)] a
		a.EditablePoly.SetSelection #Face #{1..6}
		a.EditablePoly.delete #Face
		append NewObjects a
	)
	return NewObjects
)
fn RMCreateParentPoint ObjectsArray SamePosition:TRUE SameOrientation:TRUE name:undefined GuessName:False=
	(
	if (GuessName==True ) do
				(
				if Classof ObjectsArray == Array then
					ObjName=ObjectsArray[1].name
				else 
					ObjName=ObjectsArray.name
				if RMIsNameInFormat ObjName == TRUE do
					(  
						name=RMGetFromName ObjName  3
						name=RMSetFromName ObjName 3 (name+"Parent")
						name=RMSetFromName name 4 "ctr"
					)
				)
		
	parentArray=#()
    
	if (Classof ObjectsArray) ==Array then
	(
		for i in ObjectsArray do 
		(
			 a=point()
			 RMAsigntoLayer "RiggPoints" a
			 a.size=3
			 append parentArray a
			if SameOrientation==TRUE do 
				a.rotation=i.rotation
			 if SamePosition==TRUE do
				a.position=i.position
			 if name!=undefined do
				a.name=uniquename name
			 i.parent=a
		)
	     return parentArray
	)
	else 
		(
			a=point()
			RMAsigntoLayer "RiggPoints" a
			a.size=3
			if SameOrientation==TRUE do 
				a.rotation=ObjectsArray.rotation
			 if SamePosition==TRUE do
				a.position=ObjectsArray.position
			 if name!=undefined do
				a.name=uniquename name
			ObjectsArray.parent=a
			return a
		)
		  
	  )	 
fn RMCreateChildPoint ObjectsArray SamePosition:TRUE SameOrientation:TRUE Parented:TRUE name:undefined =
	(
	a=undefined
	if (classof ObjectsArray)==Array then
	for i in ObjectsArray do 
		 (
			 a=point()
			 RMAsigntoLayer "RiggPoints" a
			 a.size=3
			 a.parent=i
			if SameOrientation==TRUE do 
				in coordsys parent a.rotation=eulerAngles 0 0 0
			 if SamePosition==TRUE do
				in coordsys parent a.position=[0,0,0]
			if Parented==False do
				a.parent=undefined
			if name!=undefined do
				a.name=name
		  )
	else
		(
			a=point()
			RMAsigntoLayer "RiggPoints" a
			 a.size=3
			 a.parent=ObjectsArray
			if SameOrientation==TRUE do 
				in coordsys parent a.rotation=eulerAngles 0 0 0
			 if SamePosition==TRUE do
				in coordsys parent a.position=[0,0,0]
			if Parented==False do
				a.parent=undefined
			if name!=undefined do
				a.name=name
		)
		return a
	  )	
fn RMCreateLineBetweenObjects obj01 obj02=
(
	if RMIsNameInFormat Obj01 then
		PointName01=RMGetFromName Obj01.name 3
	else
		PointName01=Obj01.name
	if RMIsNameInFormat Obj02 then
		PointName02=RMGetFromName Obj02.name 3
	else 
		PointName02=Obj02.name
	lineName=PointName01+"To"+PointName02+"Line"
	if RMIsNameInFormat Obj01 or RMIsNameInFormat Obj02 do
	(
		if RMIsNameInFormat Obj01 do
			ObjectsName=Obj01.name+"RefPoint"
		if RMIsNameInFormat Obj02 do
			ObjectsName=Obj02.name+"RefPoint"
		RMSetFromName ObjectsName 4 "pnt"
		RMSetFromName ObjectsName 5 "ln2p"
		PointName01=RMSetFromName ObjectsName 3 (PointName01+"LinePoint")
		PointName02=RMSetFromName ObjectsName 3 (PointName02+"LinePoint")
		RMSetFromName ObjectsName 4 "shp"
		lineName=RMSetFromName ObjectsName 3 lineName
	)
	ss=splineShape name:lineName
	addNewSpline ss
	addKnot ss 1 #corner #curve obj01.position
	addKnot ss 1 #corner #curve obj02.position
	updateShape ss
	ControlPoints=RMIKControlMod ss
	ControlPoints[1].name=PointName01
	ControlPoints[2].name=PointName02
	ControlPoints[1].parent=obj01
	ControlPoints[2].parent=obj02

	RMAsigntoLayer "RiggPoints"  ControlPoints
	RMAsigntoLayer "RiggFreezeShapes"  ss
	ss.wirecolor=color 198 225 87
	return ControlPoints
)
fn RMStretchyIK obj01 obj02 controlShape:undefined=
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
/************/RMAsigntoLayer "RiggPoints" Dummy_Leaf
Dummy_Leaf.size=8
Dummy_Leaf.box=True
Dummy_Leaf.position=hijos[i].position
SetAttibutes_Scale Dummy_Leaf

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
 RMAsigntoLayer "RiggPoints"	IKMAnip
 Elem=int hijos.count
 Elem=Elem/2
 Punto2=RMGetPoleVectorPoint  hijos
 PoleVecPosition=Punto2.position
 Punto2.rotation=hijos[1].rotation
 Punto2.position=PoleVecPosition
 PoleVectorSize=hijos[2].position.controller.X_Position*hijos.count/10
	
 Punto=RMCreateRiggControl Punto2 size:PoleVectorSize name:"UpNode" JustTheControl:true type:"cube"
 IKMAnip.controller.VHTarget=Punto
delete Punto2
 RMCreateLineBetweenObjects  Punto hijos[2]
	
if controlShape!= undefined then
	Dummy_Leaf.parent =controlShape
 return #(Dummy_Leaf,Punto)

)

fn RMCreatePointsAtShape   PShape  NumPuntos follow:False=(
	ArreglodePuntos=#()
	porcentaje=100/(NumPuntos-1)as float;
	for PuntoN=0 to (NumPuntos-1) do 
	(
		puntoNuevo=point()
		if (PuntoN!=0) do
			puntoNuevo.parent=ArreglodePuntos[PuntoN]		
/************/RMAsigntoLayer "RiggPoints" puntoNuevo
		puntoNuevo.name=("PointOn"+PShape.name+(PuntoN)as string);
		append  ArreglodePuntos puntoNuevo  
		puntoNuevo.position.controller=Path_Constraint();
		puntoNuevo.position.controller.path=PShape
		puntoNuevo.position.controller.follow=follow
		puntoNuevo.position.controller.axis=2
		puntoNuevo.rotation.controller.z_rotation=0
		puntoNuevo.rotation.controller.x_rotation=0
		puntoNuevo.rotation.controller.y_rotation=0
		deleteItem puntoNuevo.position.controller.percent.controller.keys 2
		puntoNuevo.position.controller.percent=porcentaje*(PuntoN)
		puntoNuevo.position.controller.constantVel=off
	)
return ArreglodePuntos
)


fn RMCreateCubeControl size:1 name:"CubeControl"=
(
	ss = SplineShape pos:[0,0,0]
	  addNewSpline ss
	  addKnot ss 1 #corner #line [.5*Size,.5*Size,.5*Size]
	  addKnot ss 1 #corner #line [.5*Size,.5*Size,-.5*Size]
	  addKnot ss 1 #corner #line [-.5*Size,.5*Size,-.5*Size]
	  addKnot ss 1 #corner #line [-.5*Size,-.5*Size,-.5*Size]
	  addKnot ss 1 #corner #line [.5*Size,-.5*Size,-.5*Size]
	  addKnot ss 1 #corner #line [.5*Size,-.5*Size,.5*Size]
	  addKnot ss 1 #corner #line [-.5*Size,-.5*Size,.5*Size]
	  addKnot ss 1 #corner #line [-.5*Size,.5*Size,.5*Size]
	   addKnot ss 1 #corner #line [.5*Size,.5*Size,.5*Size]
	  addNewSpline ss
	  addKnot ss 2 #corner #line [.5*Size,.5*Size,.5*Size]
	  addKnot ss 2 #corner #line [.5*Size,-.5*Size,.5*Size]
	  addNewSpline ss
	  addKnot ss 3 #corner #line [.5*Size,.5*Size,-.5*Size]
	  addKnot ss 3 #corner #line [.5*Size,-.5*Size,-.5*Size]
	  addNewSpline ss
	  addKnot ss 4 #corner #line [-.5*Size,.5*Size,.5*Size]
	  addKnot ss 4 #corner #line [-.5*Size,.5*Size,-.5*Size]
	  addNewSpline ss
	  addKnot ss 5 #corner #line [-.5*Size,-.5*Size,.5*Size]
	  addKnot ss 5 #corner #line [-.5*Size,-.5*Size,-.5*Size]
	  updateShape ss
	ss.name=uniqueName name
	return ss
)
/***************************************************************************
Función que genera un control, alineado al Objeto AlignedTo de un tamaño  Size y con un nombre dado
/***************************************************************************/
fn RMCreateRiggControl AlignedTo  size:10 name:"Control" Thickness:.1 JustTheControl:False Axis:"X" GuessName:False Type:"circle"=(
			if (GuessName==True and AlignedTo!=undefined) do
				(
					RMIsNameInFormat AlignedTo.name
					(  
						name=RMGetFromName AlignedTo.name 3
						name=RMSetFromName AlignedTo.name 3 (name+"Control")
						name=RMSetFromName name 4 "ctr"
					)
				)
			if RMIsNameInFormat name== false then
				(
					c = case Type of
					(
						"cube":RMCreateCubeControl  size:size name:name
						 default:circle render_sides:4 render_displayRenderMesh:TRUE  radius:size steps:3 name:(uniqueName name) render_thickness: Thickness
					)
					if Axis=="X" do 
					(
						c.objectoffsetrot=eulerAngles 0 90 0
						ResetXForm c
						convertToSplineShape c
					)
					if Axis=="Y" do 
					(
						c.objectoffsetrot=eulerAngles 90 0 0
						ResetXForm c
						convertToSplineShape c
					)
					BasePunto=Point  name:(uniqueName ("ResetPoint_"+name))
				)
			else 
				(
				c = case  Type of 
					(
						"cube":RMCreateCubeControl  size:size name:name	
						default:circle render_sides:4 render_displayRenderMesh:TRUE  radius:Size steps:3 name:(RMUniqueName name) render_thickness: Thickness 
					)
				if Axis=="X" do 
					(
						c.objectoffsetrot=eulerAngles 0 90 0
						ResetXForm c
						convertToSplineShape c
					)
				if Axis=="Y" do 
					(
						c.objectoffsetrot=eulerAngles 90 0 0
						ResetXForm c
						convertToSplineShape c
					)
				BasePuntoName=RMSetFromName name 3 ("ResetPoint"+(RMGetFromName name 3))
				BasePuntoName=RMSetFromName BasePuntoName 4 "pnt"
				BasePunto=Point  name:BasePuntoName
				)
			/************/RMAsigntoLayer "RiggPoints" BasePunto
			/************/RMAsigntoLayer "RiggControls"  c
			convertToSplineShape c
			c.Parent=BasePunto
			if (JustTheControl==false) then
				(
					if RMIsNameInFormat name== false then
					(
						LinkedPoint=Point  name:(uniqueName ("LinkedPoint_"+name))
					)
					else 
					(
					LinkedPointName=RMSetFromName name 3 ("LinkedPoint"+(RMGetFromName name 3))
					LinkedPointName=RMSetFromName LinkedPointName 4 "pnt"
					LinkedPoint=Point  name:LinkedPointName
					)
					RMAsigntoLayer "RiggPoints" LinkedPoint
					if AlignedTo.parent !=undefined then 
						( 
							--LinkedPoint.transform = (AlignedTo.parent).transform
							LinkedPoint.transform = AlignedTo.transform
							--LinkedPoint.position = AlignedTo.position
							LinkedPoint.parent = AlignedTo.parent
							RMParentConstraint LinkedPoint BasePunto
						)
					else
						(
							LinkedPoint.position=AlignedTo.position
							RMParentConstraint LinkedPoint BasePunto
						)
				)
				else(
						BasePunto.transform=AlignedTo.transform
					   )
				--in coordsys parent BasePunto.rotation=(eulerangles 0 -90 0)
			Return c
		)

fn RMCreateStringArray Arreglo=(
	StringArray="#($"
	for n=1 to Arreglo.count do 
	(
		StringArray=(StringArray+ (Arreglo[n].name))
		if n==Arreglo.count  then
			StringArray=StringArray+")"
		else 
			StringArray=StringArray+",$"
	)
	return StringArray
)

fn RMGetHierarchyAsArray StartNode =(
	ResultArray=#()
	append ResultArray StartNode
	while StartNode.children.count!=0 do
		(
		append ResultArray StartNode.children[1]
		StartNode=StartNode.children[1]
		)	
	return ResultArray
	)
	
fn RMCreateChainControl BoneArray WireX:True WireY:True WireZ:True WireControl:undefined =(
	ControlsArray=#()
	N=1
	if (BoneArray.count)==1 and BoneArray[1].children.count != 0 then
	(
		LenghtBone=(distance BoneArray[1] BoneArray[1].children[1])
	)
	else
		(
			LenghtBone=(distance BoneArray[1] BoneArray[BoneArray.count])/BoneArray.count
		)
	for BoneN in BoneArray do
		(
			if (BoneN.children).count!=0 do 
			(
				if BoneN.parent==undefined do
					RMCreateParentPoint BoneN
				if WireControl==undefined then 
						(
						CircularControl=RMCreateRiggControl BoneN size:LenghtBone Thickness:(LenghtBone/15) JustTheControl:True GuessName:True 
						append ControlsArray CircularControl
						)
				else 
						CircularControl=WireControl
				
				
				if (WireX==true) do 
						execute ("paramWire.connect $"+CircularControl.name+".rotation.controller[#X_Rotation] $"+BoneN.name+".rotation.controller[#X_Rotation] \"X_Rotation + degtorad "+(( in coordsys gimbal BoneN.rotation.x) as string)+" \" ")
				if (WireY==true) do 
						execute ("paramWire.connect $"+CircularControl.name+".rotation.controller[#Y_Rotation] $"+BoneN.name+".rotation.controller[#Y_Rotation] \"Y_Rotation + degtorad "+(( in coordsys gimbal BoneN.rotation.y) as string)+" \" ")		
				if (WireZ==true) do 
						execute ("paramWire.connect $"+CircularControl.name+".rotation.controller[#Z_Rotation] $"+BoneN.name+".rotation.controller[#Z_Rotation] \"Z_Rotation + degtorad "+(( in coordsys gimbal BoneN.rotation.z) as string)+" \" ")
				if   N>1 do 
					(CircularControl.parent).parent=ControlsArray[N-1]
			)
		N=N+1
		)
	if ControlsArray.count==0 do
		append ControlsArray WireControl
		
	return ControlsArray
	
	)
	
	