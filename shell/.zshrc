#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

typeset -U PATH

export SUDO_PROMPT="$(tput setaf 4)[sudo]$(tput setaf 3) password for %p:$(tput setaf 7) "


source $HOME/.aliases.sh
source $HOME/.keybindings.zsh
source $HOME/.zsh_plugins.sh
source $HOME/.purepower
source $HOME/.zsh-interactive-cd.plugin.zsh

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

if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh