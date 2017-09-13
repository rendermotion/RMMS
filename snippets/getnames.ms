F=createFile "c:/data.txt"
format("(") to:F
for i in selection do
  (
  format("$")to: F
  format(i.name as string) to: F
  format(",") to: F
  )
 format(")") to: F
close F