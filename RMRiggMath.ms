/*Esta función regresa un arreglo con los números de bits que estan en 1, basado en un arreglo de bits */
fn RMBitArrayToArray BitArrayValues=
(
n=0
ResultArray=#()

	for n=1 to BitArrayValues.count do
	(
		if BitArrayValues[n] == true do
			append ResultArray (n)
	)
return ResultArray
)


fn  RMquicksort NumericArray =
	(
		if NumericArray.count <= 1 then
			return NumericArray 
		else 
			(
			   pivotIndex=NumericArray.count/2
			   pivotValue=NumericArray[NumericArray.count/2]
				ArrayMinValues=#()
				ArrayMaxValues=#()
				for i=1 to NumericArray.count do
					(
						if  i != pivotIndex  do
								if NumericArray[i] > NumericArray[pivotIndex] then 
									append ArrayMaxValues NumericArray[i]
								else
									append ArrayMinValues NumericArray[i]
					)
			return (quicksort ArrayMinValues +#(pivotValue)+ quicksort ArrayMaxValues)
			)
	)

fn RMCompTolerancia a b tolerancia=(
	
	/**************************************
	Compara 2 valores con una tolerancia es usado en algunas funciones para comparar valores muy parecios.
	***************************************/
	if (a-b)<tolerancia and (a-b)>-tolerancia then 
		return true
	else 
		return false
)
fn RMGetDirVector Obj Axis:"x"=(
	
	ReferencePoint = point()
	ReferencePoint.transform=Obj.transform
	
	if (Axis=="x" or  Axis=="X")do
		in coordsys local (move ReferencePoint [1, 0,0])
	if (Axis=="y" or  Axis=="Y")do
		in coordsys local (move ReferencePoint [0,1,0])
	if (Axis=="z" or  Axis=="Z")do
		in coordsys local (move ReferencePoint [0,0,1])
	vector=normalize (ReferencePoint.position-Obj.position)
	delete ReferencePoint
	return vector
	)
	
	
	
fn RMObjLookXAtPoint Obj01 Vector =(
	/*****************************************
	This function receives a Object and it rotates it
	so it's x axis ends up aligned to the vector 
	*******************************************/
	print Vector
	longitud=length(Vector *[1,1,0])

	if  Vector[1] > 0 then
		Rz=asin (Vector[2]/longitud)
	else 
		Rz=180-asin (Vector[2]/longitud)
	longitud=length Vector
	Ry=asin (Vector[3]/longitud)
	Obj01.rotation=eulerAngles 0 0 0
	rotate Obj01 (eulerAngles 0 -Ry Rz)
	
)
fn RMGetVectorsAngle v1 v2 =
(
	/*****************************************
	This function Calculates the angle between the vectors V1 and V2
	*******************************************/
return acos(dot (normalize v1) (normalize v2))
)
fn RMGetPoleVectorPoint BoneArray name:"PoleVector"=
(
		/*This functions calculates the position of a pole Vector Point And Return the point 
		It receives an array of tree objects*/
		P1=BoneArray[1].position
		P2=BoneArray[2].position
		P3=BoneArray[3].position
		V1=P2-P1
		V2=P3-P2
		Angulo=RMGetVectorsAngle V1 V2
		print "AnguloV3= "
		AnguloV3=(Angulo+180)/2
		print "Angulo= "
		Angulo=AnguloV3-90
		EjeZ=normalize(cross (normalize V1) (normalize V2))
		EjeY=normalize(cross (normalize V2) (normalize EjeZ))
		EjeX=normalize V2
		Y1=cos Angulo 
		X1=-sin Angulo
		Vy=EjeY*Y1
		Vx=EjeX*X1
		VRes=Vx+Vy
		LongitudPromedio=(length V1+length V2)/2
		VRes=VRes*LongitudPromedio
		PoleVector=VRes+P2
		pv=point name:(uniquename name)
		pv.position=PoleVector
		return pv
)