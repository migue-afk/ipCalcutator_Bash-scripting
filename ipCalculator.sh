#!/bin/bash
#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c (){
	echo -e "${yellowColour}\n[!]${endColour} ${redColour}Ended process\n${endColour} "
	exit 1
}

function helpPanel(){
	echo -e "${yellowColour}\n[!]${endColour} ${redColour}Help Panle\n${endColour} "
	echo -e "i) insert IP address"
	echo -e "m) insert Network Mask"
}


trap ctrl_c INT
function ipToBinary(){
	ipDir="$ipDir"
	echo -e "$ipDir" > reportIP.txt
	for num in $(seq 1 4) ; do
		ipBin=$(cat reportIP.txt | awk -v n="$num" -F. '{print $n}')
		echo "obase=2;$ipBin" | bc
	done
}

function maskToBinary(){
	mask="$mask"
	echo -e "$mask" > reportIP.txt
	for num in $(seq 1 4) ; do
		maskBin=$(cat reportIP.txt | awk -v n="$num" -F. '{print $n}')
		echo "obase=2;$maskBin" | bc
	done
}
#-----------------------------------------------
#Variables
#-----------------------------------------------

declare -i parameterCount=0

while getopts "i:m:" arg ;do
	case $arg in
	i) ipDir=$OPTARG;  let parameterCount+=1;;
	m) mask=$OPTARG; let parameterCount+=2;;
esac
done

if [ $parameterCount -eq 1 ]; then
	ipToBinary $ipDir
elif [ $parameterCount -eq 2 ];then
	maskToBinary $mask
else
	helpPanel
fi


#sleep 10
