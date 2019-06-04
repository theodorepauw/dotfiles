#!/usr/bin/env bash
determine_install_cmd() {
	distro=`cat /etc/*-release | rg -F -m 1 ID= | cut -d'=' -f2`
	# Ubuntu/pop_OS!
	case "$distro" in 

		Ubuntu | Debian)
			install_cmd="sudo apt install"
			;;

		Fedora)
			install_cmd="sudo dnf install"
			;;

		Arch | Manjaro)
			install_cmd="sudo pacman -S"
			;;
		*)
			echo -n "You haven't added the correct command yet!"
			;;
	esac
}
	
determine_install_cmd
packages=(zsh neovim fzf alacritty ripgrep nnn)

echo "installing ${packages[@]}..."

"$install_cmd ${packages[@]}"

if type "zsh" &> /dev/null ; then
	chsh -s /usr/bin/zsh
fi

#git clone "https://github.com/clarity20/fasder"
#ln -s fasder/fasder ~/.local/bin/
