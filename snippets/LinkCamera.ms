maxOps.setDefaultTangentType #step #step
maxOps.autoKeyDefaultKeyOn= false
maxOps.setKeyMode=true
PC =Position_Constraint();
RC=Orientation_Constraint();

$CameraMain.position.controller=PC
$CameraMain.rotation.controller=RC

	for i in selection do 
	(
	  
	   PC.appendTarget i 0 
	   RC.appendTarget i 0
	)
	NT=PC.getNumTargets()
	print "NT= " + (NT as string)
	classof NT
	for h = 1 to NT do
		(
		F=Bezier_Float()	
		PC.weight[h].controller=F
		RC.weight[h].controller=F
		)
	for h = 1 to NT do
	   ( 
		    for k = 1 to NT do
		   (   
			   	if k==h then 
			    (
				 at time slidertime animate on PC.weight[k] = 50
				 addNewKey PC.weight[k].controller slidertime
				 ) 
				 else 
			     (
					at time slidertime animate on PC.weight[k] = 0
				addNewKey PC.weight[k].controller slidertime
				 )
			)
		slidertime=slidertime+1
		)
	

maxOps.setDefaultTangentType #custom #custom
maxOps.autoKeyDefaultKeyOn= true

