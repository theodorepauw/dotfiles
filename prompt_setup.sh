cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower

echo "ADD 'source $HOME/.purepower' >>! ~/.zshrc"

#git clone https://github.com/romkatv/powerlevel10k.git $DOTFILES/powerlevel10k
echo "ADD 'source $DOTFILES/powerlevel10k/powerlevel10k.zsh-theme' >>! $HOME/.zshrc"
