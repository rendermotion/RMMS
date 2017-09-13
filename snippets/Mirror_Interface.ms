/*********************************************************************************************/
/****FUncion que  checa la simetria de un objeto suma las posiciones de todos los vertices****/
/**** y si el promedio es 0 es simetrico en el eje que la suma resulte 0***************************/
/*********************************************************************************************/
fn SimAxis obj=(
Orpos=obj.position
obj.position = [0, 0, 0]
LoadedMesh=in coordsys local SnapshotAsMesh obj
num_Vertices=LoadedMesh.numverts
num_faces=LoadedMesh.numfaces
Loadedmeshvert=#()
axis=[0 , 0 , 0]
for i=1 to num_Vertices do
	(
	append Loadedmeshvert (getvert LoadedMesh i)
	for a=1 to 3 do 
		(
		axis[a]=axis[a] + Loadedmeshvert [i][a]
		)
	)
res=0
if axis[1]>-.0001 and axis[1]<.0001 do
	 (
	  res = res+1
	 )
if axis[2]>-.0001 and axis[2]<.0001 do
	(
	res = res + 2
	)
if axis[3]>-.0001 and axis[3]<.0001 do
	(
	res = res + 4
	)
print "res" 
print res
return res
)
/*********************************************
/* compara dos vertices si los vertices son contraparte en algun eje regresa 1 en caso afirmativo
/**********************************************/
fn contraparte v1 v2 axis =(
symetria=0
for i=1 to 3 do 
	(
	if i!=axis then 
		symetria=symetria+v1[i]-v2[i]
	else 
		symetria=symetria+v1[i]+v2[i]
	)
if symetria >-.001 and symetria <.001 then
	(
	return 1
	)
else 
	(
	return 0
	)
)
/*****************************************************************************/
/*Esta funcion Crea una tabla de correspondencia de vertices,                */
/*recibe un objeto y regresa un vector en el que indica que vertice corresponde a cual en el mismo eje
/**obj es el objeto que recibe y axis el eje del que se quiere la tabla de correspondencias*/
/*******************************************************************/
fn Create_CorrespTable obj axis=(
Orpos=obj.position
obj.position = [0, 0, 0]
LoadedMesh=in coordsys local SnapshotAsMesh obj
num_Vertices=LoadedMesh.numverts
num_faces=LoadedMesh.numfaces
Loadedmeshvert=#()
ArreglodeVert=#()
for i=1 to num_Vertices do
	(
	f=getvert LoadedMesh i
	append Loadedmeshvert (getvert LoadedMesh i)
	flag=0
	print "****************************"
	print f
	print "f"
	n=Loadedmeshvert.count
	for j=1 to n  do 
  		(
		k=Loadedmeshvert[j]
		print k
		if ((contraparte k f axis)==1)and j!=i do
			(
			print "contraparte"
			cntrap=[j,i]
			append ArreglodeVert cntrap
			flag=1
			)
		)
	)
return ArreglodeVert
)
/*****************************************************************************/
/*****************************************************************************/
fn CreaMirror coresptable Symmesh FormirrorMesh axis=(
Orpos=Symmesh.position
Symmesh.position = [0, 0, 0]
LoadedSymMesh=in coordsys local SnapshotAsMesh Symmesh
Symmesh.position=orpos

Orpos=FormirrorMesh.position
FormirrorMesh.position = [0, 0, 0]
LoadedFMMesh= in coordsys local SnapshotAsMesh FormirrorMesh
FormirrorMesh.position =Orpos

num_Vertices=LoadedSymMesh.numverts
num_faces=LoadedSymMesh.numfaces
Loadedmeshvert=#()
LoadedmeshFace = #()
for i=1 to num_Vertices do
	(
	append Loadedmeshvert (getvert LoadedSymmesh i)
	)
for i=1 to num_faces do
	(
	append LoadedmeshFace (getFace LoadedSymMesh i)
	)
	n=coresptable.count
for i in coresptable do
	(
	a=getvert LoadedFMMesh i[1]
	b=getvert LoadedFMMesh i[2]
	c=[0,0,0]
	d=[0,0,0]
	for j=1 to 3 do 
		(
			if j!=axis then 
				(
				c[j]=b[j]
				d[j]=a[j]
				)	
			else
				(
				c[j]=-b[j]
				d[j]=-a[j]
				)
			)
		Loadedmeshvert[(i[1])]=c
		Loadedmeshvert[(i[2])]=d
		)
new_mesh = mesh vertices:Loadedmeshvert faces:LoadedmeshFace
update new_mesh
)
rollout test "Test"
(
 pickbutton btn_LoadSymmesh "Cargar Mesh Simetrico"
 pickbutton btn_Load "Cargar Mirror Target"
 radiobuttons Mirror_type labels:#("X", "Y", "Z")
 
 button btn_Mirror "Crear Mirror"

on btn_LoadSymmesh picked obj do 
	(
     loadSymmesh obj
	 )
on btn_Load picked obj do 
	(
	 loadForMirror obj
	 )
on btn_Mirror pressed do 
	(
	case Mirror_type.state of
		(
		1:Mirror_Morph "x"
		2:Mirror_Morph "y"
		3:Mirror_Morph "z"
		)
	)
)
nf = newRolloutFloater "Test" 200 200
addRollout test nf
