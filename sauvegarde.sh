#!/bin/bash

#Variables
GREEN='\033[0;32m' # Green Color
RED='\033[0;31m' # Red Color
NC='\033[0m' # No Color
BOLD='\e[1m' # BOLD
NONE='\e[0m' # Plain Text

#Main
if  [ $1 = "-h" ] # Option -h
	then
		echo -e "${BOLD}NAME${NONE}"
		echo -e "\tSauvegarde de Fichier"
		echo -e "${BOLD}SYNOPSIS${NONE}"
		echo -e "\tSauvegarde de Fichier Creer par moi. LOL"
		echo -e "${BOLD}DESCRIPTION${NONE}"
		echo -e "\tFor Usage : sauvegarde.sh"
		exit 0
fi

ls $HOME | grep bin
ls $HOME | grep log

echo "Checking /backup conflict."
if [ -e "$HOME"/backup ] # Check si un fichier backup existe.
	then
		echo -e "${RED}!!!CONFLICT!!!"
		echo -e "${RED}File Backup already exist!"
		exit 1
fi

if [ ! -d "$HOME"/backup ] # Check si /backup existe.
	then
		echo -e "${RED}Backup directory doesnt exist yet. ${GREEN}Creating...${NC}"
		mkdir "$HOME"/backup
		echo -e "${GREEN}DONE! Dir Created.${NC}"	
fi

if [ ! -d "$HOME"/log ] # Check si /log existe.
	then
		echo -e "${RED}log directory doesnt exist yet. ${GREEN}Creating...${NC}"
		mkdir "$HOME"/log
	else
		echo -e "${GREEN}Saving /log files to /backup.${NC}"
		cp -vua "$HOME"/log "$HOME"/backup
		echo -e "${GREEN}DONE!${NC}"
fi

if [ ! -d "$HOME"/bin ] # Check si /bin existe.
	then
		echo -e "${RED}bin directory doesnt exist yet. ${GREEN}    Creating...${NC}"
		mkdir "$HOME"/bin
	else
		echo -e "${GREEN}Saving /bin files to /backup.${NC}"
		cp -vua "$HOME"/bin "$HOME"/backup
		echo -e "${GREEN}DONE!${NC}"
fi
