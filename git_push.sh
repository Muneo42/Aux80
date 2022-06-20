#!/bin/bash

## VARIABLES
GREEN='\033[0;32m' # Green Color
RED='\033[0;31m' # Red Color
YELLOW='\033[33m' # Yellow Color
NC='\033[0m' # No Color
BOLD='\e[1m' # BOLD
NONE='\e[0m' # Plain Text

echo "Enter your message"
read message
git add *
git commit -m"${message}"
if [ -n "$(git status - porcelain)" ];
then
 echo "IT IS CLEAN"
else
 git status
 echo "Pushing data to remote server!!!"
 git push -u origin master
fi
