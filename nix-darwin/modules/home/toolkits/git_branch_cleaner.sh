#!/usr/bin/env bash
set -e

HEADER="git_branch_cleaner::Select-to-EXCLUDE::[Single-Select:<Enter>||Multi-Select:<TAB>]"
branches=$(git branch | sed 's/\*/ /g')
exclude_branches="$(git branch | sed 's/\*/ /g' | fzf --header=${HEADER} --header-first --multi)"

# If no branches are selected in fzf, exit safely
if [ -z "$exclude_branches" ]; then
    echo -e "\n>>> No branches selected for exclusion. Exiting...\n"
    exit 0
fi

# Switch branch to first excluded branch
for exclude_branch in $exclude_branches
do
    git switch $exclude_branch --quiet
    echo -e "\n  * >>> Switch branch to << $exclude_branch >> \n"
    break
done

# Append not excluded branches to (to_remove_branches)
for branch in $branches
do
    is_excluded=false
    for exclude_branch in $exclude_branches
    do
        if [[ $exclude_branch == $branch ]]; then
            is_excluded=true
            break
        fi
    done

    if [[ $is_excluded == false ]]; then
        to_remove_branches+="${branch} "
    fi
done

# Delete branches of to_remove_branches
for to_remove_branch in $to_remove_branches
do
    git branch -D $to_remove_branch
done
