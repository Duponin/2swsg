#!/usr/bin/env bash

# Configure
set -e
source ./lib/yaml.sh
source ./lib/transform-to-html.sh
source ./lib/get-article-metadata.sh
source ./lib/text-effects.sh

# Load config file
create_variables ./config/config.yml
create_variables ./config/site.yml

DRAFTS_DIR="$site_drafts"

function list_drafts
{
    DIR_NB="$(ls -1Dv $DRAFTS_DIR | wc -l)"

    printf "${WHITE}Drafts available:${RESET}\n"
    if [[ $DIR_NB = "0" ]]
    then
        printf "\t${WHITE}None${RESET}\n"
    elif [[ 1 ]]
    then
        for i in $(eval echo {1..$DIR_NB}); do
            printf "\t${CYAN}$i\t${YELLOW}%s${RESET}\n" "$(ls -1Dv $DRAFTS_DIR | head -n $i | tail -n 1)"
        done
    fi
}

function get_user_draft
{
    printf "${WHITE}Choose your draft:${RESET} ('q' to exit)\n"
    read USER_SELECTION 

    if [[ $USER_SELECTION = "q" || $USER_SELECTION = "Q"  ]]
    then
        printf "Exiting...\n"
        exit 1
    elif [[ 1 ]]
    then
        # Grab the draft folder
        DRAFT_ARTICLE_SELECTED="$(ls -1Dv $DRAFTS_DIR | head -n $USER_SELECTION | tail -n 1)"
        printf "${CYAN}Article selected is: ${YELLOW}%s\n${RESET}" "$DRAFT_ARTICLE_SELECTED"
    fi
}

function remind_site_parameters
{
    printf "${WHITE}Site parameters:${RESET}\n"
    printf "\t${CYAN}name:${YELLOW}\t\t%s${RESET}\n" "$site_name"
    printf "\t${CYAN}domain:${YELLOW}\t\t%s${RESET}\n" "$site_domain"
    printf "\t${CYAN}page:${YELLOW}\t\t%s${RESET}\n" "$site_page"
    printf "\t${CYAN}order:${YELLOW}\t\t%s${RESET}\n" "$site_order"
    printf "\t${CYAN}standalone:${YELLOW}\t%s${RESET}\n" "$site_standalone"
    printf "\t${CYAN}date_sep:${YELLOW}\t\"%s\"${RESET}\n" "$site_date_sep"
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

function sanitize_url
{
    # According to RFC 3986, kind of
    SANITIZED_URL=$(echo $title | tr -d '[:punct:]')

    # And a little extras
    SANITIZED_URL=$(echo $SANITIZED_URL | sed 's/\ /-/g') # " " -> "-"

    echo $SANITIZED_URL
}

function create_article_directory
{
    ARTICLE_LOCATION="$(echo $site_dir/$ARTICLE_DIR/$SANITIZED_URL)"
    mkdir -p $(echo $ARTICLE_LOCATION)
}

function transform_draft_to_article
{
    transform_to_html "$DRAFT_PATH/$draft_name" "$DRAFT_PATH/$site_page" "article"
    # Then copy draft to site
    cp -r $DRAFT_PATH/* $ARTICLE_LOCATION/

}

# All the logic part is here, calling functions.
#remind_site_parameters 
list_drafts
get_user_draft
get_article_metadata "$site_drafts/$DRAFT_ARTICLE_SELECTED"
generate_article_path
sanitize_url
create_article_directory
transform_draft_to_article

printf "${GREEN}Everything goes fine.
You can find your article in the correct folder.\n"

exit 0
