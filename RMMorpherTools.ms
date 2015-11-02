/**************
Esta Funcion acepta un objeto obj que tiene un morpher y una cadena que es el nombre del morpher, 
La funcion regresa el numero del canal donde se encuentra este Morpher
************************/
--NumMorpher
fn RMGetMorphIndex Obj MorphName=
(
retVal=0;
i=1;
while (i<100) do 
	(ChannelName=WM3_MC_GetName Obj.modifiers["Morpher"] i
	if ChannelName ==MorphName do
		(
		retVal=i
		i=100;
		)
	if ChannelName=="- empty -" do
		i=100;
	i=i+1;
	)
return retVal
)

/**********************
Funcion regresa True  Si existe un modificador Morpher aplicado en el objeto
***********************/
	--existeMorpher
fn RMMorpherExist Obj=
	(
		if Obj.modifiers["Morpher"]!=undefined then
				return true
		else 
				return false;
	)
/**************************************************/