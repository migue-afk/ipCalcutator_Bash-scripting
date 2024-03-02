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
function decToBinary(){
	decimal="$decimal"
	echo -e "$decimal" > report.txt
	for num in $(seq 1 4) ; do
		decBin=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
		decBins=$(echo "obase=2;$decBin" | bc);
		decBins=$(printf "%07d"$decBins)
		echo "$decBins" >> report22.txt
	#	str="$str$decBins."
	done
	#str=${str%?}
	#echo "ip Binary $str --> $(cat report.txt)"
	#echo " "

}



function networkId(){
	ipDir="$decimal"
		echo -e "$ipDir" > report.txt
		for num in $(seq 1 4) ; do
			ipBin=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
			ipBins=$(echo "obase=2;$ipBin" | bc);
			str="$str$ipBins."
		done
		str=${str%?}
		echo "ip Binary   $str --> $(cat report.txt)"

	mask="$mask"
		echo -e "$mask" > report.txt
		for num in $(seq 1 4) ; do
			ipMask=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
			ipMasks=$(echo "obase=2;$ipMask" | bc);
			strm="$strm$ipMasks."
		done
		strm=${strm%?}
		echo "mask Binary $strm -- $(cat report.txt)"
	
}
#-----------------------------------------------
#Variables
#-----------------------------------------------

declare -i parameterCount=0
declare -i secCountIp=0
declare -i secCountMs=0
str=""
strm=""

while getopts "i:m:" arg ;do
	case $arg in
	i) decimal=$OPTARG; secCountIp=1;let parameterCount+=1;;
	m) mask=$OPTARG; secCountMs=1;let parameterCount+=2;;
esac
done

if [ $parameterCount -eq 1 ]; then
	decToBinary $decimal
elif [ $parameterCount -eq 2 ];then
	maskToBinary $mask
elif [ $secCountIp -eq 1 ] && [ $secCountMs -eq 1 ]; then
	networkId $decimal $mask
else
	helpPanel
fi


#sleep 10
