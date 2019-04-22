#!/usr/bin/env bash

# Configure
set -e
source ./lib/yaml.sh
source ./lib/transform-to-html.sh
source ./lib/get-article-metadata.sh

# Load config file
create_variables ./config/config.yml
create_variables ./config/site.yml

DRAFTS_DIR="$site_drafts"

# Text colors
LIGHT_BLUE="\033[1;34m"
ORANGE="\033[0;33m"
GREEN="\033[0;32m"
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
        ARTICLE_DIR=$(echo $date | awk -F $site_date_sep '{print $1 "/" $2 "/" $3}')
    elif [[ $site_order = "month" ]]
    then
        ARTICLE_DIR=$(echo $date | awk -F $site_date_sep '{print $1 "/" $2}')
    elif [[ $site_order = "year" ]]
    then
        ARTICLE_DIR=$(echo $date | awk -F $site_date_sep '{print $1}')
    elif [[ $site_order = "plain"  ]]
    then
        ARTICLE_DIR=""
    fi
}

function sanitize_title
{
    SANITIZE_TITLE="$(echo $title | sed 's/\ /-/g')" # " " -> "-"
}

function create_article_directory
{
    ARTICLE_LOCATION="$(echo $site_dir/$ARTICLE_DIR/$SANITIZE_TITLE)"
    mkdir -p $(echo $ARTICLE_LOCATION)
}

function transform_draft_to_article
{
    transform_to_html "$DRAFT_PATH/$draft_name" "$DRAFT_PATH/$site_page" "article"
    # Then copy draft to site
    cp -r $DRAFT_PATH/* $ARTICLE_LOCATION/

}

# All the logic part is here, calling functions.
remind_site_parameters 
list_drafts
get_user_draft
get_article_metadata "$site_drafts/$DRAFT_ARTICLE_SELECTED"
generate_article_path
sanitize_title
create_article_directory
transform_draft_to_article

printf "${GREEN}Everything goes fine.
You can find your article in the correct folder.\n"

exit 0
