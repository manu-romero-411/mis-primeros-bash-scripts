#!/bin/bash
## MANEJADOR DE LAS ACCIONES EN LAS APLICACIONES PARA ABRIRLAS CON LA GRÁFICA NVIDIA
## FECHA DE CREACIÓN: 26 de febrero de 2020
## FECHAS DE MODIFICACIÓN:

## FUNCIONES PRELIMINARES

function error_handler(){
  echo "[ERROR] Ha ocurrido un error."
  exit 1
}

function root_checker(){
  if [[ $(id -u) -ne 0 ]]; then
    echo "No se puede ejecutar el script porque no se cuentan con privilegios de administrador."
    error_handler
  fi
}

root_checker

## COMPROBAR SI EN EL PC HAY UNA NVIDIA 



## COMPROBAR LOS ARCHIVOS EN applications Y PONERLES SUS OPCIONES

#dirs=/usr/share/applications
#archivos="$(ls /usr/share/applications | tr " " "\n" | tr "\n" " ")"
#for i in $(ls /home/ | tr " " "\n" | tr "\n" " "); do
#	if [[ -d /home/$i/.local ]]; then
#		if [[ -d /home/$i/.local/share ]]; then
#			if [[ -d /home/$i/.local/share/applications ]]; then
#				archivos="${archivos} $(ls /home/$i/.local/share/applications | tr " " "\n" | tr "\n" " ")"
#				dirs="${dirs} /home/$i/.local/share/applications"			
#			fi
#		fi
#	fi
#done
dirs=$(pwd)
archivos=$(ls $1/*.desktop | tr " " "\n" | tr "\n" " ")

for d in $dirs; do
	echo $archivos
	for i in $archivos; do
		echo $i
		if ! grep "NoDisplay=true" "$d/$i" >/dev/null 2>&1; then
			if ! grep "discrete_gpu;cambiar_gpu;" $i; then
			
				if ! grep "Actions=" $i; then
					echo "Actions=discrete_gpu;cambiar_gpu;" >> "$d/$i"
				else
					acciones1=$(grep "Actions=" "$d/$i")
					acciones2="$(grep "Actions=" "$d/$i")discrete_gpu;cambiar_gpu;"
					sed -i s#"$acciones1"#"$acciones2"#g $i
				fi	
				echo "
				
##########$i
[Desktop Action discrete_gpu]
Name=Run with Nvidia discrete graphics card
Name[es]=Ejecutar con procesador gráfico Nvidia
Icon=nvidia-settings
Exec=$(/usr/local/bin/bumblebee-exec-generator -c $i) 

[Desktop Action cambiar_gpu]
Name=Change graphics processor for this application
Name[es]=Cambiar procesador gráfico para esta aplicación
Icon=
Exec=/usr/local/bin/bumblebee-exec-generator -n $i" >> $i		
			fi
		fi
	done 
done


## SECCIÓN 3 DEL SCRIPT

#blablablabla

exit 0
