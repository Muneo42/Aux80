#!/bin/bash

## Variables
arg=${2:-backup} # Valeur de Base
GREEN='\033[0;32m' # Green Color
RED='\033[0;31m' # Red Color
NC='\033[0m' # No Color
BOLD='\e[1m' # BOLD
NONE='\e[0m' # Plain Text


## Function
Sauvegarde()
{
	local var=${1}
	if [ ! -d "$HOME"/$var ] # Check si /log existe.
	then
		echo -e "${RED}log directory doesnt exist yet. ${GREEN}Creating...${NC}"
		mkdir "$HOME"/"$var"
	else
		echo -e "${GREEN}Saving /log files to ${arg}.${NC}"
		cp -vua "$HOME"/"$var" "$HOME"/"$arg"
		echo -e "${GREEN}DONE!${NC}"
	fi
}

Mayday()
{
	echo -e "${BOLD}NAME${NONE}"
	echo -e "\tSauvegarde de Fichier"
	echo -e "${BOLD}SYNOPSIS${NONE}"
	echo -e "\tsauvegarde.sh [OPTION]"
	echo -e "${BOLD}OPTIONS${NONE}"
	echo -e "\t-h\tpermet d'afficher cette aie et quite le logiciel"
	echo -e "\t-v\tpermet demander a sauvegarde.sh de dire ce qu'il fait"
	echo -e "\t-d\tpermet d'indiquer un autre repertoire de destination de la sauvegarde"
	echo -e "\t-s\tpermet d'indiquer un autre repertoire de souce a sauvegarder"
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
}

Dest()
{
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
	Sauvegarde "bin"
	Sauvegarde "log"
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
	
	if [ ! -d "$HOME"/"$var" ] # Check si le dossier existe.
	then
		echo -e "${RED}log directory doesnt exist!"
		exit 1
	else
		echo -e "${GREEN}Saving $var files to backup.${NC}"
		cp -vua "$HOME"/"$var" "$HOME"/backup
		echo -e "${GREEN}DONE!${NC}"
	fi
}

## Main
case $1 in
	"-h") Mayday ; exit 0;;
	"-v") Verbose ; exit 0;;
	"-d") Dest ; exit 0;;
	"-s") Src $2; exit 0;;
esac

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
		cp -vua "$HOME"/log "$HOME"/backup
fi

if [ ! -d "$HOME"/bin ] # Check si /bin existe.
	then
		mkdir "$HOME"/bin
	else
		cp -vua "$HOME"/bin "$HOME"/backup
fi
