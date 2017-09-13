g=noisemodifier();
g.strength=[9.84252,9.84252,9.84252]
g.scale=25
g.animate=on
g.fractal=on
g.frequency=.01
g.roughness=0
g.phase.keys[1].inTangenttype=#linear
g.phase.keys[1].outTangenttype=#linear
g.phase.keys[2].inTangenttype=#linear
g.phase.keys[2].outTangenttype=#linear

setBeforeORT g.phase.controller #linear
setAfterORT g.phase.controller #linear
addmodifier $ g