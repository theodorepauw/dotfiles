#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
(cat "$HOME/.cache/wal/sequences" &)

typeset -U PATH

eval "$(fasder --init auto)"

source $HOME/.aliases.sh
source $HOME/.keybindings.zsh
source $HOME/.zsh_plugins.sh
#source $HOME/.purepower
#SILVER=(status:black:white dir:blue:black git:green:black cmdtime:magenta:black)
#export SILVER_SHELL=$0 # bash, zsh, or fish
#eval "$(silver init)"

autoload -Uz compinit
setopt EXTENDEDGLOB
  for dump in $HOME/.zcompdump(#qN.m1); do
    compinit
    if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
      zcompile "$dump"
    fi
  done
unsetopt EXTENDEDGLOB
compinit -C

#source $HOME/.zsh-interactive-cd.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

