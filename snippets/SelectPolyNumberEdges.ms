function SeleccionaPoly LookFor obj=(

Convertto obj Editable_Poly
Polyop.getEdgesUsingFace
Ncaras=polyop.getNumFaces obj
CarasASeleccionar=#()

for i=1 to Ncaras do 
(
Nedges=(polyop.getFaceEdges obj i)
   if LookFor==Nedges.count do
	append CarasASeleccionar i
)

polyop.setFaceSelection obj CarasASeleccionar
Select Obj
subObjectLevel = 4
)

rollout NpolyRollout "NPoly" width:130 height:95
(
	spinner Spinner01 "" pos:[14,12] width:84 height:16 type:#integer
	button Selecciona "Selecciona" pos:[15,50] width:80 height:24
hyperlink rm "www.rendermotion.com" address:"www.rendermotion.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181) align:#center pos:[5,80]

	on Selecciona pressed do
	(
	SeleccionaPoly Spinner01.value $
	)
)
SeleccionaNpoly=newRolloutFloater "SeleccionaNlados" 135 125
addRollout NpolyRollout SeleccionaNpoly
