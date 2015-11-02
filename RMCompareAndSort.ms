fn RMcompareNames Obj01 Obj02=(
	
	Name01=Obj01.name
	Name02=Obj02.name
	n=0
	for i=1 to Name01.count do
	(n=n+1
		if Name02.count >=i then  
		(
			if Name01[i] != Name02[i] do
			(
				if Name01[i] > Name02[i] then
					return 1
				else 
					return -1
			)
		)
		else
				return 1
	)
	print "sali"
	print n
	if n==Name02.count then
		return 0
	else 
		return -1
	)

