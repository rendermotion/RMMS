src=$Caja01;
trg=$DummyCaja01;

srctrller  = src.pos.Controller
srckey=srctrller.keys
trgctrller = trg.pos.Controller

srctrller_rot =src.rotation.Controller
trgctrller_rot=trg.rotation.Controller

i=1
for h in srckey do
	(
		t=h.time
		format "t=%i" t
		addnewkey trgctrller t
		trgctrller.x_position.keys[i].value = srctrller.x_position.keys[i].value
		trgctrller.y_position.keys[i].value = srctrller.y_position.keys[i].value
		trgctrller.z_position.keys[i].value = srctrller.z_position.keys[i].value*/
		i+=1		
	)
	
format "first for"
/*
for i=1 to (numKeys srctrller_rot) do
	(
		t=srctrller_rot.keys[i].time
		format "t=%i" t
		addnewkey trgctrller_rot t
		trgctrller_rot.x_rotation.keys[i].value = srctrller_rot.x_rotation.keys[i].value
		trgctrller_rot.y_rotation.keys[i].value = srctrller_rot.y_rotation.keys[i].value
		trgctrller_rot.z_rotation.keys[i].value = srctrller_rot.z_rotation.keys[i].value
	)*/
