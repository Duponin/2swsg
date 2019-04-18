#!/usr/bin/env bash

# Configure
set -e
source ./lib/yaml.sh
DRAFT_NAME="draft.md"
GENERATOR="pandoc"

# Load config file
create_variables ./site.yml

DRAFTS_DIR="$site_drafts"

# Text colors
LIGHT_BLUE="\033[1;34m"
ORANGE="\033[0;33m"
WHITE="\033[1;37m"
NC="\033[0m"

function list_drafts
{
    DIR_NB="$(ls -1Dv $DRAFTS_DIR | wc -l)"

    printf "${WHITE}Drafts available:${NC}\n"
    if [[ $DIR_NB = "0" ]]
    then
        printf "\t${WHITE}None${NC}\n"
    elif [[ 1 ]]
    then
        for i in $(eval echo {1..$DIR_NB}); do
            printf "\t${LIGHT_BLUE}$i\t${ORANGE}%s${NC}\n" "$(ls -1Dv $DRAFTS_DIR | head -n $i | tail -n 1)"
        done
    fi
}

function get_user_draft
{
    printf "${WHITE}Choose your draft:${NC} ('q' to exit)\n"
    read -s USER_SELECTION 
    printf "%s\n" "$USER_SELECTION"

    if [[ $USER_SELECTION = "q" || $USER_SELECTION = "Q"  ]]
    then
        printf "Exiting...\n"
        exit 1
    elif [[ 1 ]]
    then
        # Grab the draft folder
        DRAFT_ARTICLE_SELECTED="$(ls -1Dv $DRAFTS_DIR | head -n $USER_SELECTION | tail -n 1)"
        printf "${LIGHT_BLUE}Article selected is: ${ORANGE}%s\n${NC}" "$DRAFT_ARTICLE_SELECTED"
    fi
}

function remind_site_parameters
{
    printf "${WHITE}Site parameters:${NC}\n"
    printf "\t${LIGHT_BLUE}name:${ORANGE}\t\t%s${NC}\n" "$site_name"
    printf "\t${LIGHT_BLUE}domain:${ORANGE}\t\t%s${NC}\n" "$site_domain"
    printf "\t${LIGHT_BLUE}page:${ORANGE}\t\t%s${NC}\n" "$site_page"
    printf "\t${LIGHT_BLUE}order:${ORANGE}\t\t%s${NC}\n" "$site_order"
    printf "\t${LIGHT_BLUE}standalone:${ORANGE}\t%s${NC}\n" "$site_standalone"
    printf "\t${LIGHT_BLUE}date_sep:${ORANGE}\t\"%s\"${NC}\n" "$site_date_sep"
}

function generate_article_path
{
    if [[ $site_order = "day" ]]
    then
        PATH_DIR=$(echo $date | awk -F $site_date_sep '{print $1 "/" $2 "/" $3}')
    elif [[ $site_order = "month" ]]
    then
        PATH_DIR=$(echo $date | awk -F $site_date_sep '{print $1 "/" $2}')
    elif [[ $site_order = "year" ]]
    then
        PATH_DIR=$(echo $date | awk -F $site_date_sep '{print $1}')
    elif [[ $site_order = "plain"  ]]
    then
        PATH_DIR=""
    fi
}

function get_article_metadata
{
    # Test if condition are corrects
    if [[ -z $DRAFT_ARTICLE_SELECTED ]]
    then
        printf "No draft selected\n"
        exit 1
    fi

    DRAFT_PATH="$site_drafts/$DRAFT_ARTICLE_SELECTED"

    # Test if a correct file is found. If not, exit the program.
    #ls "$DRAFT_PATH/$DRAFT_NAME" 2> /dev/null || echo "No correct file found! Exiting..."; exit 1

    create_variables "$DRAFT_PATH/$DRAFT_NAME"
}

function sanitize_title
{
    SANITIZE_TITLE="$(echo $title | sed 's/\ /-/g')" # " " -> "-"
}

function create_article_directory
{
    STD_SITE_DIR="./site"
    PATH_DIR="$(echo $STD_SITE_DIR/$date/$SANITIZE_TITLE)"
    mkdir -p $(echo $PATH_DIR)
}

function transform_draft_to_article
{
    # Currently it's pandoc specific
    $GENERATOR $DRAFT_PATH/draft.md --css=./css/dark-green.css --template=./templates/html5.template -o $DRAFT_PATH/$site_page
    # Then copy draft to site
    cp -r $DRAFT_PATH/* $PATH_DIR/

}

# All the logic part is here, calling functions.
remind_site_parameters 
list_drafts
get_user_draft
get_article_metadata
generate_article_path
sanitize_title
create_article_directory
transform_draft_to_article

exit 0
