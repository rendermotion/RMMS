if viewport.getType()==#view_camera then
	CamName=(viewport.getCamera()).name
else 
	CamName=((selection as array)[1].name)
Result=filterString CamName "_-"
if Result[2] as integer!=undefined and Result[3] as integer!=undefined do 
		animationRange = interval (Result[2] as integer) (Result[3] as integer)
