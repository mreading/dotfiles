#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASEDIR+="/"

HOMEDIR=$HOME/

function link {
    local origin=$BASEDIR$1
    local target=$HOMEDIR$2

    if [ ! -f "$origin" ]; then
      if [ ! -d "$origin" ]; then
        echo -e "\033[0;31mERROR:\033[0m Origin $origin does not exist."; return;
      fi
    fi

    if [ ! -e "$target" ]; then
        ln -s $origin $target && echo -e "\033[0;32mADDED:\033[0m $target."
    else
        echo -e "\033[0;33mWARNING:\033[0m Target $target already exists."
    fi
}

# Remember, if you want to change the filename of any these,
# update their references in .bashrc, and .gitconfig

echo "Setting up symlinks..."

# Bash!
link shell/bashrc .bashrc
link shell/bash_profile .bash_profile
link shell/bash_prompt .bash_prompt

# Input
# link shell/inputrc .inputrc

# Vim
link vim/vimrc .vimrc
link vim/vim .vim

# Git
link git/gitconfig .gitconfig
link git/gitignore-global .gitignore-global

echo "Finished. Don't forget to restart your terminal or source ~/.bashrc!"
