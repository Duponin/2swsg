#!/usr/bin/env bash
# shellcheck disable=SC2154
# shellcheck disable=SC1091

set -e

function transform_to_html
{
    SOURCE="$1"
    DESTINATION="$2"
    TYPE="$3"
    
    source ./lib/yaml.sh
    create_variables ./config/site.yml
    
    if [[ -z $site_engine ]]; then exit 1; fi
    
    case "$site_engine" in
    pandoc)
        create_variables ./config/engines/pandoc.yml
        case "$TYPE" in
            article)
                CSS="--css=$article_css"
                TEMPLATE="--template=$article_template"
                if [[ "$article_toc" = "true" ]]; then TOC="--toc"; fi
                MATH="$article_math"
            ;;
            root_index)
                CSS="--css=$root_index_css"
                TEMPLATE="--template=$root_index_template"
                if [[ "$root_index_toc" = "true" ]]; then TOC="--toc"; fi
                MATH="$root_index_math"
                # PAGETITLE='--metadata pagetitle="$site_name"'
            ;;
        esac
        # echo $PAGETITLE
        pandoc $SOURCE $CSS $TEMPLATE $TOC $MATH -o $DESTINATION
    ;;
    esac
}
