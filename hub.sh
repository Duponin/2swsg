#!/usr/bin/env bash
set -e

source ./lib/text-effects.sh

printf "${WHITE}What do you want to do?${RESET} ('q' to exit)\n"
printf "\t${CYAN}1. ${YELLOW}Transform draft to article${RESET}\n"
printf "\t${CYAN}2. ${YELLOW}Generate root index${RESET}\n"
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
