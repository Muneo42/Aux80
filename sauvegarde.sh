#!/bin/bash

GREEN='\033[0;32m' # Green Color
RED='\033[0;31m' # Red Color
NC='\033[0m' # No Color


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
		cp -rvua "$HOME"/log "$HOME"/backup
		echo -e "${GREEN}DONE!${NC}"
fi

if [ ! -d "$HOME"/bin ] # Check si /bin existe.
	then
		echo -e "${RED}bin directory doesnt exist yet. ${GREEN}    Creating...${NC}"
		mkdir "$HOME"/bin
	else
		echo -e "${GREEN}Saving /bin files to /backup.${NC}"
		cp -rvua "$HOME"/bin "$HOME"/backup
		echo -e "${GREEN}DONE!${NC}"
fi
