#!/bin/sh

# HomeBrew
if [ "$(uname)" = "Darwin" ]
then
    if ! command -v brew >/dev/null 2>&1 && confirm_step "Install Homebrew?"
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ "$(uname -a | cut -b 1-17)" = "Linux Diskstation" ]
then
    if ! command -v brew >/dev/null 2>&1 && confirm_step "Install Homebrew?"
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
    eval "$(/var/services/homes/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
# Warning: /home/linuxbrew/.linuxbrew/bin is not in your PATH.


# Font installation
if confirm_step "Install MesloLGS NF fonts?"
then
    if [ "$(uname)" = "Darwin" ]
    then
        font_dir="$HOME/Library/Fonts"
    else
        font_dir="$HOME/.local/share/fonts"
        mkdir -p "$font_dir"
    fi

    [ -f "$font_dir/MesloLGS NF Regular.ttf" ] || curl -fLo "$font_dir/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    [ -f "$font_dir/MesloLGS NF Bold.ttf" ] || curl -fLo "$font_dir/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    [ -f "$font_dir/MesloLGS NF Italic.ttf" ] || curl -fLo "$font_dir/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    [ -f "$font_dir/MesloLGS NF Bold Italic.ttf" ] || curl -fLo "$font_dir/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fi


# vim Solarized colors
if confirm_step "Install vim Solarized colorscheme?"
then
    [ -f "$HOME/.vim/colors/solarized.vim" ] || curl -fLo "$HOME/.vim/colors/solarized.vim" --create-dirs https://raw.githubusercontent.com/ericbn/vim-solarized/master/colors/solarized.vim
fi


# dockutil
# Brew version of dockutil is out of date, so it's obtained directly from GitHub releases.
if [ "$(uname)" = "Darwin" ] && ! command -v dockutil >/dev/null 2>&1 && confirm_step "Install dockutil?"
then
    curl -sL $(curl -s https://api.github.com/repos/kcrawford/dockutil/releases/latest | grep browser_download_url | cut -d \" -f4 ) -o "$HOME/dockutil.pkg"

    sudo installer -pkg ~/dockutil.pkg -target /

    rm "$HOME/dockutil.pkg"
fi

