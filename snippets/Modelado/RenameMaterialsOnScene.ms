fn stringArrayToString Arreglo Token =
	(
	N=Arreglo.count;
	Cad ="";
	for i=1 to N do 
		(
		append Cad Arreglo[i]
	    if i<N do
			append Cad Token;
		)
	return Cad;
	)
fn SetFromName Objname flg newToken=
(
Tokens= filterString ObjName "_";
Tokens[flg] = newToken;
return  (stringArrayToString Tokens "_");
)
fn  GetFromName ObjName flg =
	(
	Tokens=filterString ObjName "_";
	return Tokens[flg];
	)
MaterialesEnEscena = SceneMaterials
SceneName = filterString MaxFileName "."
Prefix = GetFromName SceneName [1] 1
for i in MaterialesEnEscena do 
(  --i.name=Prefix + "_"+i.name +"_mat"
	i.name = setFromName i.name 1 Prefix
)





