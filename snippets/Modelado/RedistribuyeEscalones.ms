rollout RolloutEscaleras "Distribuye" width:171 height:274
(

	GroupBox grp1 "Por Incremento" pos:[8,9] width:159 height:65
	
	spinner spnIncremento "Incremento    " range:[-10000,10000,0] pos:[35,33] width:112 height:16 type:#worldunits toolTip:"Este valor no tiene efecto, si el checkbox de Altura Maxima esta encendido"
  
	GroupBox grp2 "Por Altura Maxima" pos:[9,80] width:158 height:64
	
	spinner spnAlturaMax "Altura Maxima " range:[-10000,10000,0]  pos:[53,96] width:111 height:16 type:#worldunits toolTip:"Solamente es tomado en cuenta este valor cuando esta encendido el checkbox de la derecha "
	
	checkbox UsaAltura "" pos:[16,96] width:17 height:18 toolTip:"Cuando esta encendido utiliza Altura Maxima para calcular el Incremento, el valor de incremento no es tomado encuenta"
	
	checkbox chkAltMO "   Escalones + 1" pos:[16,120] width:100 height:18 toolTip:"cuando esta habilitado la distancia entre los escalones es igual a la Altura / Escalones +1"
	
	button BtnDistribuye "Distribuye" pos:[4,164] width:162 height:24
	button BtnReset "Rese a Z 0" pos:[5,196] width:79 height:24 
 
	button BtnResettoMin "Reset a Z Min" pos:[87,196] width:79 height:24

	HyperLink rm "www.rendermotion.com" pos:[30,233] width:111 height:15 address:"www.rendermotion.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181)
	HyperLink dp "www.diplomados3d.com" pos:[28,251] width:115 height:15 address:"www.diplomados3d.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181)
	
	local ChkPeValue=TRUE
	
	on chkAltMO changed NewValue do
	(
		
		ChkPeValue=chkAltMO.checked
		print ChkPeValue
	)

	on UsaAltura changed NewValue do
	(
	     if NewValue==false then(
			spnIncremento.enabled=true
			spnAlturaMax.enabled=false
			chkAltMO.triState=2
			 )
		 else (
			spnIncremento.enabled=false
			spnAlturaMax.enabled=true
			if ChkPeValue==TRUE then 
				chkAltMO.triState=1
			else 
				chkAltMO.triState=0
			 )
		)
	on BtnDistribuye pressed do
	(
		if UsaAltura.checked==false then
		(
				Incremento=spnIncremento.value
				Nescalones=selection.count
				n=1
				for i in selection do
					(
						move i [0,0,Incremento*n]
						n+=1
					)
			
		)
		else 
		(	
			if chkAltMO.checked ==false then 
			(
				Altura=spnAlturaMax.value
				Nescalones=selection.count
				Incremento=Altura/Nescalones;
				n=1
				for i in selection do
					(
						move i [0,0,Incremento*n]
						n+=1
					)
			)	
			else
			(
				Altura=spnAlturaMax.value
				Nescalones=selection.count+1
				Incremento=Altura/Nescalones
				n=1
				for i in selection do
					(
						move i [0,0,Incremento*n]
						n+=1
					)
			)
		)
	)
	on BtnReset pressed do
	(
		for i in selection do
			(
				i.position.z=0
			)
	)
	on BtnResettoMin pressed do
	(  
		if selection.count > 0 do
		(
			minZ=selection[1].position.z
			for i in selection do
				(
					if minZ>i.position.z do
						minZ=i.position.z
				)
			for i in selection do
				(
					i.position.z=minZ
				)
		)
	)
)
FloaterEscaleras = newRolloutFloater "Redistribuye" 200 300
addRollout    RolloutEscaleras FloaterEscaleras
c=RolloutEscaleras.controls[4]
c.enabled = false
d=RolloutEscaleras.controls[6]
d.triState = 2

