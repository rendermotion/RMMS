dependsOn $Point01 $Point02

rag = (color 100 100 100)

dis = (distance $Point01 $Point02)

rag.hue = (50-dis)+90

rag.saturation=255

rag.value=255

$test_sphere.material.Diffuse=rag

[1,1,1]