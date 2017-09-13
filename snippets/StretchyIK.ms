Longitud_Total=39.8327
Longitud_Inicial=19.5332
Node_Huesos=2
a=in coordsys world Root.position 
b=in coordsys world Leaf.position 
print a
print b
movFinal=0
if (distance a b)<Longitud_Total then
	movFinal=Longitud_Inicial
else 
	movFinal=Longitud_Inicial+((distance a b)-Longitud_Total)/Node_Huesos
movFinal