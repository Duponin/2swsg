#!/usr/bin/env sh

# How it will work:
# 1. List all articles
# 2. Get metadatas
# 3. Insert in index file
# 4. Generate the index
# 5. Replace the old index by the new one

source ./lib/yaml.sh
source ./lib/transform-to-html.sh
source ./lib/get-article-metadata.sh

# Load config file
create_variables ./config/config.yml
create_variables ./config/site.yml

if [[ ! -d "$tmp_dir" ]]; then
    mkdir -p "$tmp_dir"
fi

function list_articles
{
    find "$site_dir" -name "$draft_name" > $tmp_dir/articles-list.txt
}

function update_index
{
    
}

