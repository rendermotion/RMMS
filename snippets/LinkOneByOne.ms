nelementos=selection.count
if mod nelementos 2 ==0 then
	for i=1 to nelementos/2 do 
		(
		selection[i].parent=selection[nelementos/2+i]
		selection[i].position=selection[nelementos/2+i].position
		)

else 
	format "Selecciona un numero par de elementos"
