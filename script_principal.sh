#!/bin/bash

archivo="$HOME/EPNro1/salida/$FILENAME.txt"   #Ubicación del archivo.
condicion=$1 		#-d

#Se comprueba si se ingresó con parámetro -d
if [[ $condicion = "-d" ]]; then
	pkill -f "consolidar.sh" 	   	#Se mata el proceso.
	rm -r "$HOME/EPNro1"	#Borra interior EPNro1.
	echo "El entorno se eliminó y el proceso se detuvo."
	exit 0
fi

#Bucle Menú.
correr="true"
while [[ $correr == "true" ]]; do
	echo "1. Crear entorno."
	echo "2. Correr proceso."
	echo "3. Listado de Alumnos."
	echo "4. Diez notas más altas."
	echo "5. Buscar nro. padrón."
	echo "6. Visualizar Log."
	echo "7. Salir."

	read -p "Opción elegida: " opcion
	case $opcion in
		1) mkdir "$HOME/EPNro1"
		   cp "$HOME/consolidar.sh" "$HOME/EPNro1/consolidar.sh"
	   	   mkdir "$HOME/EPNro1/entrada"
		   mkdir "$HOME/EPNro1/salida"
		   mkdir "$HOME/EPNro1/procesado"
		   echo "Entorno creado" ;;

		2) bash "$HOME/EPNro1/consolidar.sh" &  #&: background
		   echo "Corriendo proceso" ;;

		3) if [[ -f $archivo ]]; then
			sort -t" " -k1,1 -n $archivo
		   else
			echo "El archivo $FILENAME no existe."
   		   fi ;;

		4) if [[ -f $archivo ]]; then
    			sort -k5,5 -n -r $archivo | head -n 10    #-r reverso. -k5 usa la columna 5 para ordenar, n (numérico). head lee las 10 prim. notas. 
                   else
                        echo "El archivo $FILENAME no existe."
                   fi ;;

		5) if [[ -f "$archivo" ]]; then
			read -p  "Ingrese un numero de padron: " PADRON
			resultado=$(grep -w "^$PADRON" "$archivo")

			if [[ -n "$resultado" ]]; then
				echo "$resultado"
			else
				echo "No se encontró el padrón $PADRON"
			fi
   		   else
			echo "El archivo $FILENAME no existe en la carpeta de salida"
		   fi ;;

		6) cat "$HOME/EPNro1/procesado.log" ;;

		7) correr="false"
		    exit 0 ;;
	esac
done
