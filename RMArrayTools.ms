/*****************************************************/
/*Funcion que obtiene el indice en el arreglo de la cadena proporcionada
   en caso de que no exista el resultado regresado es  0*/
/*****************************************************/
--fn GetArrayNum arreglo cadena =(
fn RMGetIndexOfElementInArray SearchArray Element =(
	f=0;
	n=0;
	for i in SearchArray do 
	(
		n=n+1;
		if i==Element do 
			f=n;
	)
	return f
)
/*****************************************************/

/*Funcion que checa si existe un elemento en el arreglo*/
fn RMExistElementInArray SearchArray Element=
	(
		for eachElement in SearchArray do 
			if Element==eachElement do
				return true;
		return false;
	)