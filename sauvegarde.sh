#!/bin/bash

## Variables
WCScript=$0
WScript=${0%/*}
NScript=${0##/*/}
Verbose=0
Bool=$#
Dst=${2:-backup} # Valeur de Base
Src=${4:-bin} # Valeur de Base
Green='\033[0;32m' # Green Color
Red='\033[0;31m' # Red Color
Blue='\033[0;34m' # Blue Color
Nc='\033[0m' # No Color
Bold='\e[1m' # Bold
None='\e[0m' # Plain Text


## Function
Sauvegarde()
{
	local var=${1}
	local arg=${2:-backup}
	if [ ! -d "$HOME"/$var ] # Check si /log existe.
	then
		echo -e "${Red}log directory doesnt exist yet. ${Green}Creating...${Nc}"
		mkdir "$HOME"/"$var"
	else
		echo -e "${Green}Saving $var files to ${arg}.${Nc}"
		cp -vua "$HOME"/"$var" "$HOME"/"$arg"
		echo -e "${Green}DONE!${Nc}"
	fi
	#echo "Save"
}

Sauvegarde_Silence()
{
	if [ ! -d "$HOME"/backup ] # Check si /backup existe.
		then
			if [ -e "$HOME"/backup ] # Check si un fichier backup existe.
			then
				echo -e "${Red}!!!CONFLICT!!!"
				echo -e "${Red}File Backup already exist!"
				exit 1
			fi
			mkdir "$HOME"/backup
	fi
	
	if [ ! -d "$HOME"/log ] # Check si /log existe.
		then
			mkdir "$HOME"/log
		else
			cp -ua "$HOME"/log "$HOME"/backup
	fi

	if [ ! -d "$HOME"/bin ] # Check si /bin existe.
		then
			mkdir "$HOME"/bin
		else
			cp -ua "$HOME"/bin "$HOME"/backup
	fi
	#echo "Silence"
}

Mayday()
{
	echo -e "${Bold}NAME${None}"
	echo -e "\tSauvegarde de Fichier"
	echo -e "${Bold}SYNOPSIS${None}"
	echo -e "\tsauvegarde.sh [OPTION] ou sauvegarde.sh [OPTION] [TARGET]"
	echo -e "${Bold}OPTIONS${None}"
	echo -e "\t-h\tpermet d'afficher cette aie et quite le logiciel"
	echo -e "\t-v\tpermet demander a sauvegarde.sh de dire ce qu'il fait"
	echo -e "\t-d\tpermet d'indiquer un autre repertoire de destination de la sauvegarde"
	echo -e "\t-s\tpermet d'indiquer un autre repertoire de souce a sauvegarder"
}

MessagErreur()
{
	echo -e "${Red}${Bold}sauvegarde.sh : option invalide!${Nc}"
	echo -e "Saisissez <<sauvegarde.sh -h>> pour plus d'informations."
}

Verbose()
{
	if [ ! -d "$HOME"/backup ] # Check si /backup existe.
	then
		if [ -e "$HOME"/backup ] # Check si un fichier backup existe.
		then
			echo -e "${Red}!!!CONFLICT!!!"
			echo -e "${Red}File Backup already exist!"
			exit 1
		fi
		echo -e "${Red}Backup directory doesnt exist yet. ${Green}Creating...${Nc}"
		mkdir "$HOME"/backup
		echo -e "${Green}DONE! Dir Created.${Nc}"	
		fi	
	Sauvegarde "bin"
	Sauvegarde "log"
	#echo "Verbose"
}

Dest()
{
	local arg=$1
	if [ -z "$arg" ]
	then
		echo "You need to specify Dest" ; exit 1
	fi
	if [ ! -d "$HOME"/"$arg" ] # Check si /backup existe.
	then
		if [ -e "$HOME"/"$arg" ] # Check si un fichier backup existe.
		then
			echo -e "${Red}!!!CONFLICT!!!"
			echo -e "${Red}${arg} is a file!"
			exit 1
		fi
		echo -e "${Red}Backup directory doesnt exist.${Nc}"
		exit 1
		fi
	if [ "$Verbose" = 1 ]
	then
		Sauvegarde "bin"
		Sauvegarde "log"
		shift
	else
		Sauvegarde_Silence "bin"
		Sauvegarde_Silence "log"
	fi
	#echo "Destination"
}

Src()
{
	local var=$1
	if [ -z "$1" ]
	then
		echo "You need to specify Src" ; exit 1
	fi
	if [ ! -d "$HOME"/backup ] # Check si /backup existe.
	then
		if [ -e "$HOME"/backup ] # Check si un fichier backup existe.
		then
			echo -e "${Red}!!!CONFLICT!!!"
			echo -e "${Red}File ${var} already exist!"
			exit 1
		fi
		echo -e "${Red}Backup directory doesnt exist.${Nc}"
		exit 1
	fi
	if [ "$Verbose" = 1 ]
	then
		if [ ! -d "$HOME"/"$var" ] # Check si le dossier existe.
		then
			echo -e "${Red}log directory doesnt exist!"
			exit 1
		else
			echo -e "${Green}Saving $var files to backup.${Nc}"
			cp -vua "$HOME"/"$var" "$HOME"/backup
			echo -e "${Green}DONE!${Nc}"
		fi
	else
		if [ ! -d "$HOME"/"$var" ] # Check si le dossier existe.
		then
			echo -e "${Red}log directory doesnt exist!"
			exit 1
		else
			cp -vua "$HOME"/"$var" "$HOME"/backup
		fi
	fi
	#echo "Source"
}

charexists()
{
	local var=$1
	shift
	if [[ "$@" =~ "$var" ]]
	then
  		Verbose=1
	fi
}

## Main
echo -e "${Bold}The Script is at ${WScript} and the script name is ${NScript}${Nc}"
charexists "-v" $@
#echo "$Verbose"
if [ $Bool = 0 ]
then
	Sauvegarde_Silence
fi
while [ ! -z "$1" ]
do	
	case $1 in
		"-h") Mayday ;;
		"-v") Verbose;;
		"-d") Dest $2 ; shift ;;
		"-s") Src $2 ; shift ;;
		*) MessagErreur ; exit 2;;
	esac
	if [ "$1" = "-v" ]
	then
		shift
	fi
	shift
done
## Troll
##echo -e "${Red}G${Green}e${Blue}t${Red} R${Green}i${Blue}c${Red}k${Green} R${Blue}o${Red}l${Green}l${Blue}e${Red}d${Nc}"
