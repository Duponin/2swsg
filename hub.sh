#!/usr/bin/env bash
set -e

# Text colors
LIGHT_BLUE="\033[1;34m"
ORANGE="\033[0;33m"
GREEN="\033[0;32m"
WHITE="\033[1;37m"
NC="\033[0m"

printf "${WHITE}What do you want to do?${NC} ('q' to exit)\n"
printf "\t${LIGHT_BLUE}1. ${ORANGE}Transform draft to article${NC}\n"
printf "\t${LIGHT_BLUE}2. ${ORANGE}Generate root index${NC}\n"
read USER_SELECTION 

case "$USER_SELECTION" in
"q")
    printf "All of that for nothin\'\n"
    exit 0
    ;;
1)
    ./bin/generator.sh
    ;;
2)
    ./bin/generate-site-index.sh
    ;;
esac

exit 0
