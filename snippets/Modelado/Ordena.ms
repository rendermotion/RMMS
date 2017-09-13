Lineas=selection as array
n=1

for n=1 to Lineas.count do 
	(
    if n!= 1 do 
		(
		  ancho=Lineas[n-1].max.Y-Lineas[n-1].min.Y
		  anchocurrent=Lineas[n].max.Y-Lineas[n].min.Y
		  Lineas[n].position.y = Lineas[n-1].position.y+(ancho/2+anchocurrent/2)+.1
		  
		)
		Lineas[n].position.z=0
	n=n+1
	)