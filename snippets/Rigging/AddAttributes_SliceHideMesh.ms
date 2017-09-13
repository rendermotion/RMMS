ca=attributes HideMesh
(
parameters param rollout: HideMesh 
		(
		Objetos Type:#nodeTab tabSizeVariable:TRUE
		HideMeshParam  type:#integer ui:hidemeshspin
		)
rollout HideMesh "HideMesh"
		(
		group "Hide Mesh"
			(
			 spinner hidemeshspin "Rot Pie" range:[0,3,0] type:#integer
			)
		)
)
CustAttributes.add  $.modifiers[#AttributeHolder] ca
