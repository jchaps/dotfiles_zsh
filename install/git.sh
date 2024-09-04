#/bin/sh

# HomeBrew
if [ "$(uname)" == "Darwin" ]
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
elif [ "$(echo $(echo $(uname -a) | cut -b 1-17))" == "Linux Diskstation" ]
then
    # HomeBrew on Synology DiskStation: https://community.synology.com/enu/forum/1/post/153781 
    echo "Linux Diskstation Brew Install"
    echo "Diskstation requires sudo to install. Please enter admin password."
    
    # First create fake ldd
    echo '#/bin/sh
echo "ldd 2.20"' > "$HOME/ldd"
    chmod 755 "$HOME/ldd"
    sudo chown root:root "$HOME/ldd"
    sudo mv "$HOME/ldd" /usr/bin/ldd

    # Then create /home bind
    sudo mkdir -p -m 755 /home
    sudo mount --bind "/volume1/homes" /home

    # Now install HomeBrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
# Warning: /home/linuxbrew/.linuxbrew/bin is not in your PATH.


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
curl -fLo ~/.vim/colors/solarized.vim --create-dirs https://raw.githubusercontent.com/ericbn/vim-solarized/master/colors/sol


# dockutil
if [ "$(uname)" == "Darwin" ]
curl -sL \ 
    $(curl -s https://api.github.com/repos/kcrawford/docktuil/releases/latest \
        | grep browser_download_url \
        | cut -d\" -f4 \
        | tr -d \" \
    ) \
    -o ~/docktuil.pkg

sudo installer -pkg ~/dockutil.pkg -target /

rm ~/dockutil.pkg
fi
