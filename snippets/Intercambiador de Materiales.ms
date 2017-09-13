--Este script es para facilitar la salida que necesitamos a la hora de hacer el render
--y asi facilitarnos la composicion del render final

--Declaracion de Variables

Global 	Ocluda = undefined
Global 	Clr = undefined
Global 	Zetad = undefined
Global 	Delig = undefined
Global  samplesocluda= bezier_float()
global	mdistanceocluda= bezier_float()
--Creando El Rollout de Salida

Rollout TipoSalida "Tipo de Salida"
	(

	Group "Mat. Salida"
		(
		Checkbox OdAS "Oclusion de Ambiente" across:1
		Spinner Samplesoclu "Samples:" range:[0,1000,0] scale:10 controller:samplesocluda align:#left offset:[0,0] width:100 across:2
		Spinner Mdistance "Max Distance:" range:[0,100000002004087730000.0,0] scale:.01 controller:mdistanceocluda align:#rigth offset:[15,0] width:100 across:2
		Checkbox ColorS "Color" across:2 	
		Checkbox FogZde "Z-Debth" across:2 
		Checkbox LuzDir "D-ligth" across:2 
		)
		on OdAS changed theState do Ocluda = 1 
		on ColorS changed theState do Clr = 1
		on FogZde changed theState do Zetad = 1
		on LuzDir changed theState do Delig = 1
			
	)
			
--Funcion de Conversion de materiales
	
	function ChangeMaterial a=
		(
			if classof a==Multimaterial then
			(
				for i=1 to a.numsubs do
			    	a[i]=ChangeMaterial(a[i])
				return 	a;
				)
			else
			(
			if classof a==VrayMtl then
				(
				CO=color 0 0 0
				if a.Refraction!=CO then
						return meditMaterials["Vidrio"]
				else(
					if (a.texmap_bump==undefined) and (a.texmap_opacity==undefined) then 
						(
						return meditMaterials["OclusionDefault"]
						)
					else
						(
						Nmat=Arch___Design__mi()
						if a.texmap_bump!=undefined do
							Nmat.bump_map=a.texmap_bump
						if a.texmap_opacity!=undefined do
							Nmat.cutout_map=a.texmap_opacity
						Nmat.diff_color=color 255 255 255
						Nmat.refl_weight = 0
						Nmat.opts_ao_on = TRUE
						Nmat.opts_ao_samples = 40
						Nmat.opts_ao_distance = 15
						Nmat.opts_ao_dark=color 0 0 0
						Nmat.opts_ao_ambient=color 255 255 255
						return Nmat
						)
					)
				)
			else
				return meditMaterials["OclusionDefault"]
			)
		)

--Boton de Conversion de Materiales

Rollout IM_Convertir "Convertir"
(
	Button Convertidor "Convertir" width:194 align:#center
	on Convertidor pressed do
	(
	
	if Ocluda == 1 then
	   (
	   for g in objects do 
    		g.material=ChangeMaterial g.material
	   )		
	if Clr == 1 then
 		messagebox ("Color checked")
	
	if Zetad == 1 then
 		messagebox ("Z depth checked")
	
	if Delig == 1 then
 		messagebox ("Direct Ligth checked")
			
	)
)
	
IM_Floater = NewRolloutFloater "Intercambiador de Materiales" 275 400

AddRollout TipoSalida IM_Floater
AddRollout IM_Convertir IM_Floater