addmodifier $[2] (sliceModifier())
addmodifier $[2] (cap_holes())
$[2].modifiers[#slice].Slice_Type=2
paramwire.connect  $[1].pos.controller[#X_Position] $[2].modifiers[#slice].Slice_Plane.controller.position.controller[#X_Position]  "X_Position"
paramwire.connect $[1].pos.controller[#Y_Position] $[2].modifiers[#slice].Slice_Plane.controller.position.controller[#Y_Position]   "Y_Position"
paramwire.connect $[1].pos.controller[#Z_Position] $[2].modifiers[#slice].Slice_Plane.controller.position.controller[#Z_Position]   "Z_Position"