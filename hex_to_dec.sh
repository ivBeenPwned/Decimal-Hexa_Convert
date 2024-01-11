#!/bin/bash
#Hexadecimal to Decimal conversion

Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'

printf "${Yellow}Digite um valor: "
read -r v
v=$(echo "$v" | sed 's/[áàãâÁÀÃÂéèẽêÉÀẼÊíìĩîÍÌĨÎóòũûÓÒÕÔúùũûÚÙŨÛ]//g')

if [[ ${#v} -gt 15 ]];then
	echo "Esperado no total 15 caracteres"
	echo "Caracteres totalizados: ${#v}"
	exit
elif [[ $v =~ [^a-fA-Fx0-9] ]]; then
	echo "Somente caracteres hexadecimais"
	exit
fi

count=0

n=$(
	for z in $(
		for i in $(echo $v | sed 's/./& /g' | sed 's/0x//g'); do
			echo $i
		done
		) 
	do
	count=$(( count+1 ))
	done
	echo "$count"
)

pot=$n
final=$(for i in $(echo $v | sed 's/./& /g' | sed 's/0x//g' | sed -e "s|a|10|g" -e "s|b|11|g" -e "s|c|12|g" -e "s|d|13|g" -e "s|e|14|g" -e "s|f|15|g"); do ((pot--)) && echo "$i*16^$pot+" | tr -d "\n"; done | sed 's/.$//')

result=$(echo $final | bc)

echo -e "${Green}Dec Value of $v: ${Red}$result"
