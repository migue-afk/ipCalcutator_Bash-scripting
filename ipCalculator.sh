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

trap ctrl_c INT
function ipNetworkID(){
	ipDir="$ipDir"
	echo -e "$ipDir" > reportIP.txt
	#ipdiff=$(cat reportIP.txt | awk -F. '{print $1}' > reportIP2.txt)
	for num in $(seq 1 4) ; do
		ipdiff=$(cat reportIP.txt | awk -v n="$num" -F. '{print $n}')
		echo "obase=2;$ipdiff" | bc
	done
	#rm reportIP2.txt
}
#-----------------------------------------------
#Variables
#-----------------------------------------------

declare -i parameterCount=0

while getopts "i:" arg ;do
	case $arg in
	i) ipDir=$OPTARG;  let parameterCount+=1;;
	esac
done

if [ $parameterCount -eq 1 ]; then
	ipNetworkID $ipDir
fi


#sleep 10
