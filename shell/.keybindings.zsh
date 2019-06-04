# vim:syntax=sh
# vim:filetype=sh

bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey "^@" autosuggest-accept
bindkey "^F" autosuggest-accept
bindkey "^A" autosuggest-accept
bindkey "^U" backward-kill-line
bindkey "^Y" yank
