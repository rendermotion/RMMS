rollout unnamedRollout "Untitled" width:275 height:415
(
	
	MultiListBox lbx1 "ListBox" pos:[12,60] width:255 height:11 items:#("Hola", "Mundo", "Saludos", "Daniel") selection:1
	button btn1 "Button" pos:[14,19] width:83 height:27
	editText edt1 "" pos:[10,278] width:255 height:108
	on btn1 pressed  do
	( Seleccionados=lbx1.selection
		Cadena="";
		for elementos in Seleccionados do
			 Cadena=Cadena+elementos as string
		if Existe Seleccionados 2 then 
			edt1.text=Cadena
		else 
			edt1.text="no existe el elemento 2"
	)
)
createdialog unnamedRollout 300 450;

fn Existe Arreglo elemento=
	(
		for contenido in Arreglo do 
			if elemento==contenido do
				return true;
		return false;		
		)
