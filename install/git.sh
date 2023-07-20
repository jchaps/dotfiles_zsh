# HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Font installation
if [ "$(uname)" == "Darwin" ]
then
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
else
    mkdir -p ~/.local/share/fonts
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fi


# vim Solarized colors
curl --create-dirs -LJo "$DOTFILES_DIR/vim/colors/solarized.vim" https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim

# dockutil
curl -sL \ 
    $(curl -s https://api.github.com/repos/kcrawford/docktuil/releases/latest \
        | grep browser_download_url \
        | cut -d\" -f4 \
        | tr -d \" \
    ) \
    -o ~/docktuil.pkg

sudo installer -pkg ~/dockutil.pkg -target /

rm ~/dockutil.pkg
