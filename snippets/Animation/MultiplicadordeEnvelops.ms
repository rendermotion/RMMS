mult=.11608
NBones=skinOps.GetNumberBones $.modifiers[#skin]

SkinMod=$.modifiers[#skin]

for i=1 to NBones do
(
		NCross=skinOps.getNumberCrossSections SkinMod i
	
	for f=1 to  NCross do 
	(
		AntOuterRadius=skinOps.GetOuterRadius SkinMod i f
		AntInnerRadius=skinOps.GetInnerRadius SkinMod i f
		skinOps.SetOuterRadius SkinMod i f  (AntOuterRadius *mult)
		skinOps.SetInnerRadius SkinMod  i f (AntInnerRadius*mult)
	)
)



