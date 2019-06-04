#!/usr/bin/env bash

# Install Antibody (ZSH PLUGIN MANAGER)
#! type antibody &> /dev/null && curl -sL git.io/antibody | sh -s

if [ -r ~/.zsh_plugins.txt ]; then
	antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
fi

# Vim-Plug installation
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
