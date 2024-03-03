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
		echo "$decBins" > report2.txt
			if [ $(cat report2.txt | wc -L) -gt 8 ]; then
				id=$(echo "$(cat report2.txt | wc -L)-8" | bc)
				decBins=${decBins:$id}
			fi
		str="$str$decBins."
	done
	str=${str%?}
	echo "ip Binary $str --> $(cat report.txt)"
	#echo " "
}



function networkId(){

# Shows Ip Address (Decimal to Binary)
	decimal="$decimal"
	echo -e "$decimal" > report.txt
	for num in $(seq 1 4) ; do
		decBin=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
		decBins=$(echo "obase=2;$decBin" | bc);
		decBins=$(printf "%07d"$decBins)
		echo "$decBins" > report2.txt
			if [ $(cat report2.txt | wc -L) -gt 8 ]; then
				id=$(echo "$(cat report2.txt | wc -L)-8" | bc)
				decBins=${decBins:$id}
			fi
		str="$str$decBins."
	done
	str=${str%?}
	echo -e "\nIP Address   $str --> $(cat report.txt)"
	#echo " "

# Shows netMask in binary
	mask="$mask"
	echo -e "$mask" > report.txt
	for num in $(seq 1 4) ; do
		maskBin=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
		maskBins=$(echo "obase=2;$maskBin" | bc);
		maskBins=$(printf "%07d"$maskBins)
		echo "$maskBins" > report2.txt
			if [ $(cat report2.txt | wc -L) -gt 8 ]; then
				id=$(echo "$(cat report2.txt | wc -L)-8" | bc)
				maskBins=${maskBins:$id}
			fi
		strm="$strm$maskBins."
	done
	strm=${strm%?}
	echo "Network Mask $strm --> $(cat report.txt)"
	#echo " "

# Shows Network ID
	str=""
	echo -e "$decimal" > report.txt
	echo -e "$mask" > report2.txt
	for num in $(seq 1 4);do
		maskBin=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
		decimalBin=$(cat report2.txt | awk -v n="$num" -F. '{print $n}')
		opAND=$(echo "$(($maskBin & $decimalBin))")
		#echo "$opAND"
		strAND="$strAND$opAND."
#		echo "$decimalBin"
	done
	strAND=${strAND%?}
	echo -e "$strAND" > report.txt
	for num in $(seq 1 4);do
		netID=$(cat report.txt | awk -v n="$num" -F. '{print $n}')
		netIDBin=$(echo "obase=2;$netID" | bc)
		netIDBin=$(printf "%07d"$netIDBin)
		echo "$netIDBin" > report2.txt
		if [ $(cat report2.txt | wc -L) -gt 8 ]; then 
			idNet=$(echo "$(cat report2.txt | wc -L)-8" | bc)
			netIDBin=${netIDBin:$idNet}
		fi

		str="$str$netIDBin."	
	done
	str=${str%?}
	echo -e "\nNetwork ID   $str --> $strAND\n"


}
#-----------------------------------------------
#Variables
#-----------------------------------------------

declare -i parameterCount=0
declare -i secCountIp=0
declare -i secCountMs=0
str=""
strm=""
strAND=""
strDc=""

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
	mask="$mask"
	for num in $(seq 1 $mask);do
		strDc="$strDc 1"
	done
	echo "$strDc"
	echo "$strDc" > report.txt
	strDc=$(cat report.txt | tr -d ' ')
	strDc=$(printf "%023d"$strDc)
	echo "$strDc"
	echo "$strDc" > report.txt
			if [ $(cat report.txt | wc -L) -gt 32 ]; then
				id=$(echo "$(cat report.txt | wc -L)-32" | bc)
				strDc=${strDc:$id}
			fi
	echo "$strDc" | rev > report.txt
	echo "$(cat report.txt | cut -c 1-8)" > report2.txt
	echo "$(cat report.txt | cut -c 9-16)" >> report2.txt
	echo "$(cat report.txt | cut -c 17-24)" >> report2.txt
	echo "$(cat report.txt | cut -c 25-32)" >> report2.txt


	sleep 10


	networkId $decimal $mask
else
	helpPanel
fi


#sleep 10
