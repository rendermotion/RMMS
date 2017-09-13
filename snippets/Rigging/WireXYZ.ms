a=selection[1]
b=selection[2]
execute ("paramWire.connect $"+b.name+".rotation.controller[#Z_Rotation] $"+a.name+".rotation.controller[#Z_Rotation] \"Z_Rotation + degtorad "+(( in coordsys gimbal a.rotation.z) as string)+" \" ")
execute ("paramWire.connect $"+b.name+".rotation.controller[#X_Rotation] $"+a.name+".rotation.controller[#X_Rotation] \"X_Rotation + degtorad "+(( in coordsys gimbal a.rotation.x) as string)+" \" ")
execute ("paramWire.connect $"+b.name+".rotation.controller[#Y_Rotation] $"+a.name+".rotation.controller[#Y_Rotation] \"Y_Rotation + degtorad "+(( in coordsys gimbal a.rotation.y) as string)+" \" ")
