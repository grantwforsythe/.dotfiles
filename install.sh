#!/usr/bin/env bash

###################################
# This script creates symlinks from the home directory to
# any desired dotfiles in ${HOME}/dotfiles.
###################################

# error handling
set -eu

is_app_installed(){
    type "$1" &>/dev/null
}

# constants
USER=$(whoami)

# dotfiles directory
DOTFILEDIR=${HOME}/dotfiles
BUNDLE=${HOME}/.vim/bundle/

# list of FILES/folders to symlink in ${HOME}
FILES="functions aliases bash_prompt bash_profile bashrc zshrc vimrc tmux.conf gitconfig exports Xmodmap"

# check if tmux is installed
if ! is_app_installed tmux ; then
    printf "Warning: \"tmux\" command is not found. \
            Install it first.\n"
    exit 1
fi

# check if vim is installed
if ! is_app_installed vim ; then
    printf "Warning: \"vim\" is not found.\
            Install it first.\n"
    exit 2
fi

# check if zsh is installed
if ! is_app_installed zsh ; then
    printf "Warning: \"zsh\" is not found.\
            Install it first.\n"
fi

# change to the dotfiles directory
echo "Changing to the ${DOTFILEDIR} directory..."
cd ${DOTFILEDIR}
echo "...done."

# create symlinks
# NOTE: will overwrite old dotFILES
for file in ${FILES}; do
    echo "Creating symlink to $file in home directory."
    ln -sf ${DOTFILEDIR}/.${file} ${HOME}/.${file}
done

# source tmux.conf
echo "Sourcing.tmux.conf..."
tmux source-file ${HOME}/.tmux.conf
echo "...finished sourcing."

# setting up Vundle 
if [ ! -d "${BUNDLE}" ]; then
    echo "Installing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ${BUNDLE}/Vundle.vim
else
    echo "Vundle already installed."
fi

echo "Installing Vim Plugins via Vundle"
vim +PluginInstall +qall

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
