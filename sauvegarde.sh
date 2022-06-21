#!/bin/bash

## Variables
WCScript=$0
WScript=${0%/*}
NScript=${0##/*/}
VERBOSE=0
BOOL=$#
DST=${2:-backup} # Valeur de Base
SRC=${4:-bin} # Valeur de Base
GREEN='\033[0;32m' # Green Color
RED='\033[0;31m' # Red Color
BLUE='\033[0;34m' # Blue Color
NC='\033[0m' # No Color
BOLD='\e[1m' # BOLD
NONE='\e[0m' # Plain Text


## Function
Sauvegarde()
{
	local var=${1}
	local arg=${2:-backup}
	if [ ! -d "$HOME"/$var ] # Check si /log existe.
	then
		echo -e "${RED}log directory doesnt exist yet. ${GREEN}Creating...${NC}"
		mkdir "$HOME"/"$var"
	else
		echo -e "${GREEN}Saving $var files to ${arg}.${NC}"
		cp -vua "$HOME"/"$var" "$HOME"/"$arg"
		echo -e "${GREEN}DONE!${NC}"
	fi
	echo "Save"
}

Sauvegarde_Silence()
{
	if [ ! -d "$HOME"/backup ] # Check si /backup existe.
		then
			if [ -e "$HOME"/backup ] # Check si un fichier backup existe.
			then
				echo -e "${RED}!!!CONFLICT!!!"
				echo -e "${RED}File Backup already exist!"
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
	echo "Silence"
}

Mayday()
{
	echo -e "${BOLD}NAME${NONE}"
	echo -e "\tSauvegarde de Fichier"
	echo -e "${BOLD}SYNOPSIS${NONE}"
	echo -e "\tsauvegarde.sh [OPTION] ou sauvegarde.sh [OPTION] [TARGET]"
	echo -e "${BOLD}OPTIONS${NONE}"
	echo -e "\t-h\tpermet d'afficher cette aie et quite le logiciel"
	echo -e "\t-v\tpermet demander a sauvegarde.sh de dire ce qu'il fait"
	echo -e "\t-d\tpermet d'indiquer un autre repertoire de destination de la sauvegarde"
	echo -e "\t-s\tpermet d'indiquer un autre repertoire de souce a sauvegarder"
}

MessagErreur()
{
	echo -e "${RED}${BOLD}sauvegarde.sh : option invalide!${NC}"
	echo -e "Saisissez <<sauvegarde.sh -h>> pour plus d'informations."
}

Verbose()
{
	if [ ! -d "$HOME"/backup ] # Check si /backup existe.
	then
		if [ -e "$HOME"/backup ] # Check si un fichier backup existe.
		then
			echo -e "${RED}!!!CONFLICT!!!"
			echo -e "${RED}File Backup already exist!"
			exit 1
		fi
		echo -e "${RED}Backup directory doesnt exist yet. ${GREEN}Creating...${NC}"
		mkdir "$HOME"/backup
		echo -e "${GREEN}DONE! Dir Created.${NC}"	
		fi	
	Sauvegarde "bin"
	Sauvegarde "log"
	echo "Verbose"
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
			echo -e "${RED}!!!CONFLICT!!!"
			echo -e "${RED}${arg} is a file!"
			exit 1
		fi
		echo -e "${RED}Backup directory doesnt exist.${NC}"
		exit 1
		fi
	if [ "$VERBOSE" = 1 ]
	then
		Sauvegarde "bin"
		Sauvegarde "log"
		shift
	else
		Sauvegarde_Silence "bin"
		Sauvegarde_Silence "log"
	fi
	echo "Destination"
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
			echo -e "${RED}!!!CONFLICT!!!"
			echo -e "${RED}File ${var} already exist!"
			exit 1
		fi
		echo -e "${RED}Backup directory doesnt exist.${NC}"
		exit 1
	fi
	if [ "$VERBOSE" = 1 ]
	then
		if [ ! -d "$HOME"/"$var" ] # Check si le dossier existe.
		then
			echo -e "${RED}log directory doesnt exist!"
			exit 1
		else
			echo -e "${GREEN}Saving $var files to backup.${NC}"
			cp -vua "$HOME"/"$var" "$HOME"/backup
			echo -e "${GREEN}DONE!${NC}"
		fi
	else
		if [ ! -d "$HOME"/"$var" ] # Check si le dossier existe.
		then
			echo -e "${RED}log directory doesnt exist!"
			exit 1
		else
			cp -vua "$HOME"/"$var" "$HOME"/backup
		fi
	fi
	echo "Source"
}

charexists()
{
	local var=$1
	shift
	if [[ "$@" =~ "$var" ]]
	then
  		VERBOSE=1
	fi
}

## Main
echo -e "${BOLD}The Script is at ${WScript} and the script name is ${NScript}${NC}"
charexists "-v" $@
echo "$VERBOSE"
if [ $BOOL = 0 ]
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
##echo -e "${RED}G${GREEN}e${BLUE}t${RED} R${GREEN}i${BLUE}c${RED}k${GREEN} R${BLUE}o${RED}l${GREEN}l${BLUE}e${RED}d${NC}"
