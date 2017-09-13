ca=custAttributes.getDef $FootControl.modifiers[1].footControls
/*attributes footControls*/
/*custAttrubutes.add $FootControl.modifiers[1] ca*/

ca=attributes footControls
redefine:ca
(
parameters param rollout:footR
		(
		footRoll type:#float ui:footRollSp
		Toe type:#float ui:toeSp
		knee type:#float ui:kneeSp
		)
rollout footR "ControlPie"
		(
		local range=[-90,90,0]
		group "Controles Del Pie"
			(
			spinner footRollSp "Rot Pie" range:range
			spinner toeSp "Rot Dedos" range:range
			spinner kneeSp "Rodilla" range:range
			)
		button ResetAll "Reset All"
		on ResetAll pressed do 
			(
			footRoll=0
			Toe=0
			Knee=0
			)
		)
)