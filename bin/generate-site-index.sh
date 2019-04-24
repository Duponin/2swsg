#!/usr/bin/env bash
set -e

# How it will work:
# 1. V List all articles
# 2. V Get metadatas
# 3. V Insert in index file
# 4. V Generate the index
# 5. Replace the old index by the new one

source lib/yaml.sh
source lib/transform-to-html.sh
source lib/get-article-metadata.sh

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
    NB_ARTICLES="$(wc -l $tmp_dir/articles-list.txt | awk '{print $1}')"
    for ((i=1; i<NB_ARTICLES+1; i++))
    do
        create_variables "$(sed "${i}q;d" $tmp_dir/articles-list.txt)"
        printf "## [%s](%s) \n" "$title" "$(sed "${i}q;d" $tmp_dir/articles-list.txt | sed "s/draft.md/${site_page}/g")" >> "$site_dir/index.md"
        printf "``` ${abstract}  ```\n" >> "$site_dir/index.md"
        printf "%s\n" "---" >> "$site_dir/index.md"
    done
    transform_to_html "${site_dir}/index.md" "${site_dir}/${site_page}" "root_index"
}

list_articles
update_index
