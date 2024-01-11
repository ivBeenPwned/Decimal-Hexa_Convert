#!/bin/bash
#Decimal to Hexadecimal conversion

Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'

printf "${Yellow}Digite um valor: "
read v

if [[ ${#v} -ge 20 ]]; then
	echo "Espera-se menos de 20 caracteres"
	echo "Caracteres totalizados: ${#v}"
	exit
elif [[ $v =~ [^0-9] ]]; then
	echo "Somente números"
	exit
fi

result=$(
	for z in $(
		for ((i=0; ;i++)); do
			sleep 0.2
			echo $v
			v=$(( v / 16 ))
			if [[ $v == 0 ]]; then
				break
			fi
		done); do
		bc <<< "$z%16"
	done | tr "\n" " " | sed -e "s|10|a|g" -e "s|11|b|g" -e "s|12|c|g" -e "s|13|d|g" -e "s|14|e|g" -e "s|15|f|g" | tr -d " " | rev 
	) 

printf "${Green}Hex Value of $v: ${Red}0x$result"
