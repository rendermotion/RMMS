	fn  GetFromName ObjName flg =
		(
		Tokens=filterString ObjName "_";
		return Tokens[flg];
		)
	MaterialesEnEscena = SceneMaterials
	SceneName = filterString MaxFileName "."
	Prefix = GetFromName SceneName [1] 1
	for i in MaterialesEnEscena do 
		i.name=Prefix + "_"+i.name +"_mat"