#!/bin/bash
carpeta_principal="$HOME/EPNro1"
carpeta_entrada="$carpeta_principal/entrada"
carpeta_salida="$carpeta_principal/salida"
carpeta_procesado="$carpeta_principal/procesado"

#bucle infinito
while true; do
	for archivo in "$carpeta_entrada"/*.txt; do
		if [[ -f "$archivo" ]]; then
     			cat "$archivo" >> "$carpeta_salida/$FILENAME.txt" 	 #datos del archivo

	     		mv "$archivo" "$carpeta_procesado/"

	    		solo_nombre=$(basename "$archivo")        #registramos la fecha, hora y el nombre del archivo
	    		fecha_hora=$(date "+%d/%m/%Y  %H:%M:%S")

			echo "$fecha_hora - Procesado archivo $solo_nombre" >> "$carpeta_principal/procesado.log"
		fi
	done

	sleep 5
done
