Objetos=selection as array
g=Objetos[1]
copia=#()
for i=2 to Objetos.count do
	(   
		if (classof Objetos[i].baseobject!=SplineShape) do
			convertTo Objetos[i] SplineShape
		maxOps.CloneNodes g newNodes:&copia
		f=copia[1]
		f.modifiers["Path_Deform_Binding"].path=Objetos[i] 
		lengthArray=getSegLengths  Objetos[i] 1
		f.modifiers["Path_Deform_Binding"].Stretch=lengthArray[lengthArray.count]
		f.transform = Objetos[i].transform
	)
	
 
	
 

/*showproperties $.modifiers["Path_Deform_Binding"]
  .axis : integer
  .rotation : angle
  .Twist : angle
  .Stretch : float
  .path : node
  .Percent_along_path : percent
  .Flip_deformation_axis : integer
false*/
