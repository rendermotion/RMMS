

interestObject=$

if interestObject.modifiers[#AttributeHolder] !=undefined do
(
	NumerodeAtrributos=custAttributes.count interestObject.modifiers[#AttributeHolder]
	print NumerodeAtrributos
	ObjectAttributes=#()
	for i=1 to NumerodeAtrributos do 
	(
		append ObjectAttributes (custAttributes.get interestObject.modifiers[#AttributeHolder] i)
		print "***************************"
		print ObjectAttributes[1]
		print (classof ObjectAttributes[1])
	)
	interestObject.modifiers[#AttributeHolder].FootParam
	
	for i=1 to  NumerodeAtrributos do 
	(
		Properties = getPropNames  ObjectAttributes[1]
		print Properties
		print(classof Properties)
		AnimController=getPropertyController  ObjectAttributes[1] Properties[1]
		print (classof AnimController)
		
	)
)