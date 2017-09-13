n=0
clearSelection()
for i in objects do
(
	if ((i.scale==[1,1, 1] or i.scale==[-1,-1,-1])==False) do 
		(
		n=n+1
		print i.name
		selectMore i
		)
)
print n
if (n==0) then 
	(print "All objects are Well Scaled")
else
	(
	print "Error on the next Objects"
	for i in selection do 
		print ("\n"+i.name)
	)
	

	