# vim:syntax=zsh
# vim:filetype=zsh

export DOTFILES=$HOME/.dots

unsetopt BEEP

# Editors
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less' 

export SUDO_PROMPT="$(tput setaf 5)[sudo]$(tput setaf 3) password for %p:$(tput setaf 7) "

#
# Language
#
if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
    export LANGUAGE='en_US.UTF-8'
fi

fpath+=~/.zfunc
# Set the list of directories that Zsh searches for programs.

# Go Env
export GOROOT=/usr/local/go
export GOPATH=$HOME/code/go

path=(
  $path
  $HOME/.local/bin
  /usr/local/{bin,bin/bin,sbin}
  $HOME/.cargo/bin
  $GOPATH/bin
  $GOROOT/bin
  $DOTFILES/scripts
)

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

#
# Less
#
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if type "fd" &> /dev/null ; then
	find_cmd="fd"
elif type "fdfind" &> /dev/null ; then
	find_cmd="fdfind"
else
	find_cmd="find"
fi
export FZF_COMPLETION_TRIGGER=',,'
export FZF_DEFAULT_COMMAND="$find_cmd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  "$find_cmd" --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  "$find_cmd" --type d --hidden --follow --exclude ".git" . "$1"
}

if type "lsd" &> /dev/null ; then
	export LS_COMMAND="lsd"
elif type "exa" &> /dev/null ; then
	export LS_COMMAND="exa"
else
	export LS_COMMAND="ls --color=auto"
fi


CGO_CXXFLAGS_ALLOW=".*" 
CGO_LDFLAGS_ALLOW=".*" 
CGO_CFLAGS_ALLOW=".*" 
