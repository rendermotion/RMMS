rollout rename_rollout "Renombra Materiales"
		(
		edittext base_name "" 
		button rename_them "RENOMBRAR" 

		on rename_them pressed do
		(
		n=0
		if base_name.text != "" then
			for i in meditMaterials do 
				(	
				i.name = base_name.text+"_"+ (n as string)+"_"
					if 	classof i==Multimaterial then
					(
						f=0
							for j=1 to i.numsubs do
							(	
								a=i[j]
								a.name=base_name.text+"_"+ (n as string)+"_"+(f as string)+"_"
								f=f+1
							)
					)	

				n=n+1;
				)
		)--end on
		)--end rollout
		createDialog rename_rollout 250 50