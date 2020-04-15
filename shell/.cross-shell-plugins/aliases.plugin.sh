# vim:syntax=sh
# vim:filetype=sh

USERPATH="$HOME/.local/bin"
EDITOR="nvim"

alias cfa="$EDITOR ~/.cross-shell-plugins/aliases.plugin.sh"
alias cfal="$EDITOR ~/.config/alacritty/alacritty.yml"
alias cfb="$EDITOR ~/.config/bspwm/bspwmrc"
alias cfc="$EDITOR ~/.config/compton.conf"
alias cff="$EDITOR ~/.config/fish/config.fish"
alias cfi="$EDITOR ~/.config/i3/config"
alias cfk="$EDITOR ~/.config/kitty/kitty.conf"
alias cfkey="$EDITOR ~/.zsh/plugins/keybindings-plugin.zsh"
alias cfn="$EDITOR ~/.config/$EDITOR/init.vim"
alias cfp="$EDITOR ~/.config/polybar/config"
alias cfr="$EDITOR ~/.config/ranger/rc.conf"
alias cfs="$EDITOR ~/.zsh/plugins.toml"
alias cfst="$EDITOR ~/.config/starship.toml"
alias cfx="$EDITOR ~/.Xresources"
alias cfz="$EDITOR ~/.zshrc"
alias cfzp="$EDITOR ~/.zprofile"

alias clock="tty-clock -c"
alias comptonr="killall -9 compton && compton --config ~/.config/compton.conf -b"

alias edit="$EDTIOR"
alias fs="fc-list : family | fzf"
#alias fs="fc-list : family | sk"
alias g.="git add ."

creategitrepo(){
	if [ -n "$1" ]; then
		curl -u 'theodorepauw' https://api.github.com/user/repos -d '{"n":"$1"}'
	fi
}

alias icat="kitty +kitten icat"
alias la="ls -a"
alias ll="ls -l"
alias lal="ls -al"
alias ls="$LS_COMMAND"
alias mkdir='mkdir -p'
alias mnt="udisksctl mount -b /dev/sda5"
alias music="ncmpcpp -s playlist -S visualizer"
alias n="neofetch"
alias own="chmod +x "
alias play="mpv --really-quiet"
alias python="python3"
alias q="exit"
alias rofia="rofi -show drun"
alias sudo="sudo "
alias vim="$EDITOR"


# FASDER ALIASES
alias a='fasder -a'        # any
alias b='fasder -e bat'
alias d='fasder -d'        # directory
alias e='fasder -sid -e $EDITOR'
alias f='fasder -f'        # file
alias j='fasder_cd -d'     # cd, same functionality as j in autojump
alias ji='fasder_cd -d -i' # cd with interactive selection
alias l='fasder -sid -e $LS_COMMAND'
alias o='a -e xdg-open'
alias s='fasder -si'       # show / search / select
#alias sd='fasder -sid'     # interactive directory selection
alias sf='fasder -sif'     # interactive file selection
#alias v="f -e $EDITOR"
# fasder tries to claim 'sd'
#unalias sd

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
#fo() {
#  local out file key
#  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
#  key=$(head -1 <<< "$out")
#  file=$(head -2 <<< "$out" | tail -1)
#  if [ -n "$file" ]; then
#    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
#  fi
#}

# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
fv() {
    [ $# -gt 0 ] && fasder -f -e ${EDITOR} "$*" && return
    local file
    file="$(fasder -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}

tv() {
	seriesdir=$HOME/videos/Series
	series=`lsd -d $seriesdir/*/ | fzf`
	echo "$seriesdir/$series"
	gnome-mpv "$(fd . -e mkv -e avi -e mp4 $seriesdir/$series | fzf)" &> /dev/null
}

# z.lua ALIASES
#alias zz='z -c'      # restrict matches to subdirs of $PWD
#alias zi='z -i'      # cd with interactive selection
#alias zf='z -I'      # use fzf to select in multiple matches
#alias zb='z -b'      # quickly cd to the parent directory

if type "rofi" &> /dev/null ; then
	alias dmenu='rofi -dmenu'
fi

decode() {
	echo "$1" | base64 -d | xclip -selection clipboard ; xclip -selection clipboard -o ; echo
}

# theme selection using wal
td() {
	dir=/usr/local/lib/python3.7/dist-packages/pywal/colorschemes/dark
	(cd "$dir" && fd .) | sk --preview 'wal -q --theme '$dir/{}' && panes' > /dev/null
}

tl() {
	dir=/usr/local/lib/python3.7/dist-packages/pywal/colorschemes/light
	(cd "$dir" && fd .) | sk --preview 'wal -q --theme '$dir/{}' && panes' > /dev/null
}

alacritty.setup() {
	# run from inside alacritty's directory
	cp target/release/alacritty "$USERPATH"
	sudo desktop-file-install extra/linux/alacritty.desktop
	sudo update-desktop-database
}

kitty.download() {
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
	    launch=n
}

kitty.setup() {
	# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
	# your PATH)
	ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/
	# Place the kitty.desktop file somewhere it can be found by the OS
	cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
	# Update the path to the kitty icon in the kitty.desktop file
	sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop
}

# Attempt at making kitty's image preview work
#if file --mime-type {} | rg -q 'image'; then
#	kitty +kitten icat {}
#else
#	echo {} is a binary file
#fi


fzfp() {
fzf --preview '
if file --mime-encoding {} | rg -q 'binary' ; then
		echo {} is a binary file
else
	 (bat --style=numbers --color=always {} ||
	  highlight -O ansi -l {} ||
	  coderay {} ||
	  rougify {} ||
	  cat {}) 2> /dev/null | head -500
fi'
}

fzf.update() {
	cd ~/.fzf && git pull && ./install
}

man() {
  env \
    LESS_TERMCAP_md=$'\e[1;36m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;40;92m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
      man "$@"
}
