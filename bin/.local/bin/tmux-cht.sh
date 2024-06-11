#!/usr/bin/env bash

languages=$(echo "golang typescript javascript zsh css html lua nodejs tmux" | tr " " "\n")
core_utils=$(echo "find man tldr sed awk tr cp ls grep xargs rg ps mv less head tail cp rm cat ssh docker" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "Enter Query:" query

if echo "$languages" | grep -qs $selected; then
    tmux split-window -p 32 -h bash -c "curl cht.sh/$selected/$(echo "query" | tr " " "+") | less"
else
    # tmux split-window -p 32 -h bash -c "curl cht.sh/$selected~$query | less"
    tmux split-window -p 32 -h bash -c "curl cht.sh/$selected~$query | less"
fi
