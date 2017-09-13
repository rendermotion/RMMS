fn Anima_PathDeform ConstTime=(
for Elemsel in selection do
	(if Elemsel.modifiers["Path_Deform_Binding"].stretch.controller !=Bezier_Float do 
			Elemsel.modifiers["Path_Deform_Binding"].stretch.controller=Bezier_Float();
		KeyControl=Elemsel.modifiers["Path_Deform_Binding"].stretch.controller.keys
		
		if keyControl.count==0 do
			addNewKey KeyControl 0	
		for keyN=2 to KeyControl.count do
			deleteItem $.modifiers["Path_Deform_Binding"].stretch.controller.keys keyN
		VarScaleTime=((KeyControl[1].value*ConstTime) as integer)
		addNewKey KeyControl VarScaleTime
		KeyControl[1].value=0
	)
)
Anima_PathDeform 5
