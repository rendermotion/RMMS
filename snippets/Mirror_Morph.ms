global loadedmeshvert
global ForMirrormeshvert
global face
global a
global num_faces

fn Mirror_Morph axis=(
face_array = #()
if axis=="x" do
	axis_n=1
if axis=="y" do
	axis_n=2
if axis=="z" do
	axis_n=3

numvert=ForMirrormeshvert.numVert

for v=1 to numvert do
			(
			encontro=0
			for a=1 to numvert do
			  		if ((loadedmeshvert[v])[axis_n] == loadedmeshvert[v].y )and loadedmeshvert[v].z ==  loadedmeshvert[v].z and loadedmeshvert[].x== -loadedmeshvert[].x do
							(
							 encontro=1
							 a = numvert
							)
				if encontro == 0 do
						(
						ErrorVar = 1
						format ("x  = "+( loadedmeshvert[x_pVertices[v]] as string ))
						v= numvert
						)
				)
	)
else 
	ErrorVar=1
)

fn loadForMirror obj =(

ForMirrormeshvert=in coordsys local SnapshotAsMesh obj

if a==ForMirrormeshvert.numverts and num_faces==ForMirrormeshvert.numfaces then
	 messagebox ("Mirror Mesh Loaded")
else
	 messagebox ("Error al cargar para mirror")

)

fn loadSymmesh obj = (
obj.position = [0, 0, 0]
LoadedMesh=in coordsys local SnapshotAsMesh obj
a=LoadedMesh.numverts
num_faces=LoadedMesh.numfaces
face=#()
for f = 1 to num_faces do
(
face[f] = getFace LoadedMesh f
)
Loadedmeshvert=#()
x_pVertices=#()
x_nVertices=#()
y_pVertices=#()
y_nVertices=#()
z_pVertices=#()
z_nVertices=#()
x_p = 0
x_n = 0
y_p = 0
y_n = 0
z_p = 0
z_n = 0
for v=1 to a  do 
	(
	append Loadedmeshvert (getvert LoadedMesh v)
	if loadedmeshvert[v].x > 0 do
		(
		x_p = x_p+1
		append x_pVertices v
		)
	if loadedmeshvert[v].x  < 0 do
		(
		x_n = x_n+1
		append x_nVertices v 
		)

	if loadedmeshvert[v].y > 0 do
		(
		y_p = y_p+1
		append y_pVertices v 
		)
	if loadedmeshvert[v].y < 0 do
		(
		y_n=y_n+1
		append y_nVertices v 
		)
	if loadedmeshvert[v].z  > 0 do
		(
		z_p=z_p+1
		append z_pVertices v 
		)
	if loadedmeshvert[v].z  < 0 do
	    (
		z_n=z_n+1
		append z_nVertices v
		)
	format ((loadedmeshvert[v] as string) + "\n")
	)
	
ErrorVar=0
if (x_pVertices.count==x_nVertices.count) then
	(
	numvert=x_pVertices.count
	for v=1 to numvert do
				(
				encontro=0
				for a=1 to numvert do
				  		if (loadedmeshvert[x_nVertices[a]].y == loadedmeshvert[x_pVertices[v]].y )and loadedmeshvert[x_nVertices[a]].z ==  loadedmeshvert[x_pVertices[v]].z and loadedmeshvert[x_pVertices[a]].x== -loadedmeshvert[x_nVertices[v]].x do
							(
							 encontro=1
							 a = numvert
							)
				if encontro == 0 do
						(
						ErrorVar = 1
						format ("x  = "+( loadedmeshvert[x_pVertices[v]] as string ))
						v= numvert
						)
				)
	)
else 
	ErrorVar=1

if  ErrorVar==0 do
	messagebox ("simetria en x")

ErrorVar=0
if (y_pVertices.count==y_pVertices.count) then
	(
	numvert=y_pVertices.count
	for v=1 to numvert do
				(
				encontro=0
				for a=1 to numvert do
				  		if loadedmeshvert[y_nVertices[a]].x ==loadedmeshvert[y_pVertices[v]].x and loadedmeshvert[y_nVertices[a]].z == loadedmeshvert[y_pVertices[v]].z and loadedmeshvert[y_pVertices[a]].y== - loadedmeshvert[y_nVertices[v]].y do
							(
	 						 encontro=1
	 						 a = numvert
	 						)
	 			if  encontro ==0 do
						(
	 					ErrorVar=1
						format ("y  = "+( loadedmeshvert[x_pVertices[v]] as string ))
	 					v= numvert
						)
				)
	)
else 
	ErrorVar=1
if ErrorVar == 0 do
	messagebox ("simetria en y")

if (z_pVertices.count==z_nVertices.count) then
	(
	numvert=z_pVertices.count
	for v=1 to numvert do
				(
				encontro=0
				for a=1 to numvert do
				  		if loadedmeshvert[z_nVertices[a]].x ==loadedmeshvert[z_pVertices[v]].x and loadedmeshvert[z_nVertices[a]].y == loadedmeshvert[z_pVertices[v]].y and loadedmeshvert[z_pVertices[a]].z== - loadedmeshvert[z_nVertices[v]].z do
							(
	 						 encontro=1
	 						 a = numvert
	 						)
	 			if encontro ==0 do
						(
	 					ErrorVar=1
						format ("z  = " + ( loadedmeshvert[x_pVertices[v]] as string ))
	 					v= numvert
						)
				)
	)
else 
	ErrorVar=1

if ErrorVar == 0 do
	messagebox ("simetria en z")



)
/**************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************/

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

