--"Auto IK Stretch Script" written by Tyson Ibele based on the original
--script controller by Michael Comet (comet-cartoons.com)

try(destroydialog autoIKRollout)catch()

global lowerleg
global endbone
global ikchainpoint
global IKscript
global distance1
global numbones1
global parentbones = #()


rollout autoIKrollout "Auto IK Stretch"
(
	button autoik "Make the chain stretchy!" width:150 height:30
	checkbox check1 "Allow negative stretch" align:#center
	button noik "Remove Stretch" width:150 height:30
	label line1 "-------" align:#center
	label label0 ""
	label label1 "Select an Ik Chain point and click the buttons"
	label label2 "above to make the chain stretchy, or to remove"
	label label25 "previously-applied stretch!"
	label label3 " "
	label label6 "All questions, comments and suggestions can "
	label label7 "be emailed to tyson@tysonibele.com"
	hyperlink tysonEmail "www.tysonibele.com" color:blue hovercolor:red address:"http://www.tysonibele.com" align:#center
	
	on autoik pressed do
	(
		if selection != undefined then
		(
			ikchainpoint = selection[1]
			ikchainpointfixindex = 1
			while ikchainpointfixindex != undefined do
			(
				ikchainpointfixindex = findstring (ikchainpoint.name as string) " "
				ikchainpointfix = (ikchainpoint.name as string)
				if ikchainpointfixindex != undefined then
					ikchainpoint.name = ((replace ikchainpointfix ikchainpointfixindex 1 "_") as name)
			)		
			ikchainpoint.name = uniquename ikchainpoint.name			
			
			
			endbone = ikchainpoint.controller.endjoint
			startjoint = ikchainpoint.controller.endjoint
			numbones1 = 0
			while startjoint != ikchainpoint.controller.startjoint do
			(
				startjoint = startjoint.parent
				numbones1 += 1
			
			)
			parentbones[1] = endbone.parent
			parentbones.count = 1
			for i in 1 to (numbones1-1) do
			(
				parentbones[i+1] = parentbones[i].parent	
					
			)
			for j in 1 to numbones1 do
			(
				parentbonesfixindex = 1
				while parentbonesfixindex != undefined do
				(
					parentbonesfixindex = findstring (parentbones[j].name as string) " "
					parentbonesfix = (parentbones[j].name as string)
					if parentbonesfixindex != undefined then
						parentbones[j].name = ((replace parentbonesfix parentbonesfixindex 1 "_") as name)
				)
				
			)
	
			endbonefixindex = 1
			while endbonefixindex != undefined do
			(
				endbonefixindex = findstring (endbone.name as string) " "
				endbonefix = (endbone.name as string)
				if endbonefixindex != undefined then
					endbone.name = ((replace endbonefix endbonefixindex 1 "_") as name)
			)		
			endbone.name = uniquename endbone.name
			for k in 1 to parentbones.count do
			(
				parentbones[k].name = uniquename parentbones[k].name
			)
		
			if endbone != undefined and ikchainpoint != undefined then
			(
				in coordsys world distance1 = (distance ikchainpoint.pos parentbones[1].pos)
				
				chainCA = attributes chain
				(
					parameters main rollout:params
					(
						stretchval type:#float ui:sval
						checkval type:#boolean ui:chval
						smoothcheck type:#boolean ui:cval
						smoothmult type:#float ui:mval
					)
					
					rollout params "Extra Stretch Parameters"
					(
						spinner sval "Stretch Value: " type:#float range:[-400,400,0]
						checkbox chval "Allow negative stretch" type:#boolean align:#center
						label label1 "----"
						checkbox cval "Enable Smooth Stretch" 
						spinner mval "Smoothness: " type:#float range:[0,2.5,1]
						
					
					)
				)
				custattributes.delete ikchainpoint 1
				custAttributes.add ikchainpoint chainCA
				$.smoothcheck = true
				$.smoothmult = 1
				if check1.checked == true then $.checkval = true else $.checkval = false
				for k in 1 to (parentbones.count - 1) do
				(
					parentbones[k].position.controller=Position_XYZ()
					parentbones[k].position.controller=position_list()
					parentbones[k].position.controller.available.controller=position_xyz()
					parentbones[k].position.controller[1].controller.x_position.controller=float_script()

					
				)
				endbone.position.controller=Position_XYZ()
				endbone.position.controller=position_list()
				endbone.position.controller.available.controller=position_xyz()
				endbone.position.controller[1].controller.x_position.controller=float_script()	
							
				for m in 1 to parentbones.count-1 do
				(
					in coordsys world distance1 = distance1 + (distance parentbones[m] parentbones[m+1]) 			
				
				)
				initScale = abs(parentbones[parentbones.count].scale[1])
		
		
				IKscript = ("d = distance topLevelBone.pos ikChainPoint1.pos
							
							scale1 = abs(toplevelBone.scale[1])
							distance2 *= scale1/initscale
							st = (d - distance2)
							
							if ikChainPoint1.checkval != true then
							(
								if (st < 0) then st = 0 							
							)
							
							if ikChainPoint1.smoothcheck == true and ikChainPoint1.checkval != true then
							(
								value = -(abs(distance2 - d)/distance2) - .5
								value *= 5 
								
								mult = 2.71 / (ikChainPoint1.smoothmult)
								if mult < 1 then mult = 1
								amount2 = (1/(sqrt(3.14 )))*(mult)^-(((value)^2)/2)
								
								amount2 *= (distance2/3) * 2
							
							)else amount2 = 0
							amount2 = abs(amount2)
							amount = ((st  + amount2)/count1)
															
							(orig1 + amount/scale1)")
		
					
				for q in 1 to (parentbones.count-1) do
				(
						
								
				parentbones[q].position.controller[1].controller.x_position.controller.addnode "topLevelBone" parentbones[parentbones.count]
				parentbones[q].position.controller[1].controller.x_position.controller.addnode "ikChainPoint1" ikchainpoint
				parentbones[q].position.controller[1].controller.x_position.controller.addnode "endbone" endbone
				parentbones[q].position.controller[1].controller.x_position.controller.addconstant "distance2" distance1
				parentbones[q].position.controller[1].controller.x_position.controller.addconstant "orig1" (parentbones[q].position.controller[1].controller.x_position.controller.script as float)
				parentbones[q].position.controller[1].controller.x_position.controller.addconstant "count1" (parentbones.count as integer)
				parentbones[q].position.controller[1].controller.x_position.controller.addconstant "initScale" initScale
				
				
				parentbones[q].position.controller[1].controller.x_position.controller.script = IKscript
				
				paramWire.connect ikchainpoint.baseObject.chain[#stretchval] parentbones[q].transform.controller.FK_Sub_Control.controller.Position.controller[2].controller[#X_Position] "stretchval"
				
				)			
				
				
				endbone.position.controller[1].controller.x_position.controller.addnode "topLevelBone" parentbones[parentbones.count]
				endbone.position.controller[1].controller.x_position.controller.addnode "ikChainPoint1" ikchainpoint
				endbone.position.controller[1].controller.x_position.controller.addnode "endbone2" endbone
				endbone.position.controller[1].controller.x_position.controller.addconstant "distance2" distance1
				endbone.position.controller[1].controller.x_position.controller.addconstant "orig1" (endbone.position.controller[1].controller.x_position.controller.script as float)
				endbone.position.controller[1].controller.x_position.controller.addconstant "count1" (parentbones.count as integer)
				endbone.position.controller[1].controller.x_position.controller.addconstant "initScale" initScale
				
				endbone.position.controller[1].controller.x_position.controller.script = IKscript	
				
				
				paramWire.connect ikchainpoint.baseObject.chain[#stretchval] endbone.transform.controller.FK_Sub_Control.controller.Position.controller[2].controller[#X_Position] "stretchval"

			)
			
						
			
		)
	)
		on noik pressed do
		(
			try(
			obj = $.controller.endjoint
			try(custattributes.delete $ 1)catch()
			for j in 1 to 100 do
			(
				try(orig1 = obj.position.controller[1][1].controller.getconstant "orig1")catch()
				try
				(
					
					obj.position.controller=bezier_position()
					obj.position.controller=position_xyz()	
					try(in coordsys obj.parent (obj.position.x = orig1))catch()
					orig1 = undefined
					obj = obj.parent	
				)
				catch ()
			))catch()
		)
	
)
createdialog autoIKrollout 230 270 350 300

