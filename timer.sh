#!/bin/bash

arg=${1:-jayjay}
argv=$2
dormir=$3
log=$HOME/log/timer.log

GREEN='\033[0;32m' # Green Color
RED='\033[0;31m' # Red Color
NC='\033[0m' # No Color
re='^[0-9]+$' # Nombre Reel

echo ""
echo "----------------------------------------"
echo ""

if [ ! -d $HOME/log ]
	then
		echo -e "${GREEN}log directory doesnt exist yet. Creating...${NC}"
		mkdir $HOME/log
		touch $log
	else
		echo -e "${GREEN}log directory exist!${NC}"
fi

if [ -z "$arg" ]
	then
		echo "NOPE First value not gucci! But its ok! :D"
		echo -e "${RED}for use : \"name\" \"dance_name\" number${NC}"
		echo ""
		echo "----------------------------------------"
		echo ""
	elif [ -z "$argv" ]
	then
		echo "NOPE Second value not gucci!"
		echo -e "${RED}for use : \"name\" \"dance_name\" number${NC}"
		echo ""
		echo "----------------------------------------"
		echo ""
		exit 1
	elif ! [[ $dormir =~ $re ]]
	then
		echo -e "${RED}Stupid boi you need to enter a number!${NC}" >&2
		echo "In the third feild!"
		echo -e "${RED}for use : \"name\" \"dance_name\" number${NC}"
		echo ""
		echo "----------------------------------------"
		echo ""
		date >> $log
		sleep $dormir 2>> $log
		echo "----------------------------------------" >> $log
		exit 1
	else
		echo -e "${GREEN}Good job! You entered value correctly!${NC}"
fi

echo ""
echo "----------------------------------------"
echo ""

first="Please wait $dormir Seconds"
second="Now you can go"
date >> $log
sleep $3 2>> $log  
echo "----------------------------------------" >> $log
echo "Hello Welcome," $arg $first
echo "The path is" $0
echo "Done!" $second "and dance the" $argv
echo ""
echo "----------------------------------------"
echo ""
