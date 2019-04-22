function get_article_metadata
{
    DRAFT_PATH="$1"

    # Test if a correct file is found. If not, exit the program.
    #ls "$DRAFT_PATH/$draft_name" || echo "No correct file found! Exiting..."; exit 1

    create_variables "$DRAFT_PATH/$draft_name"
}
