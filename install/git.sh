#!/bin/sh

# HomeBrew
if [ "$(uname)" == "Darwin" ]
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
elif [ "$(echo $(echo $(uname -a) | cut -b 1-17))" == "Linux Diskstation" ]
then
    # HomeBrew on Synology DiskStation: https://community.synology.com/enu/forum/1/post/153781 
    # Alternative: HomeBrew install script https://github.com/MrCee/Synology-Homebrew/tree/main
    echo "Linux Diskstation Brew Install"
    echo "Diskstation requires sudo to install. Please enter admin password."
    
    # Create fake ldd
    sudo install -m 755 /dev/stdin /usr/bin/ldd <<"EOF"
#!/bin/sh
[[ $(/usr/lib/libc.so.6) =~ version\ ([0-9]\.[0-9]+) ]] && echo "ldd ${BASH_REMATCH[1]}"
EOF

    # Mount /volume1/homes to /home
    sudo mkdir -p -m 755 /home
    sudo mount --bind "/volume1/homes" /home

    # Create fake /etc/os-release
    sudo install -m 755 /dev/stdin /etc/os-release <<EOF
#!/bin/sh
echo "PRETTY_NAME=\"\$(source /etc.defaults/VERSION && echo \${os_name} \${productversion}-\${buildnumber} Update \${smallfixnumber})\""
EOF

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
curl -fLo ~/.vim/colors/solarized.vim --create-dirs https://raw.githubusercontent.com/ericbn/vim-solarized/master/colors/solarized.vim


# dockutil
if [ "$(uname)" == "Darwin" ]
then
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

