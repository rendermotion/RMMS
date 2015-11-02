fn RMIsNameInFormat CurrentNameorObject=(
	if classof CurrentNameorObject==string then 
		CurrentName=CurrentNameorObject
	else 
		if CurrentNameorObject.name!= undefined do
			CurrentName=CurrentNameorObject.name
	if CurrentName!=undefined do
		(
			Tokens=filterString CurrentName "_"
			if Tokens.count==5 do
				if (Tokens[2]=="RH" or Tokens[2]=="LF" or Tokens[2]=="MD")do 
					return True
			return False 
		)
	)


fn RMstringArrayToString Arreglo Token =
	(
	N=Arreglo.count;
	Cad ="";
	for i=1 to N do 
		(
		append Cad Arreglo[i]
	    if i<N do
			append Cad Token;
		)
	return Cad;
	)

	
fn  RMGetFromName ObjName flg =
	(
	Tokens=filterString ObjName "_";
	return Tokens[flg];
	)
	
fn RMSetFromName Objname flg newToken=
(
Tokens= filterString ObjName "_";
Tokens[flg] = newToken;
return  (RMstringArrayToString Tokens "_");
)

fn RMReturnLastNumberString NameString=
	 (
		Size=NameString.count
		for i=1 to NameString.count do 
		(   
			NumberString = substring NameString (size-i+1) (-1)
			
			if (RMIsNumber NumberString == False) do
						(
						if i==1 then
								return  ""
						else 
								return substring NameString (size-i+2) (-1)
						)
		)
	 )
fn RMReturnStringWithoutNumber NameString =
(		
		Size=NameString.count
		for i=1 to Size do 
		(   
			NumberString = substring NameString (size-i+1) (-1)
			if (RMIsNumber NumberString ==False) do
						(
						   return substring NameString 1 (size-i+1)
						)
		    if i==Size do
				return ""
		)
)
fn RMIsNumber NumberString=(
	N=0
	Size=NumberString.count
	for i=1 to Size do 
	(
		if NumberString[i]!="1" and 
		   NumberString[i]!="2" and 
		NumberString[i]!="3" and 
		NumberString[i]!="4" and 
		NumberString[i]!="5" and 
		NumberString[i]!="6" and 
		NumberString[i]!="7" and 
		NumberString[i]!="8" and 
		NumberString[i]!="9" and 
		NumberString[i]!="0" do 
		N=1
	)	
		
	if N==1 then 
		return FALSE
	return TRUE
)

fn RMStringPlus1 NameString=
(
 Res=RMReturnLastNumberString NameString
 if res=="" do
    res="00"
 valor=((res as integer)+1)
 BaseName = RMReturnStringWithoutNumber NameString
 return (BaseName+(valor as string))
)
fn RMNumberToNString NumberN LengthOfString:2=(
	StringN=NumberN as string
	)

fn  RMUniqueName NewName=
(                       
    ObjectName = RMGetFromName NewName 3
	while ((getNodeByName NewName)!= Undefined) do(
        ObjectName=RMStringPlus1 ObjectName
        NewName=RMSetFromName NewName 3 ObjectName
    )
    return NewName
)

fn RMRenamer ListOfObjects NewName=(
	for i in ListOfObjects do
	(
		i.name= RMUniqueName NewName
	)
)
	
