#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

#(bat -pp "$HOME/.cache/wal/sequences" &)
# (cat "$HOME/.cache/wal/sequences" &)

typeset -U PATH

#eval "$(fasder --init auto)"

source <(sheldon source)
#source $HOME/.zsh_plugins.sh
eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autoload -Uz compinit
# setopt EXTENDEDGLOB
#   for dump in $HOME/.zcompdump(#qN.m1); do
#     compinit
#     if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
#       zcompile "$dump"
#     fi
#   done
# unsetopt EXTENDEDGLOB
# compinit -C

_zpcompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZDOTDIR:-$HOME}/.zcompdump
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
  # in the background as this is doesn't affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
