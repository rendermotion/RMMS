f=selection as array
inc=50/f.count
for i=1 to f.count do
	(
	f[i].rotation.controller = Euler_XYZ()
	f[i].rotation.controller = Orientation_Constraint ()
	f[i].rotation.controller.appendTarget $ControladorPlumas_Peq_03_Backwars ((50-inc*i)+ (random -inc inc))
	f[i].rotation.controller.appendTarget $ControladorPlumas_Peq_04_Backwars ((inc*i)+ (random -inc inc))
	)
