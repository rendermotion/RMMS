fn CreatePointCoplanar  Bone01 Bone02 =(
	Vector01=Bone01.position-Bone02.position
	Vector02=Bone02.position - Bone02.children[1].position
	print "Vectores"
	print Vector01
	print Vector02
	print (acos (dot (Normalize Vector01) (Normalize Vector02))) as string
	Angulo=(acos (dot (Normalize Vector01) (Normalize Vector02))+180)/2
	print ("Angulo="+Angulo as string)
	Punto=point ()
	Punto.parent=Bone02
	--Punto.rotation=Bone02.rotation
	--in coordsys world Punto.position=Bone02.children[1].position
	Punto.transform=Bone02.children[1].transform	
	
	print ("ProductoCrus="+(Normalize (cross Vector01 Vector02) as string))
	
	d=(Normalize (cross Vector01 Vector02) )
	MatrizB2=Bone02.transform
	PosB2Z1=pretranslate MatrizB2 (point3 0 0 1)
	print"posB2Z1"
	print PosB2Z1.position
	VectorZ=PosB2Z1.position-Bone02.position
	normalize VectorZ
   	Print "Vectores"
	print VectorZ
	print d
	if CompTolerancia d[1] VectorZ[1] .001 and CompTolerancia d[2] VectorZ[2] .001  and CompTolerancia d[3] VectorZ[3] .001 then
		(
		in coordsys parent Punto.rotation=eulerangles 0 0 Angulo	
		print "Son iguales"
		)
	else
		(
		in coordsys parent Punto.rotation=eulerangles 0 0 -Angulo	
		print "Son diferentes"
		)
return Punto
)
fn CompTolerancia a b tolerancia=(
	
	if (a-b)<tolerancia and (a-b)>-tolerancia then 
		return true
	else 
		return false
)

CreatePointCoplanar $[1] $[2]