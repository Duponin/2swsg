function get_article_metadata
{
    DRAFT_PATH="$1"

    # Test if a correct file is found. If not, exit the program.
    if [[ ! $(find $DRAFT_PATH -name "$draft_name") ]]; then
        printf "No correct file found! Exiting...\n"
        exit 1
    fi
    create_variables "$DRAFT_PATH/$draft_name"
}
